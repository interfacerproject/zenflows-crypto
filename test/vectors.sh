# example graphql with most allowed characters used

v_keyring='{"ecdh_public_key":"BC0jW8scuKE9fpwPvr+zVGGHN5qjn6xkYoJk57EyF5Op7oOHYKASrvbQcZ/XZmZvpEphJzWp3y8RsDKgeQnyQuw=","eddsa_public_key":"BmW1a6x43P4Rae9B4hS67PhHTCUShXAGy4K8tQtUfa8L","ethereum_address":"4152bf951c86ba52cec089eae22cec506cd8b874","keyring":{"ecdh":"gHMNRNJrKavz/cqSus4qcIex/+z/5uZVStccaYpVXCY=","eddsa":"EmDKWxH78WxKzJpUvsC6RWVRDWeB4q8AceooYf7uVaRv","ethereum":"e43de93b08b950652cf154da16b3659f40709a8fd3831f2bbb6e5c054c348a7e","reflow":"whNys7dhBwmeFCaunYcqvuTCZg+rX+Sbhsylt6QuSvQ=","schnorr":"HdZR2Jwa1SMWzGghPUqeejCO8jN7LTHWUcUzMDfKucE="},"reflow_public_key":"EizwObhEBTtAOrLtJPgY7xoGrUoN4oVsIoAsuD34+tzOkrgScwQBQlxpjr1fFaehEM3XQrRM3CkizXiZYUPU8rkQ5MZOFBKosPuJk8HeTOAyFzKrJvwvMUIf5dUuGBp/CS8Wb00K02fcT3UeZ9RzW5S5KTzVXzE/aRYrx9J8YwCJpGZux//a89xJ/8y3+RMxFETGlSiuinB9w0gV2INtjgPj5nuewzJ4GfBdUuo4ghLu7LQueSX4qgd5aK4JlP3Q","schnorr_public_key":"COtDy92A0ZPzSzGj4+bX+mLe+yf03QNBg1ki9sL1UR1KUxNiMMfU0XMDoMpWBzli","seed":"arrow story season about lucky wedding weird vast verify route churn rally"}'



v_gqlsigned='{"eddsa_signature":"mNE0qdbVFKTcO0+PUqWI3We+xkb78ttXZGd378DRxoftiGrxb0LgbSZb7GcsTdtYGK4Uil9mSd/+DUcminH3CQ==","gql":"bXV0YXRpb24gewogIGNyZWF0ZUVjb25vbWljRXZlbnQoCiAgICBldmVudDogewogICAgICBhY3Rpb246ICJwcm9kdWNlIgogICAgICBwcm92aWRlcjogIjAxRldOMTJYWDdUSlgxQUZGNUtBNFdQTk45IiAjIGJvYgogICAgICByZWNlaXZlcjogIjAxRldOMTJYWDdUSlgxQUZGNUtBNFdQTk45IiAjIGJvYgogICAgICBvdXRwdXRPZjogIjAxRldOMTM2U1BETUtXV0YyM1NXUVpSTTVGIiAjIGhhcnZlc3RpbmcgYXBwbGVzIHByb2Nlc3MKICAgICAgcmVzb3VyY2VDb25mb3Jtc1RvOiAiMDFGV04xMzZZNFpaN0s5RjMxNEhRN01LUkciICMgYXBwbGUKICAgICAgcmVzb3VyY2VRdWFudGl0eTogewogICAgICAgIGhhc051bWVyaWNhbFZhbHVlOiA1MAogICAgICAgIGhhc1VuaXQ6ICIwMUZXTjEzNlM1VlBDQ1IzQjNUR1lEWUVZOSIgIyBraWxvZ3JhbQogICAgICB9CiAgICAgIGF0TG9jYXRpb246ICIwMUZXTjEzNlpBUFE1RU5CRjNGWjc5OTM1RCIgIyBib2IncyBmYXJtCiAgICAgIGhhc1BvaW50SW5UaW1lOiAiMjAyMi0wMS0wMlQwMzowNDowNVoiCiAgICB9CiAgICBuZXdJbnZlbnRvcmllZFJlc291cmNlOiB7CiAgICAgIG5hbWU6ICJib2IncyBhcHBsZXMiCiAgICAgIG5vdGU6ICJib2IncyBkZWxpc2ggYXBwbGVzIgogICAgICB0cmFja2luZ0lkZW50aWZpZXI6ICJsb3QgMTIzIgogICAgICBjdXJyZW50TG9jYXRpb246ICIwMUZXTjEzNlpBUFE1RU5CRjNGWjc5OTM1RCIgIyBib2IncyBmYXJtCiAgICAgIHN0YWdlOiAiMDFGV04xMzZYMTgzRE00M0NUV1hFU05XQUIiICMgZnJlc2gKICAgIH0KICApIHsKICAgIGVjb25vbWljRXZlbnQgewogICAgICBpZAogICAgICBhY3Rpb24ge2lkfQogICAgICBwcm92aWRlciB7aWR9CiAgICAgIHJlY2VpdmVyIHtpZH0KICAgICAgb3V0cHV0T2Yge2lkfQogICAgICByZXNvdXJjZUNvbmZvcm1zVG8ge2lkfQogICAgICByZXNvdXJjZVF1YW50aXR5IHsKICAgICAgICBoYXNOdW1lcmljYWxWYWx1ZQogICAgICAgIGhhc1VuaXQge2lkfQogICAgICB9CiAgICAgIGF0TG9jYXRpb24ge2lkfQogICAgICBoYXNQb2ludEluVGltZQogICAgfQogICAgZWNvbm9taWNSZXNvdXJjZSB7ICMgdGhpcyBpcyB0aGUgbmV3bHktY3JlYXRlZCByZXNvdXJjZQogICAgICBpZAogICAgICBuYW1lCiAgICAgIG5vdGUKICAgICAgdHJhY2tpbmdJZGVudGlmaWVyCiAgICAgIHN0YWdlIHtpZH0KICAgICAgY3VycmVudExvY2F0aW9uIHtpZH0KICAgICAgY29uZm9ybXNUbyB7aWR9CiAgICAgIHByaW1hcnlBY2NvdW50YWJsZSB7aWR9CiAgICAgIGN1c3RvZGlhbiB7aWR9CiAgICAgIGFjY291bnRpbmdRdWFudGl0eSB7CiAgICAgICAgaGFzTnVtZXJpY2FsVmFsdWUKICAgICAgICBoYXNVbml0IHtpZH0KICAgICAgfQogICAgICBvbmhhbmRRdWFudGl0eSB7CiAgICAgICAgaGFzTnVtZXJpY2FsVmFsdWUKICAgICAgICBoYXNVbml0IHtpZH0KICAgICAgfQogICAgfQogIH0KfQo=","hash":"2d596efee52fe265fed4bc652b0f2a9767702ac6e9ee50cf43d7b0fa65623bd3"}'



v_gql_query_signed='{"eddsa_signature":"ITrOY0KFI3CZeeideJ7pZb5K4rxX8Ffqt0wUnoIFIb/bWvkMoLxkLomSPSIDSPIWlXNAto7u1GtKFogJJ+qGDA==","gql":"cXVlcnkoJGZpcnN0OiBJbnQsICRhZnRlcjogSUQsICRsYXN0OiBJbnQsICRiZWZvcmU6IElELCAkZmlsdGVyOiBFY29ub21pY1Jlc291cmNlRmlsdGVyUGFyYW1zKSB7CiAgZWNvbm9taWNSZXNvdXJjZXMoZmlyc3Q6ICRmaXJzdCwgYWZ0ZXI6ICRhZnRlciwgYmVmb3JlOiAkYmVmb3JlLCBsYXN0OiAkbGFzdCwgZmlsdGVyOiAkZmlsdGVyKSB7CiAgICBwYWdlSW5mbyB7CiAgICAgIHN0YXJ0Q3Vyc29yCiAgICAgIGVuZEN1cnNvcgogICAgICBoYXNQcmV2aW91c1BhZ2UKICAgICAgaGFzTmV4dFBhZ2UKICAgICAgdG90YWxDb3VudAogICAgICBwYWdlTGltaXQKICAgIH0KICAgIGVkZ2VzIHsKICAgICAgY3Vyc29yCiAgICAgIG5vZGUgewogICAgICAgIGNvbmZvcm1zVG8gewogICAgICAgICAgaWQKICAgICAgICAgIG5hbWUKICAgICAgICB9CiAgICAgICAgY3VycmVudExvY2F0aW9uIHtpZCBuYW1lIG1hcHBhYmxlQWRkcmVzc30KICAgICAgICBpZAogICAgICAgIG5hbWUKICAgICAgICBub3RlCiAgICAgICAgbWV0YWRhdGEKICAgICAgICBva2h2CiAgICAgICAgcmVwbwogICAgICAgIHZlcnNpb24KICAgICAgICBsaWNlbnNvcgogICAgICAgIGxpY2Vuc2UKICAgICAgICBwcmltYXJ5QWNjb3VudGFibGUge2lkIG5hbWUgbm90ZX0KICAgICAgICBjdXN0b2RpYW4ge2lkIG5hbWUgbm90ZX0KICAgICAgICBhY2NvdW50aW5nUXVhbnRpdHkge2hhc1VuaXR7aWQgbGFiZWwgc3ltYm9sfSBoYXNOdW1lcmljYWxWYWx1ZX0KICAgICAgICBvbmhhbmRRdWFudGl0eSB7aGFzVW5pdHtpZCBsYWJlbCBzeW1ib2x9IGhhc051bWVyaWNhbFZhbHVlfQogICAgICB9CiAgICB9CiAgfQp9CnsgdmFyaWFibGVzOiB7IGxhc3Q6IDEwLCBmaWx0ZXI6IHsgcHJpbWFyeUFjY291bnRhYmxlOiBbIjA2MUtGRTFBQURYTkRZVFhSWVRHMDA3QTE0Il19fX0K","hash":"642c1d7d5e6b90ab459629490964c4926b713922ccae13ee199b18ee4a7bf58d"}'

gql=`mktemp`
gqljson=`mktemp`
cat <<EOF > ${gql}
mutation {
  createEconomicEvent(
    event: {
      action: "produce"
      provider: "01FWN12XX7TJX1AFF5KA4WPNN9" # bob
      receiver: "01FWN12XX7TJX1AFF5KA4WPNN9" # bob
      outputOf: "01FWN136SPDMKWWF23SWQZRM5F" # harvesting apples process
      resourceConformsTo: "01FWN136Y4ZZ7K9F314HQ7MKRG" # apple
      resourceQuantity: {
        hasNumericalValue: 50
        hasUnit: "01FWN136S5VPCCR3B3TGYDYEY9" # kilogram
      }
      atLocation: "01FWN136ZAPQ5ENBF3FZ79935D" # bob's farm
      hasPointInTime: "2022-01-02T03:04:05Z"
    }
    newInventoriedResource: {
      name: "bob's apples"
      note: "bob's delish apples"
      trackingIdentifier: "lot 123"
      currentLocation: "01FWN136ZAPQ5ENBF3FZ79935D" # bob's farm
      stage: "01FWN136X183DM43CTWXESNWAB" # fresh
    }
  ) {
    economicEvent {
      id
      action {id}
      provider {id}
      receiver {id}
      outputOf {id}
      resourceConformsTo {id}
      resourceQuantity {
        hasNumericalValue
        hasUnit {id}
      }
      atLocation {id}
      hasPointInTime
    }
    economicResource { # this is the newly-created resource
      id
      name
      note
      trackingIdentifier
      stage {id}
      currentLocation {id}
      conformsTo {id}
      primaryAccountable {id}
      custodian {id}
      accountingQuantity {
        hasNumericalValue
        hasUnit {id}
      }
      onhandQuantity {
        hasNumericalValue
        hasUnit {id}
      }
    }
  }
}
EOF


gql64=`mktemp`
cat ${gql} | base64 -w0 > ${gql64}

cat <<EOF > ${gqljson}
{"gql":"`cat ${gql64}`"}
EOF

gql2json() {
	local gql=`mktemp`
	local gql64=`mktemp`
	cat > $gql
	cat ${gql} | base64 -w0 > ${gql64}
	cat <<EOF
{"gql":"`cat ${gql64}`"}
EOF
	# clean vectors
	rm -f ${gql} ${gql64}
}

gql_mutation=`mktemp`
cat <<EOF | gql2json > ${gql_mutation}
mutation {
  createEconomicEvent(
    event: {
      action: "produce"
      provider: "01FWN12XX7TJX1AFF5KA4WPNN9" # bob
      receiver: "01FWN12XX7TJX1AFF5KA4WPNN9" # bob
      outputOf: "01FWN136SPDMKWWF23SWQZRM5F" # harvesting apples process
      resourceConformsTo: "01FWN136Y4ZZ7K9F314HQ7MKRG" # apple
      resourceQuantity: {
        hasNumericalValue: 50
        hasUnit: "01FWN136S5VPCCR3B3TGYDYEY9" # kilogram
      }
      atLocation: "01FWN136ZAPQ5ENBF3FZ79935D" # bob's farm
      hasPointInTime: "2022-01-02T03:04:05Z"
    }
    newInventoriedResource: {
      name: "bob's apples"
      note: "bob's delish apples"
      trackingIdentifier: "lot 123"
      currentLocation: "01FWN136ZAPQ5ENBF3FZ79935D" # bob's farm
      stage: "01FWN136X183DM43CTWXESNWAB" # fresh
    }
  ) {
    economicEvent {
      id
      action {id}
      provider {id}
      receiver {id}
      outputOf {id}
      resourceConformsTo {id}
      resourceQuantity {
        hasNumericalValue
        hasUnit {id}
      }
      atLocation {id}
      hasPointInTime
    }
    economicResource { # this is the newly-created resource
      id
      name
      note
      trackingIdentifier
      stage {id}
      currentLocation {id}
      conformsTo {id}
      primaryAccountable {id}
      custodian {id}
      accountingQuantity {
        hasNumericalValue
        hasUnit {id}
      }
      onhandQuantity {
        hasNumericalValue
        hasUnit {id}
      }
    }
  }
}
EOF

gql_query=`mktemp`

echo 'query($first: Int, $after: ID, $last: Int, $before: ID, $filter: EconomicResourceFilterParams) {
  economicResources(first: $first, after: $after, before: $before, last: $last, filter: $filter) {
    pageInfo {
      startCursor
      endCursor
      hasPreviousPage
      hasNextPage
      totalCount
      pageLimit
    }
    edges {
      cursor
      node {
        conformsTo {
          id
          name
        }
        currentLocation {id name mappableAddress}
        id
        name
        note
        metadata
        okhv
        repo
        version
        licensor
        license
        primaryAccountable {id name note}
        custodian {id name note}
        accountingQuantity {hasUnit{id label symbol} hasNumericalValue}
        onhandQuantity {hasUnit{id label symbol} hasNumericalValue}
      }
    }
  }
}
{ variables: { last: 10, filter: { primaryAccountable: ["061KFE1AADXNDYTXRYTG007A14"]}}}' | gql2json > ${gql_query}
