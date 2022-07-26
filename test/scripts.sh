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

## Keypairroom
cat << EOF > keypairroomSalt.json
{ "salt": "qf3skXnPGFMrE28UJS7S8BdT8g==" }
EOF
cat << EOF > keypairroomChallengeInput.json
{
  "userChallenges": {
    "question1": "brontolo",
    "question2": "pisolo",
    "question3": "mammolo",
    "question4": "cucciolo",
    "question5": "gongolo"
  },
  "username": "JohnDoe"
}
EOF
testzen keypairoomClient '{"mnemonic_backup":"goat fantasy apart warfare toilet purse that extend merge robot debris rice what side nephew true awake silk jazz drill mix idle girl focus","secret_seed":"ZApgKXuOPV03+oeLd2Th3J+dj+UXShA5Ed2heODhWJI="}' keypairroomChallengeInput.json keypairroomSalt.json



# cleanup tempfiles
clean_vectors
rm -f $gqlsigned
rm -f $keyring
