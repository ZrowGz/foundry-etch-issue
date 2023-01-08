# foundry-etch-issue

# Clone the repo & install the gitmodules

# What should happen?
- This should deploy the contracts being tested & etch the code to overwrite the existing logic for those contracts. 
- It also mocks taking control of two pre-existing convex-frax vaults to be able to have their validity checked against the `vaultMap` variable stored in one of the convex contracts. 
- The implementation logic where the cloned vaults originates from is at eth mainnet address: 0x03fb8543E933624b45abdd31987548c0D9892F07
- I etch some new logic to this address.
- Calls from my test directly interact with this fine, but when the call comes from somewhere else, like the on-chain, pre-existing CloneFactory (Convex's Booster), then it uses the logic that is already actually on-chain & NOT the logic I etched to that address.

- There's two hacky ways around this:
    * First, I can just hardcode some values into the contracts before etching; ones that would have been set by the changed initializer function parameters (the last two params do not exist in real-time deployment).
    * Second option, I can go through the process of re-deploying all other contracts that interact with these & rebuilding the state to have matching variable storage (where necessary), but things like `_pid` in the booster's call to the vault initializer.

- Optimally, any logic executed at an address that was etched would be ran as if it were always that way.

- Additionally, I noticed that the state of those & any contract that interacts with it's balances are wiped. It would be dope if etching code to a contract could instead have the option to treat every contract as upgradeable & I could slip the logic in without changing state. I know that's a way bigger lift than the main issue here tho.

# Run the setup
forge test --fork-url https://eth-mainnet.g.alchemy.com/v2/<INSERT_ALCHEMY_KEY> -vvvv