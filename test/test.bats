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
assert_output '{"seedServerSideShard.HMAC":"WjryuofWthYvGKMgk24pxr6QpJDYqvmF0nMaedx9Q7U="}'
echo "$output" > $TMP/keypairroomSalt.json
}

@test "Keyring seed creation from challenges" {
    cat << EOF > $TMP/keypairroomChallengeInput.json
{"userChallenges":{"whereParentsMet":"brontolo","nameFirstPet":"pisolo","whereHomeTown":"mammolo","nameFirstTeacher":"cucciolo","nameMotherMaid":"gongolo"},"username":"JohnDoe"}
EOF
    zexe $SRC/keypairoomClient-8-9-10-11-12 \
	 $TMP/keypairroomChallengeInput.json $TMP/keypairroomSalt.json
    assert_output "${v_keyring}"
    echo "$output" > $TMP/keyring.json
}

@test "Keyring seed recovery from mnemonic" {
    zexe $SRC/keypairoomClientRecreateKeys $TMP/keyring.json
    assert_output "${v_keyring}"
}

@test "Sign GraphQL" {
    assert_file_not_empty $TMP/keyring.json
    zexe $SRC/sign_graphql ${gqljson} $TMP/keyring.json
    assert_output "${v_gqlsigned}"
    echo "$output" > $TMP/gqlsigned.json
}

@test "Verify GraphQL" {
    assert_file_not_empty $TMP/gqlsigned.json
    zexe $SRC/verify_graphql $TMP/gqlsigned.json $TMP/keyring.json
    assert_output '{"output":["1"]}'
}
