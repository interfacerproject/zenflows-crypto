# example graphql with most allowed characters used

v_keyring='{"ecdh_public_key":"BLtETYFsPsNdI49CM6Gr+bDHiPx9kBI8Kx8KZhGUY7dWA5JZKIc5TfIvDlvlMmRzqIvIerZtuGVkV3OneORk+P0=","eddsa_public_key":"GjE2zGoxDwFf3QhybuyEFmkpSkxSHR78qTf7BKMN7DLQ","ethereum_address":"8e558bf48257d9e81ebbdc21162d3752b6bc044c","keyring":{"ecdh":"zeTpg5P3DIYySLm9m6PpoFoNG8yfczJky5en8S9THbk=","eddsa":"4s9ZQ5R1XwUk253BZJjKgJqrpL83QXuHsC6gqD3G2Skq","ethereum":"32d6e4a30412391aa82b9154674797622b6b10c7454cb46735a5b1f977adb013","reflow":"7SlYV0reXh5CUAXma5w3CVk7gB6FuG+XqLBjBEQZSFo=","schnorr":"RuK803K8VAqh3BhY7iZZn+qCGDpuFpD6JZ/7IrsU+Uw="},"reflow_public_key":"DOjDjjO67zsrhv02dgOPCzsDzjeBit8rXLq5Ux6v5hPNvbMSXPyvvQCblr2r3MRkF+rzJ7aHLxwkSmAkmmNQeag3/GfVsYAboVkyBz5ApX4ilcCNNiF1SbIVoAh/7Qn1BLJ6DIlAyT18m84tU1DAs+fmRkYDgY8mk6unL48E1j1t8HcQRCRlrY0Za4h5RT2hE5aYDxX97mWj02/YleshEiNNnj2gGKwGmsFn4vWOue1WU8A5Ir4CtzfyJ12YHBhU","schnorr_public_key":"AD9usNZZzjbxubGJxivo93NzFo0IWgVTDq0uHxasGW6xdB/qzNu25gzKvpLkVBZv","seed":"popular shift crew situate hub resource loan sausage hollow denial cement gaze unique symptom shell gaze cruise stairs horror romance spare large snake world"}'


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

v_gqlsigned='{"eddsa_signature":"ccbMsCs79DFS7dAX8ly3IYjoz/bXTBI2tZmSDiVjHesrIAw24GELda/9QzEE076/XzSrzYBARDM2LU/7ipGgBA==","gql":"bXV0YXRpb257Y3JlYXRlRWNvbm9taWNFdmVudChldmVudDp7YWN0aW9uOiJwcm9kdWNlInByb3ZpZGVyOiIwMUZXTjEyWFg3VEpYMUFGRjVLQTRXUE5OOSIjYm9icmVjZWl2ZXI6IjAxRldOMTJYWDdUSlgxQUZGNUtBNFdQTk45IiNib2JvdXRwdXRPZjoiMDFGV04xMzZTUERNS1dXRjIzU1dRWlJNNUYiI2hhcnZlc3RpbmdhcHBsZXNwcm9jZXNzcmVzb3VyY2VDb25mb3Jtc1RvOiIwMUZXTjEzNlk0Wlo3SzlGMzE0SFE3TUtSRyIjYXBwbGVyZXNvdXJjZVF1YW50aXR5OntoYXNOdW1lcmljYWxWYWx1ZTo1MGhhc1VuaXQ6IjAxRldOMTM2UzVWUENDUjNCM1RHWURZRVk5IiNraWxvZ3JhbX1hdExvY2F0aW9uOiIwMUZXTjEzNlpBUFE1RU5CRjNGWjc5OTM1RCIjYm9iJ3NmYXJtaGFzUG9pbnRJblRpbWU6IjIwMjItMDEtMDJUMDM6MDQ6MDVaIn1uZXdJbnZlbnRvcmllZFJlc291cmNlOntuYW1lOiJib2Inc2FwcGxlcyJub3RlOiJib2Inc2RlbGlzaGFwcGxlcyJ0cmFja2luZ0lkZW50aWZpZXI6ImxvdDEyMyJjdXJyZW50TG9jYXRpb246IjAxRldOMTM2WkFQUTVFTkJGM0ZaNzk5MzVEIiNib2Inc2Zhcm1zdGFnZToiMDFGV04xMzZYMTgzRE00M0NUV1hFU05XQUIiI2ZyZXNofSl7ZWNvbm9taWNFdmVudHtpZGFjdGlvbntpZH1wcm92aWRlcntpZH1yZWNlaXZlcntpZH1vdXRwdXRPZntpZH1yZXNvdXJjZUNvbmZvcm1zVG97aWR9cmVzb3VyY2VRdWFudGl0eXtoYXNOdW1lcmljYWxWYWx1ZWhhc1VuaXR7aWR9fWF0TG9jYXRpb257aWR9aGFzUG9pbnRJblRpbWV9ZWNvbm9taWNSZXNvdXJjZXsjdGhpc2lzdGhlbmV3bHktY3JlYXRlZHJlc291cmNlaWRuYW1lbm90ZXRyYWNraW5nSWRlbnRpZmllcnN0YWdle2lkfWN1cnJlbnRMb2NhdGlvbntpZH1jb25mb3Jtc1Rve2lkfXByaW1hcnlBY2NvdW50YWJsZXtpZH1jdXN0b2RpYW57aWR9YWNjb3VudGluZ1F1YW50aXR5e2hhc051bWVyaWNhbFZhbHVlaGFzVW5pdHtpZH19b25oYW5kUXVhbnRpdHl7aGFzTnVtZXJpY2FsVmFsdWVoYXNVbml0e2lkfX19fX0=","hash":"c500c14caa5bff14b0f869b310c5e98ac01b26b09a943c878ce40b97f5f394f9"}'

# clean vectors
rm -f ${gql} ${gql64}

