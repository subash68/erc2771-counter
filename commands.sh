forge create src/TrustedForwarder.sol:TrustedForwarder --rpc-url $RPC_URL \
    --private-key $PRIVATE_KEY \
    --broadcast \
    --etherscan-api-key $ETHERSCAN_API_KEY \
    --verify \
    --constructor-args "Trusted Forwarder"

forge create src/Counter.sol:Counter --rpc-url $RPC_URL \
    --private-key $PRIVATE_KEY \
    --broadcast \
    --etherscan-api-key $ETHERSCAN_API_KEY \
    --verify \
    --constructor-args "0x4f87005127Dbc4579dE820E928b609a4a9D4a2C9"

forge create src/CustomERC20.sol:CustomERC20 --rpc-url $RPC_URL \
    --private-key $PRIVATE_KEY \
    --broadcast \
    --etherscan-api-key $ETHERSCAN_API_KEY \
    --verify \
    --constructor-args "0x4f87005127Dbc4579dE820E928b609a4a9D4a2C9"


forge script script/UpgradeableCustomERC20.s.sol --rpc-url $RPC_URL \
    --private-key $PRIVATE_KEY \
    --broadcast \
    --etherscan-api-key $ETHERSCAN_API_KEY \
    --verify 

forge script script/UpgradeableCustomERC20ProxyFactory.s.sol:UpgradeableCustomERC20ProxyFactoryScript --rpc-url $RPC_URL \
    --private-key $PRIVATE_KEY \
    --broadcast \
    --etherscan-api-key $ETHERSCAN_API_KEY \
    --verify

forge script script/ERC20.s.sol:CustomTokenScript --rpc-url $RPC_URL \
    --private-key $PRIVATE_KEY \
    --broadcast \
    --etherscan-api-key $ETHERSCAN_API_KEY \
    --verify


# Send deploy transaction


# preflight check and perform deployment (proxy if not exist)

cast send $PROXY_FACTORY \
    "deploy(address)" $DEPLOYED_FORWARDER \
    --private-key $PRIVATE_KEY \
    --rpc-url $RPC_URL

 

cast send $PROXY \
    "mint(address,uint256)" $DISTRIBUTOR_A 1000000000000000000000000 \
    --private-key $PRIVATE_KEY \
    --rpc-url $RPC_URL

cast send $PROXY \
    "transfer(address,uint256)" $TOKEN_HOLDER  10000000000000000001\
    --private-key $DISTRIBUTOR_A_PK \
    --rpc-url $RPC_URL



# Non-critical - use only for cleaning and debugging
forge verify-contract 0x10979962e6d2a5688807E41169D62967f15C6d65 \
src/UpgradeableCustomERC20.sol:UpgradeableCustomERC20 \
--etherscan-api-key $ETHERSCAN_API_KEY \
--chain 80002

## --constructor-args 0x287f0B854a2Ba9Dc3E8572c68bDabD949819F119

forge verify-contract 0x5b261a8662f433fe7320acD470C8B2893F1e1ce8 \
src/ERC20.sol:CustomToken \
--etherscan-api-key $ETHERSCAN_API_KEY \
--chain 80002

forge verify-contract \
  0x21CD2Be48C05766933b76FA60fCbDf974B4B9A3F \
  src/UpgradeableCustomERC20ProxyFactory.sol:UpgradeableCustomERC20ProxyFactory \
  --chain-id 80002 \
  --watch \
  --etherscan-api-key $ETHERSCAN_API_KEY

# Test commands for proxy 

cast call 0x054c5f1267f3ee2f89545CF4087f82C7e637224b "name()(string)" --rpc-url $RPC_URL
cast call 0x054c5f1267f3ee2f89545CF4087f82C7e637224b "symbol()(string)" --rpc-url $RPC_URL
cast call 0x054c5f1267f3ee2f89545CF4087f82C7e637224b "decimals()(uint8)" --rpc-url $RPC_URL
cast call 0x054c5f1267f3ee2f89545CF4087f82C7e637224b "totalSupply()(uint256)" --rpc-url $RPC_URL

# proxy from anvil 0x75537828f2ce51be7289709686a69cbfdbb714f1

# receiver 0x70997970C51812dc3A010C7d01b50e0d17dc79C8
## 0x287f0B854a2Ba9Dc3E8572c68bDabD949819F119


#####################

##