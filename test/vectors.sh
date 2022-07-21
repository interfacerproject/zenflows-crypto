# example graphql with most allowed characters used


v_keyring='{"ethereum_address":"05a94ba6d94f9056e79351a8fd1dc186b737993f","keyring":{"ecdh":"B4rYTWx6UMbc2YPWRNpl4w2M6gY9jqSa637n8Kr2pPc=","eddsa":"6kqZKA5WJ6aiVh4DThcY821RVhBV8r39TyHx24zX2JKx","ethereum":"d6fe79ff70b4a8663d1ecf495a983ba6effd0392c636923dff08a0482f5e5d5f","reflow":"abYTJShT0ZBKU+ZwJlEIPNinT6TFU+unaKMEZ+u3kbs=","schnorr":"DR92VSF2l3Az1K1+LyWO13Jk1eBPmuhhPT2NbpxGgsk="},"pubkeys":{"ecdh_public_key":"BHdrWMNBRclVO1I1/iEaYjfEi5C0eEvG2GZgsCNq87qy8feZ74JEvnKK9FC07ThhJ8s4ON2ZQcLJ+8HpWMfKPww=","eddsa_public_key":"NjrWkWySCow9osq/gBqfw8yyqVAa04n+MBqHfVOCtj0=","reflow_public_key":"FwWLOfRBAoZKfykEvq26iNn2D64gvwgCfinWWZnG4HotCuomB6EB9qJ0sinpV5LNB6GdkrKU3wvYMUU+fBMX8mtR77E3x/ljbqpwwpcmjB9YtONG1peywJvRhXqhIBJSALFTXAB2Y1XtM63Uw5/CBex8zH3wXyYU6sv/ctKi5bUZ2Zzqua9Q8LMqtgLsrrB9GDKbmPT1einkXVMLX0kuJV/AOTnA57q91HKXMCvlvlKs/sr5mJ70FchdEZl0UHIV","schnorr_public_key":"EZH/DtDoGvjabyqiHwROQpt5suHlD3JiMZ7Cqv8yAWZpewOm8i5TlOq6L6eBbc/J"}}'


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
{"graphql":"`cat ${gql64}`"}
EOF

v_gqlsigned='{"eddsa_signature":"4UNmAMzk8Qi44rd72ocxbN8ijv7RtFASPX9yfHnjVrtp8kWyktyJWZZnyodeFr42GZ5rGPVAU5McaD41dW4hotqi","graphql":"bXV0YXRpb24gewogIGNyZWF0ZUVjb25vbWljRXZlbnQoCiAgICBldmVudDogewogICAgICBhY3Rpb246ICJwcm9kdWNlIgogICAgICBwcm92aWRlcjogIjAxRldOMTJYWDdUSlgxQUZGNUtBNFdQTk45IiAjIGJvYgogICAgICByZWNlaXZlcjogIjAxRldOMTJYWDdUSlgxQUZGNUtBNFdQTk45IiAjIGJvYgogICAgICBvdXRwdXRPZjogIjAxRldOMTM2U1BETUtXV0YyM1NXUVpSTTVGIiAjIGhhcnZlc3RpbmcgYXBwbGVzIHByb2Nlc3MKICAgICAgcmVzb3VyY2VDb25mb3Jtc1RvOiAiMDFGV04xMzZZNFpaN0s5RjMxNEhRN01LUkciICMgYXBwbGUKICAgICAgcmVzb3VyY2VRdWFudGl0eTogewogICAgICAgIGhhc051bWVyaWNhbFZhbHVlOiA1MAogICAgICAgIGhhc1VuaXQ6ICIwMUZXTjEzNlM1VlBDQ1IzQjNUR1lEWUVZOSIgIyBraWxvZ3JhbQogICAgICB9CiAgICAgIGF0TG9jYXRpb246ICIwMUZXTjEzNlpBUFE1RU5CRjNGWjc5OTM1RCIgIyBib2IncyBmYXJtCiAgICAgIGhhc1BvaW50SW5UaW1lOiAiMjAyMi0wMS0wMlQwMzowNDowNVoiCiAgICB9CiAgICBuZXdJbnZlbnRvcmllZFJlc291cmNlOiB7CiAgICAgIG5hbWU6ICJib2IncyBhcHBsZXMiCiAgICAgIG5vdGU6ICJib2IncyBkZWxpc2ggYXBwbGVzIgogICAgICB0cmFja2luZ0lkZW50aWZpZXI6ICJsb3QgMTIzIgogICAgICBjdXJyZW50TG9jYXRpb246ICIwMUZXTjEzNlpBUFE1RU5CRjNGWjc5OTM1RCIgIyBib2IncyBmYXJtCiAgICAgIHN0YWdlOiAiMDFGV04xMzZYMTgzRE00M0NUV1hFU05XQUIiICMgZnJlc2gKICAgIH0KICApIHsKICAgIGVjb25vbWljRXZlbnQgewogICAgICBpZAogICAgICBhY3Rpb24ge2lkfQogICAgICBwcm92aWRlciB7aWR9CiAgICAgIHJlY2VpdmVyIHtpZH0KICAgICAgb3V0cHV0T2Yge2lkfQogICAgICByZXNvdXJjZUNvbmZvcm1zVG8ge2lkfQogICAgICByZXNvdXJjZVF1YW50aXR5IHsKICAgICAgICBoYXNOdW1lcmljYWxWYWx1ZQogICAgICAgIGhhc1VuaXQge2lkfQogICAgICB9CiAgICAgIGF0TG9jYXRpb24ge2lkfQogICAgICBoYXNQb2ludEluVGltZQogICAgfQogICAgZWNvbm9taWNSZXNvdXJjZSB7ICMgdGhpcyBpcyB0aGUgbmV3bHktY3JlYXRlZCByZXNvdXJjZQogICAgICBpZAogICAgICBuYW1lCiAgICAgIG5vdGUKICAgICAgdHJhY2tpbmdJZGVudGlmaWVyCiAgICAgIHN0YWdlIHtpZH0KICAgICAgY3VycmVudExvY2F0aW9uIHtpZH0KICAgICAgY29uZm9ybXNUbyB7aWR9CiAgICAgIHByaW1hcnlBY2NvdW50YWJsZSB7aWR9CiAgICAgIGN1c3RvZGlhbiB7aWR9CiAgICAgIGFjY291bnRpbmdRdWFudGl0eSB7CiAgICAgICAgaGFzTnVtZXJpY2FsVmFsdWUKICAgICAgICBoYXNVbml0IHtpZH0KICAgICAgfQogICAgICBvbmhhbmRRdWFudGl0eSB7CiAgICAgICAgaGFzTnVtZXJpY2FsVmFsdWUKICAgICAgICBoYXNVbml0IHtpZH0KICAgICAgfQogICAgfQogIH0KfQo="}'

clean_vectors() {
    rm -f ${gql} ${gql64}
}
