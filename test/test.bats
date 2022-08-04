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
{"userData":{"name":"Luther Blissett","email":"luther@dyne.org"}}
EOF
    zexe $SRC/keypairoomServer-6-7 $TMP/severSideSalt.json $TMP/userData.json
    assert_output '{"seedServerSideShard.HMAC":"gdwZgCQUlNE6mW53fi10xEvSlUuTXUFJhwmqIekoHlY="}'
    save_output $TMP/keypairroomSalt1.json

    cat <<EOF > $TMP/userData.json
{"userData":{"name":"Serpica Naro","email":"snaro@dyne.org"}}
EOF
    zexe $SRC/keypairoomServer-6-7 $TMP/severSideSalt.json $TMP/userData.json
    assert_output '{"seedServerSideShard.HMAC":"J+GvYL8EOCa5EFMzowGIRn9Du1+cM57wQQLSKHrugr4="}'
    save_output $TMP/keypairroomSalt2.json
}

@test "Keyring seed creation from challenges" {
    cat << EOF > $TMP/keypairroomChallengeInput.json
{"userChallenges":{"whereParentsMet":"brontolo","nameFirstPet":"pisolo","whereHomeTown":"mammolo","nameFirstTeacher":"cucciolo","nameMotherMaid":"gongolo"},"username":"JohnDoe"}
EOF
    zexe $SRC/keypairoomClient-8-9-10-11-12 \
	 $TMP/keypairroomChallengeInput.json $TMP/keypairroomSalt1.json
    assert_output "${v_keyring}"
    save_output $TMP/keyring.json

    zexe $SRC/keypairoomClient-8-9-10-11-12 \
	 $TMP/keypairroomChallengeInput.json $TMP/keypairroomSalt2.json
    assert_not_equal "$output" "${v_keyring}"
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
