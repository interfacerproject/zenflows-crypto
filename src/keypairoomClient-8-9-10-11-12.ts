//ts
const keypairoomClient = () => {
    return `

Scenario 'ecdh': Create the key
Scenario 'ethereum': Create key
Scenario 'reflow': Create the key
Scenario 'schnorr': Create the key
Scenario 'eddsa': Create the key
Scenario 'qp': Create the key


# Loading the user name from data
Given my name is in a 'string' named 'username'

# Loading the answers from 3 secret questions. The user will have to pick the 3 challenges from a list 
# and have to remember the questions - the order is not important cause Zenroom will sort alphabetically 
# the data in input
#
# NOTE: the challenges will never be communicated to the server or to anybody else!
Given I have a 'string dictionary' named 'userChallenges'

# Loading the individual challenges, in order to have them hashed 
# and the hashes OPTIONALLY stored by the server, to improve regeneration of the keypair
Given I have a 'string' named 'whereParentsMet' in 'userChallenges'
Given I have a 'string' named 'nameFirstPet' in 'userChallenges'
Given I have a 'string' named 'whereHomeTown' in 'userChallenges'
Given I have a 'string' named 'nameFirstTeacher' in 'userChallenges'
Given I have a 'string' named 'nameMotherMaid' in 'userChallenges'

# Loading the pbkdf received from the server, containing a signed hash of known data
Given that I have a 'base64' named 'seedServerSideShard.HMAC'  

When I copy 'seedServerSideShard.HMAC' to 'salt'

# Hashing the user's challenges and renaming it
When I create the key derivation of 'userChallenges' with password 'salt'

When I split the leftmost '16' bytes of 'key derivation'
When I delete the 'key derivation'
When I rename the 'leftmost' to 'seed'

# In this flow the order should NOT be changed
When I create the hash of 'seed'
When I rename the 'hash' to 'seed.root'

When I create the hash of 'seed.root'
When I rename the 'hash' to 'seed.ecdh'

When I create the hash of 'seed.ecdh'
When I rename the 'hash' to 'seed.eddsa'

When I create the hash of 'seed.eddsa'
When I rename the 'hash' to 'seed.ethereum'

When I create the hash of 'seed.ethereum'
When I rename the 'hash' to 'seed.reflow'

When I create the hash of 'seed.reflow'
When I rename the 'hash' to 'seed.schnorr'

When I create the ecdh key with secret key 'seed.ecdh'
When I create the eddsa key with secret key 'seed.eddsa'
When I create the ethereum key with secret key 'seed.ethereum'
When I create the reflow key with secret key 'seed.reflow'
When I create the schnorr key with secret key 'seed.schnorr'

When I create the ecdh public key
When I create the eddsa public key
When I create the ethereum address
When I create the reflow public key
When I create the schnorr public key


# Creating the hashes of the single challenges, to OPTIONALLY help 
# regeneration of the keypair

When I create the 'base64 dictionary'
and I rename the 'base64 dictionary' to 'hashedAnswers'

When I create the key derivation of 'whereParentsMet'
and I rename the 'key derivation' to 'whereParentsMet.kdf'
When I insert 'whereParentsMet.kdf' in 'hashedAnswers'

When I create the key derivation of 'nameFirstPet'
and I rename the 'key derivation' to 'nameFirstPet.kdf'
When I insert 'nameFirstPet.kdf' in 'hashedAnswers'

When I create the key derivation of 'whereHomeTown'
and I rename the 'key derivation' to 'whereHomeTown.kdf'
When I insert 'whereHomeTown.kdf' in 'hashedAnswers'

When I create the key derivation of 'nameFirstTeacher'
and I rename the 'key derivation' to 'nameFirstTeacher.kdf'
When I insert 'nameFirstTeacher.kdf' in 'hashedAnswers'

When I create the key derivation of 'nameMotherMaid'
and I rename the 'key derivation' to 'nameMotherMaid.kdf'
When I insert 'nameMotherMaid.kdf' in 'hashedAnswers'


# This prints the keyring
Then print the 'keyring' 

# this prints the hashes of the challenges
# Then print the 'hashedAnswers'

# This prints the seed for the private keys as mnemonic 
Then print the 'seed' as 'mnemonic'

Then print the 'ecdh public key'
Then print the 'eddsa public key'
Then print the 'ethereum address'
Then print the 'reflow public key'
Then print the 'schnorr public key'


`}

export default keypairoomClient()
