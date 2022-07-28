setup() {
    bats_require_minimum_version 1.5.0
    DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"
    SRC="$DIR/../src"
    PATH="$SRC:$PATH"
    TMP=$BATS_RUN_TMPDIR # $BATS_SUITE_TMPDIR
    load 'test_helper/bats-support/load'
    load 'test_helper/bats-assert/load'
    load 'test_helper/bats-file/load'
    load $DIR/utils.sh
    load $DIR/vectors.sh
}

# teardown() { rm -rf $TMP }

@test "Keyring seed creation from challenges" {

    ## Keypairroom
    cat << EOF > $TMP/keypairroomSalt.json
{ "seedServerSideShard.HMAC": "qf3skXnPGFMrE28UJS7S8BdT8g==" }
EOF
    cat << EOF > $TMP/keypairroomChallengeInput.json
{
  "userChallenges": {
    "whereParentsMet": "brontolo",
    "nameFirstPet": "pisolo",
    "whereHomeTown": "mammolo",
    "nameFirstTeacher": "cucciolo",
    "nameMotherMaid": "gongolo"
  },
  "username": "JohnDoe"
}
EOF

    run --separate-stderr \
	zexe ${SRC}/keypairoomClient-8-9-10-11-12 \
	$TMP/keypairroomChallengeInput.json $TMP/keypairroomSalt.json
    assert_success
    assert_output "${v_keyring}"
    echo "$output" > $TMP/keyring.json
}

@test "Sign GraphQL" {
    assert_file_not_empty $TMP/keyring.json
    run --separate-stderr \
	zexe $SRC/sign ${gqljson} $TMP/keyring.json
    assert_success
    assert_output "${v_gqlsigned}"
    echo "$output" > $TMP/gqlsigned.json
}

@test "Verify GraphQL" {
    assert_file_not_empty $TMP/gqlsigned.json
    run --separate-stderr \
	zexe $SRC/verify_graphql $TMP/gqlsigned.json $TMP/keyring.json
    assert_success
    assert_output '{"output":["1"]}'
}
