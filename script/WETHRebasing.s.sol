// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import "../lib/forge-std/src/Vm.sol";

import "../src/examples/WETHRebasing.sol";

contract DeployBlast is Script {
    function run() external {
        string memory envPrivateKeyName = "PRIVATE_KEY"; // The name used  for the private ket in the .env file
        string memory envOwnerName = "OWNER_WALLET";

        uint256 deployerPrivateKeyValue = vm.envUint(envPrivateKeyName);
        address ownerKeyValue = vm.envAddress(envOwnerName);
        console.log("private key", deployerPrivateKeyValue);
        vm.startBroadcast(deployerPrivateKeyValue);
        new WETHRebasingExample(address(ownerKeyValue));

        vm.stopBroadcast();
    }
}
