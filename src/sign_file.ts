//ts
const signFile = () => {
    return `
Scenario eddsa: sign the hash of a binary file
Given I have a 'url64' named 'hashedFile'
Given I have a 'keyring'

When I create the eddsa signature of 'hashedFile'
And I create the hash of 'hashedFile'

Then print 'eddsa signature' as 'base64'
Then print 'hashedFile' as 'base64'
Then print 'hash' as 'hex'
`}

export default signFile