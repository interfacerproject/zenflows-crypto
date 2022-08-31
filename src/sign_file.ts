//ts
const signFile = () => {
    return `
Scenario eddsa: sign the hash of a binary file
Given I have a 'url64' named 'hashedFile'
Given I have a 'keyring'

When I create the hash of 'hashedFile'
and I rename 'hash' to 'signed_hash'
and I create the eddsa signature of 'signed_hash'

Then print 'eddsa signature'
and print 'signed_hash' as 'url64'
`}

export default signFile