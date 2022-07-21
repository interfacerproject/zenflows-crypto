//ts
const sign = () => {
    return `
Scenario eddsa: sign a graph query
Given I have a 'base64' named 'gql'
Given I have a 'keyring'
When I create the eddsa signature of 'gql'
And I create the hash of 'gql'
Then print 'eddsa signature' as 'base64'
Then print 'gql' as 'base64'
Then print 'hash' as 'hex'
`}

export default sign