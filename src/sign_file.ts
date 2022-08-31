//ts
const signFile = () => {
    return `
Scenario eddsa: sign the hash of a binary file
Given I have a 'url64' named 'hashedFile'
Given I have a 'keyring'

When I create the hash of 'hashedFile'
and I create the eddsa signature of 'hashedFile'

Then print 'eddsa signature'
# Then print 'hashedFile' as 'base64'
Then print 'hash' as 'hex'
`}

export default signFile