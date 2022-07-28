# example graphql with most allowed characters used

v_keyring='{"ecdh_public_key":"BDBpFGAxoHlvgtijxL6y3VK6fZvjdKXQw5K/tkW1p+ERGo4q+1x+gioEGrOlGXW4o8tUU3H8ciBRiyh/lcB51iM=","eddsa_public_key":"3PgynE9bjzdM2KTXQr5NZb2ZuPeoQuQRF2PmkvhxaCb7","ethereum_address":"e7b4216d0d9ba4ba8541b99de6c661a56b3f9e0a","hashedAnswers":{"nameFirstPet.kdf":"YIFXG0AqbxfscNAFRLBGJ7EVXlJYtPNRuSSWK0EVKb0=","nameFirstTeacher.kdf":"5Ee/cuyy6d7ykZkQrRZlbvlrgMsYG0FT7MkKUO/BgZ8=","nameMotherMaid.kdf":"3H7FD6lBJMYh4TE92eGvHebKocno/FiZmTwLS7X1bDo=","whereHomeTown.kdf":"7242404wsaHxE1Dnwfi8z/+ErW9WSfhvKV2kSaUHdKw=","whereParentsMet.kdf":"0xtxsgFeG27aMps74ZPEL1WkE82AOOTa5l3foQemPtA="},"keyring":{"ecdh":"tXhARDYqzBqYo3N8Yrse/nBbzp58/ORm5hVohDqvw/A=","eddsa":"2dUbM9jyd3CRXdXwaEBMarpyrrSxjsU9sbba52uJUvKo","ethereum":"675628e9b33ce2da3bf485a000fee63e34afe95dda8acc64210d01c9b0772454","reflow":"n38KYIK3kyZ8UqXHkRIOVdd3GwoqmvWgZ0umJddP6bY=","schnorr":"OD6ts68LPRtq72gnv9lzxjE3wlOxsv6IBuJLnXniZAQ="},"reflow_public_key":"GDUp1b+DQfe6JyY7n0B8uyslFFbuKxx3cpYTECXe1MKQywtHEdMNWiPaHoW0wqOBBmIxzlqNZWuKNclKVJew08BigoP5wJuBNd7L6BSMzsuadtC1I3s8taLnPLOPK9WLFzL8rpaS5GcCVFPO0H2NrwznIWJtSxXn8ROErmt2PxEtHrFny6sR5q424fRx9bY8CfYl9gzU0BX0iv+Peu16rYekMecsNuJtO7YyQ6lIGJx1xFFUcHNPnjSQNTLLOayp","schnorr_public_key":"GcXJAEH8mxIzzNT64jwxo17ZIUbAvK6++CTPeJRDcEl9hQ8G+OXEu9Ex7w4ezktz","seed":"novel wood chuckle item hurt perfect peasant file remove slim stomach dance globe ill rib tape use visa season thrive spider onion there pair"}'

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


v_gqlsigned='{"eddsa_signature":"ZtNUgh9aPqZRZtLtZ95ssCBxq8ISnTD1k3ZG2wWm1RLh/Ki6aVO+CQMl3PSXBFzQIMOfGYiq2wKxoyXJX9rZBg==","gql":"bXV0YXRpb257Y3JlYXRlRWNvbm9taWNFdmVudChldmVudDp7YWN0aW9uOiJwcm9kdWNlInByb3ZpZGVyOiIwMUZXTjEyWFg3VEpYMUFGRjVLQTRXUE5OOSIjYm9icmVjZWl2ZXI6IjAxRldOMTJYWDdUSlgxQUZGNUtBNFdQTk45IiNib2JvdXRwdXRPZjoiMDFGV04xMzZTUERNS1dXRjIzU1dRWlJNNUYiI2hhcnZlc3RpbmdhcHBsZXNwcm9jZXNzcmVzb3VyY2VDb25mb3Jtc1RvOiIwMUZXTjEzNlk0Wlo3SzlGMzE0SFE3TUtSRyIjYXBwbGVyZXNvdXJjZVF1YW50aXR5OntoYXNOdW1lcmljYWxWYWx1ZTo1MGhhc1VuaXQ6IjAxRldOMTM2UzVWUENDUjNCM1RHWURZRVk5IiNraWxvZ3JhbX1hdExvY2F0aW9uOiIwMUZXTjEzNlpBUFE1RU5CRjNGWjc5OTM1RCIjYm9iJ3NmYXJtaGFzUG9pbnRJblRpbWU6IjIwMjItMDEtMDJUMDM6MDQ6MDVaIn1uZXdJbnZlbnRvcmllZFJlc291cmNlOntuYW1lOiJib2Inc2FwcGxlcyJub3RlOiJib2Inc2RlbGlzaGFwcGxlcyJ0cmFja2luZ0lkZW50aWZpZXI6ImxvdDEyMyJjdXJyZW50TG9jYXRpb246IjAxRldOMTM2WkFQUTVFTkJGM0ZaNzk5MzVEIiNib2Inc2Zhcm1zdGFnZToiMDFGV04xMzZYMTgzRE00M0NUV1hFU05XQUIiI2ZyZXNofSl7ZWNvbm9taWNFdmVudHtpZGFjdGlvbntpZH1wcm92aWRlcntpZH1yZWNlaXZlcntpZH1vdXRwdXRPZntpZH1yZXNvdXJjZUNvbmZvcm1zVG97aWR9cmVzb3VyY2VRdWFudGl0eXtoYXNOdW1lcmljYWxWYWx1ZWhhc1VuaXR7aWR9fWF0TG9jYXRpb257aWR9aGFzUG9pbnRJblRpbWV9ZWNvbm9taWNSZXNvdXJjZXsjdGhpc2lzdGhlbmV3bHktY3JlYXRlZHJlc291cmNlaWRuYW1lbm90ZXRyYWNraW5nSWRlbnRpZmllcnN0YWdle2lkfWN1cnJlbnRMb2NhdGlvbntpZH1jb25mb3Jtc1Rve2lkfXByaW1hcnlBY2NvdW50YWJsZXtpZH1jdXN0b2RpYW57aWR9YWNjb3VudGluZ1F1YW50aXR5e2hhc051bWVyaWNhbFZhbHVlaGFzVW5pdHtpZH19b25oYW5kUXVhbnRpdHl7aGFzTnVtZXJpY2FsVmFsdWVoYXNVbml0e2lkfX19fX0=","hash":"c500c14caa5bff14b0f869b310c5e98ac01b26b09a943c878ce40b97f5f394f9"}'

# clean vectors
rm -f ${gql} ${gql64}

