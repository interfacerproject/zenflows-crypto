//ts
const keypairoomClient = () => {
    return `
# Loading the user name from data
Given my name is in a 'string' named 'username'

# Dictionary of answers given to the challenges (questions)
Given I have a 'string dictionary' named 'userChallenges'

# Single salt from the server
Given that I have a 'base64' named 'salt'  


# Hashing the user's challenges and renaming it
When I create the hash of 'userChallenges'
and I rename the 'hash' to 'userChallenges.hash'

When I append 'userChallenges.hash' to 'salt'
and I create the hash of 'salt'
and I rename the 'hash' to 'concatenatedHashes'

# secure against brute-forcing with an expensive kdf
When I create the key derivation of 'concatenatedHashes'
and I rename the 'key derivation' to 'secret seed'
and I copy 'secret seed' to 'mnemonic backup'

# Here we can use secret seed to create SKs and PKs
# When I create the dilithium key with secret 'secret seed'
# When I create the dilithium public key

# Creating the hashes of the single challenges, to OPTIONALLY help 
# regeneration of the keyring
# TODO: When I create the key derivation of each element in 'userChallenges'
#	and I rename the 'key derivation' to 'hashedBackupChallenges'
# To be stored server side with a strong limit on trials

# This prints the keyring
Then print the 'secret seed' as 'base64'
# and print the 'hashedBackupChallenges'
and print the 'mnemonic backup' as 'mnemonic'
`}

export default keypairoomClient()
