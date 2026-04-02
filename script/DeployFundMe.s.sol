/**
 * "SCRIPT" FOLDER  -> IS WHERE WE PUT CODE TO INTERACT WITH OUR SMART CONTRACTS ON THE SRC(SOURCE) FOLDER.
 */


// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;  //Versiion


import {Script} from "forge-std/Script.sol";

/**
 * - THIS LINE `import {FundMe} from "../src/FundMe.sol";` , IMPORTS THE ACTUAL "FundMe" SMART CONTRACT THAT YOU INTEND TO DEPLOY. IT IS PREASUMED TO BE LOCATED IN THE src DIRECTORY RELATIVE TO THE SCRIPT FILE.
 */
import {FundMe} from "../src/FundMe.sol";


import {HelperConfig} from "./HelperConfig.s.sol";


contract DeployFundMe is Script {

     /*
      * THIS FUNCTION "run" IS THE ENTRY POINT OF THE SCRIPT. WHEN YOU EXECUTE THIS SCRIPT, THE CODE WITHIN THE "run" FUNCTION WILL BE EXECUTED. THIS IS WHERE YOU DEFINE THE LOGIC FOR DEPLOYING YOUR SMART CONTRACTS OR INTERACTING WITH THEM.
      * IN THIS CASE , WE ARE DEPLOYING OUR CONTRACT "FUNDME" TO THE SEPOLIA TESTNET.
      * 
       - `vm.startBroadcast();` AND `vm.stopBroadcast();` ARE FUNCTIONS PROVIDED BY THE FOUNDRY FRAMEWORK TO CONTROL WHEN TRANSACTIONS ARE BROADCASTED TO THE NETWORK. ANY CODE EXECUTED BETWEEN THESE TWO CALLS WILL BE SENT AS A TRANSACTION TO THE BLOCKCHAIN, ALLOWING YOU TO DEPLOY CONTRACTS OR INTERACT WITH THEM.
     */

    // function run() external {
    //     //DEPLOYING OUR CONTRACT "FUNDME" TO THE SEPOLIA TESTNET.

    //     vm.startBroadcast();
    //     // FundMe fundMe = new FundMe();
    //     new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    //     vm.stopBroadcast();

    // }


    function run() external returns (FundMe) {
        //DEPLOYING OUR CONTRACT "FUNDME" TO THE SEPOLIA TESTNET.


        /**
         * ANYTHING BEFORE THE "vm.startBroadcast();" IS NOT GOING TO BE BROADCASTED TO THE NETWORK. THIS MEANS THAT ANY CODE EXECUTED BEFORE THIS LINE WILL NOT RESULT IN A TRANSACTION ON THE BLOCKCHAIN. THIS IS USEFUL FOR SETTING UP VARIABLES, CONFIGURATIONS, OR PERFORMING ANY LOGIC THAT YOU WANT TO EXECUTE LOCALLY WITHOUT INTERACTING WITH THE NETWORK.
         * WHICH THIS HelperConfig helperConfig = new HelperConfig();, IS BEFORE vm.startBroadcast();
         */
        HelperConfig helperConfig = new HelperConfig();

        address ethUsdPriceFeedAddress = helperConfig.activeNetworkConfig();



        vm.startBroadcast();


        /**
         * ANYTHING AFTER THE "vm.startBroadcast();" IS GOING TO BE BROADCASTED TO THE NETWORK. THIS MEANS THAT ANY CODE EXECUTED AFTER THIS LINE WILL RESULT IN A TRANSACTION ON THE BLOCKCHAIN. THIS IS WHERE YOU WOULD DEPLOY CONTRACTS, CALL FUNCTIONS ON CONTRACTS, OR PERFORM ANY ACTION THAT INTERACTS WITH THE NETWORK.
         * WHICH THIS FundMe fundMe = new FundMe();, IS AFTER vm.startBroadcast(); 
         */

        /**
         * MOCK
         */

        // FundMe fundMe = new FundMe();
        // FundMe fundMe = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        // vm.stopBroadcast();

        FundMe fundMe = new FundMe(ethUsdPriceFeedAddress);
        vm.stopBroadcast();

        return fundMe;
    }

}