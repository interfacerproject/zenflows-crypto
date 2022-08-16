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

@test "Sign GraphQL" {
    assert_file_not_empty $TMP/keyring.json
    zexe $SRC/sign_graphql ${gqljson} $TMP/keyring.json
    assert_output "${v_gqlsigned}"
    save_output $TMP/gqlsigned.json
}

@test "Verify GraphQL" {
    assert_file_not_empty $TMP/gqlsigned.json
    zexe $SRC/verify_graphql $TMP/gqlsigned.json $TMP/keyring.json
    assert_output '{"output":["1"]}'
}
