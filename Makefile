-include .env

DEFAULT_ANVIL_KEY := 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
build:; forge build
test:; forge test
NETWORK_ARGS := --rpc-url http:/localhost:8545 --private-key$(DEFAULT_ANVIL_KEY) --broadcast
# if --network sepolia is used, then use sepolia stuff, otherwise anvil stuff
ifeq($(findstring --network sepolia, $(ARGS)), --network sepolia)
	NETWORK_ARGS := --rpc-url $(SEPOLIA_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv
endif
deploy::
	forge script script/DeployRaffle.s.sol:DeployRaffle $(NETWORK_ARGS)
install:; forge install Cyfrin/foundry-devops@0.2.3 --no-commit && forge install smartcontractkit/chainlink-brownie-contracts@1.2.0 --no-commit && forge install foundry-rs/forge-std@1.5.3 --no-commit && forge install transmissions11/solmate@v6 --no-commit

