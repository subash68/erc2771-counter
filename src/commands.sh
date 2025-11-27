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
