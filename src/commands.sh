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

# Send deploy transaction

cast send 0x4E44238A07Fd8306258523e02cEE0697D043fb54 \
    "deploy(address)" 0xd0593c130b235e88F74f8e2B5A7D5B7060de5DA4 \
    --private-key $PRIVATE_KEY \
    --rpc-url $RPC_URL


# Non-critical - use only for cleaning and debugging
forge verify-contract 0x7EA8e772cB6c33695ab3854BF45A3b364314245A \
src/UpgradeableCustomERC20.sol:UpgradeableCustomERC20 \
--etherscan-api-key $ETHERSCAN_API_KEY \
--chain 80002

forge verify-contract \
  0x4E44238A07Fd8306258523e02cEE0697D043fb54 \
  src/UpgradeableCustomERC20ProxyFactory.sol:UpgradeableCustomERC20ProxyFactory \
  --chain-id 80002 \
  --watch \
  --etherscan-api-key $ETHERSCAN_API_KEY

# Test commands for proxy 

cast call 0x1D586091047cc27413a34387ed86fe84572aF197 "name()(string)" --rpc-url $RPC_URL
cast call 0x1D586091047cc27413a34387ed86fe84572aF197 "symbol()(string)" --rpc-url $RPC_URL
cast call 0x1D586091047cc27413a34387ed86fe84572aF197 "decimals()(uint8)" --rpc-url $RPC_URL
cast call 0x1D586091047cc27413a34387ed86fe84572aF197 "totalSupply()(uint256)" --rpc-url $RPC_URL

# proxy from anvil 0x75537828f2ce51be7289709686a69cbfdbb714f1

# receiver 0x70997970C51812dc3A010C7d01b50e0d17dc79C8


## 0x287f0B854a2Ba9Dc3E8572c68bDabD949819F119
