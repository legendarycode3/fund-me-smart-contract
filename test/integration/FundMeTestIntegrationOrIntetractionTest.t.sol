// SPDX-License-Identifier: MIT


pragma solidity ^0.8.18;


// import {Test} from "forge-std/Test.sol";
import {Test, console} from "forge-std/Test.sol";


//IMPORTING OUR CONTRACTS OUR CONTRACT WHICH WE WANT TO TEST (RATHER THAN TESTING BASIC TEST)
import {FundMe} from "../../src/FundMe.sol";

import {DeployFundMe} from "../../script/DeployFundMe.s.sol";

import {FundFundMe, WithdrawFundMe} from "../../script/Interactions.s.sol";


contract InteractionsTest is Test{ 

     /**
     * STATE VARIABLE TO HOLD THE INSTANCE OF OUR CONTRACT "FUNDME" WHICH WE WANT TO TEST. WE SCOOPED IT , TO BE VISIBLE TO THE OVERALL CONTRACT.
     */
    FundMe fundMe;


    // TO CREATE A FAKE-USER USING FOUNDRY CHEATCODE (TO MAKE A TEST)
    address USER = makeAddr("user");

    uint256 constant  SEND_VALUE = 0.1 ether; // 100000000000000000
    uint256 constant STARTING_BALANCE = 10 ether;

    uint256  constant GAS_PRICE = 1;


    function setUp()  external {
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();


    //     DeployFundMe deployFundMe = new DeployFundMe();
    //    fundMe = deployFundMe.run();
        vm.deal(USER, STARTING_BALANCE); 
    }


    function testUserCanFundInteractions() public {
        FundFundMe fundFundMe = new FundFundMe();
        // vm.prank(USER);
        // vm.deal(USER, 1e18);
        fundFundMe.fundFundMe(address(fundMe));

        // address funder = fundMe.getFunder(0);
        // assertEq(funder, USER);

        WithdrawFundMe withdrawFundMe =  new WithdrawFundMe();
        withdrawFundMe.withdrawFundMe(address(fundMe));
        assert(address(fundMe).balance == 0);
    }

}