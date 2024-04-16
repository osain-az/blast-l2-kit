// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

//import {Test, console} from "forge-std/Test.sol";
import {Test, console} from "../lib/forge-std/src/Test.sol";
import {WETHRebasingExample} from "../src/examples/WETHRebasing.sol";

// forge test --fork-url https://sepolia.blast.io  -vvv
contract WETHRebasingTest is Test {
    WETHRebasingExample public wethRebasing;

    function setUp() public {
        wethRebasing = new WETHRebasingExample(address(this));
    }

    function testDeposit() public {
        uint256 initialBalance = address(this).balance;

        console.log("initial balance ", initialBalance / 1e18);
        uint256 depositAmount = 10 * 1e18; //10 ETH
        wethRebasing.deposit{value: depositAmount}();

        uint256 newBalance = address(this).balance;
        console.log("current balance ", address(this).balance / 1e18);

        assertEq(
            newBalance,
            initialBalance - depositAmount,
            "Amount was not deposited"
        );
    }

    function testWithdraw() external {
        uint256 depositAmount = 10 * 1e18; //10 ETH
        wethRebasing.deposit{value: depositAmount}();
        wethRebasing.withdraw(depositAmount / 2);
    }

    function testWethBalance() public view {
        uint256 balance = wethRebasing.wethBalance();
        console.log(balance);
        assert(balance >= 0);
    }
}
