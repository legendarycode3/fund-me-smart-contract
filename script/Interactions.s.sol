/**
 * ON THIS INTEGRACTION.s.sol FILE, WILL COMPRISE ALL OF THE WAYS WE CAN ACTUALLY INTERACT WITH OUR SMART CONTRACT..
 * 
 *
 * 
 * SO THEREFOR, WE GOONA CREATE TWO (2) SCRIPT:
 * 
 * 1. A "FUND" SCRIPT
 * 
 * 2. A "WITHDRAW" SCRIPT
 */



// SPDX-License-Identifier: MIT



pragma solidity ^0.8.18;



import {Script, console} from "forge-std/Script.sol";

// INSTALLED  {DevOpsTools}   This way , we don’t have to pass the FundMe Contract Address that we want to work with , every single time. (That is what )
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";

import {FundMe} from "../src/FundMe.sol";


// 1st SCRIPt , "FUND SCRIPT" , FOR FUNDING THE FOUNDRY CONTRACT..
contract FundFundMe is Script  {
    uint256 constant SEND_VALUE = 0.01 ether; 
    

    function fundFundMe(address mostRecentlyDeployed) public {
      
        FundMe(payable(mostRecentlyDeployed)).fund{value: SEND_VALUE}();
        
        console.log("Funded  FundMe with %s", SEND_VALUE);
    }


  // function run() {} , THIS IS WHERE WE PUT OUR CODE, TO ACTUALLY DO OUR STUFF
  function run() external {
    address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
        "FundMe", 
        block.chainid
    );
      vm.startBroadcast();
    fundFundMe(mostRecentlyDeployed);
    vm.stopBroadcast(); 
  }



}









//2nd SCRIPT , "WITHDRAW SCRIPT" , FOR WITHDRAWING 
contract WithdrawFundMe is Script {
    function withdrawFundMe(address mostRecentlyDeployed) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployed)).withdraw();
        
        //console.log("Funded  FundMe with %s", SEND_VALUE);
        vm.stopBroadcast();
    }


  // function run() {} , THIS IS WHERE WE PUT OUR CODE, TO ACTUALLY DO OUR STUFF
  function run() external {
    address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
        "FundMe", 
        block.chainid
    );
    vm.startBroadcast();
    withdrawFundMe(mostRecentlyDeployed);
    vm.stopBroadcast(); 
  }

}