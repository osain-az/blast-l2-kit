// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.23;

//import {Test, console,Vm} from "forge-std/Test.sol";
import {Test, console, Vm} from "../lib/forge-std/src/Test.sol";
import {WETHRebasingExample} from "../src/examples/WETHRebasing.sol";

// forge test --fork-url https://sepolia.blast.io  -vvv
contract WETHRebasingTest is Test {
    WETHRebasingExample public wethRebasing;

    /// @param account Address of the account tokens are being withdrawn from.
    /// @param amount  Amount of tokens withdrawn.
    event Withdrawal(address indexed account, uint amount);

    error ETHTransferFailed();

    /// Emitted whenever tokens are deposited to an account.
    /// @param account Address of the account tokens are being deposited to.
    /// @param amount  Amount of tokens deposited.

    event Deposit(address indexed account, uint amount);

    function setUp() public {
        wethRebasing = new WETHRebasingExample(address(this));
    }

    function testDeposit() public {
        // there could be a better to test deposit

        uint256 initialBalance = address(this).balance;
        uint256 depositAmount = 10 * 1e18; //10 ETH

        wethRebasing.deposit{value: depositAmount}();

        uint256 newBalance = address(this).balance;
        assertEq(
            newBalance,
            initialBalance - depositAmount,
            "Amount was not deposited"
        );
    }
    // Deposit  account  is not actaully this contract but  WETHRebasingExample  contract even though this conract is the one sending the fund
    function testDepositeEvent() external {
        uint256 depositAmount = 10 * 1e18; //10 ETH
        console.log("contract address", address(wethRebasing));
        vm.expectEmit(
            true,
            true,
            false,
            true,
            address(0x4200000000000000000000000000000000000023)
        );

        emit Deposit(address(address(wethRebasing)), depositAmount); // this will pass
        // emit Deposit(address(address(this)), depositAmount); /// this will fail

        wethRebasing.deposit{value: depositAmount}();
    }

    // This  is failing 
 /*    function testWithdrawal() external {
        uint256 depositAmount = 10 * 1e18; //10 ETH
        console.log(" Totall balance ", address(this).balance / 1e18);
        wethRebasing.deposit{value: depositAmount}();

        console.log("balance  after depos", address(this).balance / 1e18);
        wethRebasing.withdraw(depositAmount / 2);
        console.log("balance  after withd", address(this).balance);
    } */
}
