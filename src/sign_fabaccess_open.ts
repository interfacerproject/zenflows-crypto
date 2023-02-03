//ts
const fabaccessOpen = () => {
    return `
Scenario 'eddsa': open fabaccess session

Given I have the 'keyring'
Given I have a 'string' named 'timestamp'

When I write string 'OPEN' in 'command'
When I write string ':' in ':'

When I copy 'command' to 'comando completo'
When I append ':' to 'comando completo'
When I append 'timestamp' to 'comando completo'

When I create the eddsa public key

When I create the eddsa signature of 'comando completo'

Then print the 'timestamp'
Then print the 'command'
Then print the 'eddsa public key'
Then print the 'eddsa signature'
`}

export default fabaccessOpen
