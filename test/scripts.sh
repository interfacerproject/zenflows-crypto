#!/usr/bin/env bash

. test/utils.sh
. test/vectors.sh

## testzen() arguments:
## 1: zencode script
## 2: expected output
## 3: data input
## 4: keys input

## GUI
keyring=`mktemp`
testzen generateKeyring "${v_keyring}" > $keyring


## generic test
testzen byte_equal '{"output":["1"]}' '{"left":"dGhpcyBpcyBhIGJhc2U2NCBzdHJpbmcK","right":"dGhpcyBpcyBhIGJhc2U2NCBzdHJpbmcK"}'


## GUI
cat ${gqljson}
gqlsigned=`mktemp`
testzen sign ${v_gqlsigned} ${gqljson} ${keyring} > ${gqlsigned}
# testzen sign_graphql '' ${gqljson} ${keyring} > ${gqlsigned}

## SERVER
testzen verify_graphql '{"output":["VALID_SIGNATURE"]}' ${gqlsigned} ${keyring}

# cleanup tempfiles
clean_vectors
rm -f $gqlsigned
rm -f $keyring
