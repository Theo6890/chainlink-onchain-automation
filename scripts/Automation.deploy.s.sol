// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Script.sol";

import {Automation} from "../src/Automation.sol";

/**
* @dev forge script Automation_deploy \
        --rpc-url $SEPOLIA_RPC --broadcast \
        --verify --etherscan-api-key $ETH_KEY \
        -vvvv --optimize --optimizer-runs 20000 -w
*
* @dev If verification fails:
* forge verify-contract \
    --chain 11155111 \
    --num-of-optimizations 20000 \
    --compiler-version v0.8.17+commit.87f61d96 \
    --watch 0xb7DEBdA47C1014763188E69fc823B973eC1749D6 \
    IGO $ETH_KEY
*
* @dev VRFCoordinatorV2Interface: https://docs.chain.link/docs/vrf-contracts/
*/

contract Automation_deploy is Script {
    function run() external {
        ///@dev Configure .env file
        string memory SEED = vm.envString("SEED");
        uint256 privateKey = vm.deriveKey(SEED, 0); // address at index 0
        vm.startBroadcast(privateKey);

        new Automation(1);

        vm.stopBroadcast();
    }

    function test() public {}
}
