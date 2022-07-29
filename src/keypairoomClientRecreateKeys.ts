//ts
const keypairoomClientRecreateKeys = () => {
    return `

Scenario 'ecdh': Create the key
Scenario 'ethereum': Create key
Scenario 'reflow': Create the key
Scenario 'schnorr': Create the key
Scenario 'eddsa': Create the key

# here we load the seed as a mnemonic
Given I have a 'mnemonic' named 'seed'
and   I have a 'base64' named 'seedServerSideShard.HMAC'

When I rename 'seedServerSideShard.HMAC' to 'salt'
and I create the key derivation of 'seed' with password 'salt'
and I rename the 'key derivation' to 'seed.root'

# SKs generation
# In this flow the order should NOT be changed
When I create the  hash  of 'seed.root'
When I rename the 'hash' to 'seed.ecdh'
When I create the  hash  of 'seed.ecdh'
When I rename the 'hash' to 'seed.eddsa'
When I create the  hash  of 'seed.eddsa'
When I rename the 'hash' to 'seed.ethereum'
When I create the  hash  of 'seed.ethereum'
When I rename the 'hash' to 'seed.reflow'
When I create the  hash  of 'seed.reflow'
When I rename the 'hash' to 'seed.schnorr'

When I create the ecdh key with secret key 'seed.ecdh'
When I create the eddsa key with secret key 'seed.eddsa'
When I create the ethereum key with secret key 'seed.ethereum'
When I create the reflow key with secret key 'seed.reflow'
When I create the schnorr key with secret key 'seed.schnorr'

# PKs generation
When I create the ecdh public key
When I create the eddsa public key
When I create the ethereum address
When I create the reflow public key
When I create the schnorr public key

# This prints the keyring containing the SKs
Then print the 'keyring'

# This prints the PKs, one object each
Then print the 'ecdh public key'
Then print the 'eddsa public key'
Then print the 'ethereum address'
Then print the 'reflow public key'
Then print the 'schnorr public key'

# This prints the seed for the private keys as mnemonic 
Then print the 'seed' as 'mnemonic'


`}

export default keypairoomClientRecreateKeys()