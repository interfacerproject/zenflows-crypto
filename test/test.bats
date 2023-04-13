# SPDX-License-Identifier: AGPL-3.0-or-later
# Copyright (C) 2022-2023 Dyne.org foundation <foundation@dyne.org>.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

setup() {
    bats_require_minimum_version 1.5.0
    DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"
    SRC="$DIR/../src"
    PATH="$SRC:$PATH"
    TMP=$BATS_RUN_TMPDIR
    load 'test_helper/bats-support/load'
    load 'test_helper/bats-assert/load'
    load 'test_helper/bats-file/load'
    load $DIR/utils.sh
    load $DIR/vectors.sh
}

# teardown() { rm -rf $TMP }
@test "Zenroom is executable installed" {
    zenroom="$(which zenroom)"
    assert_file_executable "$zenroom"
}

@test "Server side shard created from user data" {
    cat <<EOF > $TMP/severSideSalt.json
{"serverSideSalt":"qf3skXnPGFMrE28UJS7S8BdT8g=="}
EOF
    cat <<EOF > $TMP/userData.json
{"userData":{"email":"luther@dyne.org"}}
EOF
    zexe $SRC/keypairoomServer-6-7 $TMP/severSideSalt.json $TMP/userData.json
    assert_output '{"seedServerSideShard.HMAC":"GWvChJgx3KQWFYgz7jVpn353Kzi3pzqK2fQjZ3+M05g="}'
    save_output $TMP/keypairroomSalt1.json

}
@test "Shard differs with a different email" {
    cat <<EOF > $TMP/userData.json
{"userData":{"email":"snaro@dyne.org"}}
EOF
    zexe $SRC/keypairoomServer-6-7 $TMP/severSideSalt.json $TMP/userData.json
    refute_output '{"seedServerSideShard.HMAC":"GWvChJgx3KQWFYgz7jVpn353Kzi3pzqK2fQjZ3+M05g="}'
    assert_output '{"seedServerSideShard.HMAC":"FdWEMKbCiRxlR05rKGfyfjVVE3jMcaYr1hgu3kTNGSk="}'
    save_output $TMP/keypairroomSalt2.json
}

@test "Keyring seed creation from answers" {
    cat << EOF > $TMP/keypairroomChallengeInput.json
{"userChallenges":{"whereParentsMet":"brontolo","nameFirstPet":"pisolo","whereHomeTown":"mammolo","nameFirstTeacher":"cucciolo","nameMotherMaid":"gongolo"},"username":"JohnDoe"}
EOF
    zexe $SRC/keypairoomClient-8-9-10-11-12 \
	 $TMP/keypairroomChallengeInput.json $TMP/keypairroomSalt1.json
    assert_output "${v_keyring}"
    save_output $TMP/keyring.json
}

@test "Keyring seed differs with same answers but different salt" {
    zexe $SRC/keypairoomClient-8-9-10-11-12 \
	 $TMP/keypairroomChallengeInput.json $TMP/keypairroomSalt2.json
    refute_output "${v_keyring}"
}


@test "Keyring seed differs with different answers but same salt" {
    cat << EOF > $TMP/keypairroomChallengeInput2.json
{"userChallenges":{"whereParentsMet":"napoli","nameFirstPet":"lucky","whereHomeTown":"rome","nameFirstTeacher":"montessori","nameMotherMaid":"yiddishemame"},"username":"serpica"}
EOF
    zexe $SRC/keypairoomClient-8-9-10-11-12 \
	 $TMP/keypairroomChallengeInput2.json $TMP/keypairroomSalt1.json
    refute_output "${v_keyring}"
}

@test "Keyring seed recovery from mnemonic" {
    zexe $SRC/keypairoomClientRecreateKeys $TMP/keyring.json  $TMP/keypairroomSalt1.json
    assert_output "${v_keyring}"
}

@test "Generate eddsa public key" {
    zexe $SRC/gen_pubkey $TMP/keyring.json
    assert_output "${v_pubkey}"
}

@test "Sign GraphQL mutation" {
    assert_file_not_empty $TMP/keyring.json
    zexe $SRC/sign_graphql ${gql_mutation} $TMP/keyring.json
    assert_output "${v_gqlsigned}"
    save_output $TMP/gqlsigned.json
}

@test "Verify GraphQL mutation" {
    assert_file_not_empty $TMP/gqlsigned.json
    zexe $SRC/verify_graphql $TMP/gqlsigned.json $TMP/keyring.json
    assert_output '{"output":["1"]}'
}


@test "Sign GraphQL query" {
    assert_file_not_empty $TMP/keyring.json
    zexe $SRC/sign_graphql ${gql_query} $TMP/keyring.json
    assert_output "${v_gql_query_signed}"
    save_output $TMP/gql_query_signed.json
}

@test "Verify GraphQL query" {
    assert_file_not_empty $TMP/gql_query_signed.json
    zexe $SRC/verify_graphql $TMP/gql_query_signed.json $TMP/keyring.json
    assert_output '{"output":["1"]}'
}

@test "Generate File" {
    cat <<EOF > $TMP/filegen.zen
Given Nothing
When I create the random object of '500' bytes
and I rename the 'random object' to 'hashedFile'
Then print the 'hashedFile' as 'url64'
EOF
    zexe $TMP/filegen
    save_output $TMP/hashfile.json
}

@test "Sign File" {
    assert_file_not_empty $TMP/keyring.json
    assert_file_not_empty $TMP/hashfile.json
    zexe $SRC/sign_file $TMP/hashfile.json $TMP/keyring.json
    assert_output '{"eddsa_signature":"26qi3PALdF9uSxxKkNViWKrVgcduxjyjFk7wtarkdbY6gNq9ZFSsTbSrbwtjjqX8gA4xBNzSDqcjbUSFcBrFMHmj","signed_hash":"kcL1WmOjEr78_zN68YwXA7FVIMj6kHU8bO0Q9w2_G5I"}'
    save_output $TMP/file_signature.json
}

@test "Conjoin Signature and Public key" {
    cat <<EOF > $TMP/conjoin_pubkey_sig.zen
Scenario eddsa
Given I have a 'eddsa signature'
and I have a 'url64' named 'signed_hash'
and I have a 'keyring'

When I create the eddsa public key

Then print the 'signed_hash'
and print the 'eddsa public key'
and print the 'eddsa signature'
EOF
    zexe $TMP/conjoin_pubkey_sig $TMP/file_signature.json $TMP/keyring.json
    save_output $TMP/pk_sig.json
}

@test "Verify File" {
   assert_file_not_empty $TMP/hashfile.json
   zexe $SRC/verify_file $TMP/hashfile.json $TMP/pk_sig.json
   assert_output '{"output":["signature_is_valid"]}'
}

@test "Sign open fabaccess session" {
    echo '{"timestamp": "12345678"}' >$TMP/timestamp.json
    assert_file_not_empty $TMP/keyring.json
    zexe $SRC/sign_fabaccess_open $TMP/timestamp.json $TMP/keyring.json
    assert_output '{"command":"OPEN","eddsa_public_key":"BmW1a6x43P4Rae9B4hS67PhHTCUShXAGy4K8tQtUfa8L","eddsa_signature":"bVcKGC9qDGgXJTvodXKTDqoBfm1rLbaYYuhKezsykr2WLm9J1dyHfEZzPNYa7ynPTG2xJmtfk14ZhjHb4pnDecF","timestamp":"12345678"}'
    save_output $TMP/fabaccess_open_signature.json
}

@test "Verify open fabaccess session" {
    zexe $SRC/verify_fabaccess_open $TMP/fabaccess_open_signature.json
    assert_output '{"output":["ok"]}'
}

@test "Sign fabaccess command" {
    echo '{"command": "CLOSE", "service": "shutdown", "timestamp": "123456", "token": "ZmFiYWNjZXNzIHRva2Vu"}' >$TMP/fab_cmd.json
    assert_file_not_empty $TMP/keyring.json
    zexe $SRC/sign_fabaccess_cmd $TMP/fab_cmd.json $TMP/keyring.json
    assert_output '{"command":"CLOSE","eddsa_public_key":"BmW1a6x43P4Rae9B4hS67PhHTCUShXAGy4K8tQtUfa8L","eddsa_signature":"2wCGyeAmaLmgkJPFdCEig5khWYmSeGrEHnnmMDS4Ysm62o544p1ucJUL7VXDX6ko6zae4NTFKtgyb2HrwtwkMpEr","service":"shutdown","timestamp":"123456","token":"ZmFiYWNjZXNzIHRva2Vu"}'
    save_output $TMP/fabaccess_cmd_signature.json
}

@test "Verify fabaccess command" {
    zexe $SRC/verify_fabaccess_cmd $TMP/fabaccess_cmd_signature.json
    assert_output '{"output":["ok"]}'
}
