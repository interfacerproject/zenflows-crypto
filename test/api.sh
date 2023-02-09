#!/bin/bash

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

#
# simple shell script to test the api

conf="rngseed=hex:00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"

# eddsa public key will always be: Lotmt4Of+Ca93Jxfvqz4I+gXCJkAVA0tcaFczuyxZNs=
zenroom -c $conf -z ../../zencode/keygen.zen | tee keyring.json | jq .

query='hello world! this should be a $mutation'

cat <<EOF > query.json
{"graphql": "$(echo $query | base64)"}
EOF
zenroom -c $conf -z ../../zencode/sign_graphql.zen -a query.json -k keyring.json | tee signed_query.json | jq .

echo "Body: $query"
echo "Header: `awk -F'"' '/eddsa_signature/ {print $4}' signed_query.json`"

# TODO: continue
