//ts
const generateKeyring = () => {
    return `
Scenario 'ecdh': Create the key
Scenario 'ethereum': Create key
Scenario 'reflow': Create the key
Scenario 'schnorr': Create the key
Scenario 'eddsa': Create the key
Scenario 'qp': Create the key

Given nothing

# Here we are creating the keys
When I create the ecdh key
When I create the ethereum key 
When I create the reflow key
When I create the schnorr key
When I create the bitcoin key
When I create the eddsa key
When I create the dilithium key

# Generating the public keys
When I create the ecdh public key
When I create the reflow public key
When I create the schnorr public key
When I create the bitcoin public key
When I create the eddsa public key

# With Ethereum the 'ethereum address' is what we want to create, rather than a public key
When I create the ethereum address
When I create the bitcoin address

When I create the dilithium public key

Then print the 'keyring'

# Then print the 'ecdh public key' 
# Then print the 'dilithium public key' 
# Then print the 'bitcoin address' 
Then print the 'reflow public key' 
Then print the 'schnorr public key' 
Then print the 'eddsa public key' 
Then print the 'ethereum address'
`}

export default generateKeyring()