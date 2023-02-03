//ts
const fabaccessCmd = () => {
    return `
Scenario 'eddsa': send command to a fabaccess session

Given I have the 'keyring'
Given I have a 'integer' named 'counter'
Given I have a 'string' named 'command'
Given I have a 'string' named 'service'
Given I have a 'base64' named 'token'

When I write string ':' in ':'

When I copy 'command' to 'comando completo'
When I append ':' to 'comando completo'
When I append 'counter' to 'comando completo'
When I append ':' to 'comando completo'
When I append 'token' to 'comando completo'
When I append ':' to 'comando completo'
When I append 'service' to 'comando completo'

When I create the eddsa public key

When I create the eddsa signature of 'comando completo'

Then print the 'service'
Then print the 'token'
Then print the 'command'
Then print the 'counter'
Then print the 'eddsa public key'
Then print the 'eddsa signature'
`}

export default fabaccessCmd
