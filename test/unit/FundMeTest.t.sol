// SPDX-License-Identifier: MIT


pragma solidity ^0.8.18;


// import {Test} from "forge-std/Test.sol";
import {Test, console} from "forge-std/Test.sol";

//IMPORTING OUR CONTRACTS OUR CONTRACT WHICH WE WANT TO TEST (RATHER THAN TESTING BASIC TEST)
import {FundMe} from "../../src/FundMe.sol";



import {DeployFundMe} from "../../script/DeployFundMe.s.sol";


/**
 * WE WANT TO TEST IF OUR CONTRACT "FUNDME" WORKS PROPERLY OR NOT , AND ALSO WE WANT TO TEST ALL THE FUNCTION IN OUR CONTRACT "FUNDME" WORKS PROPERLY OR NOT.
 */
contract FundMeTest is Test{

    /**
     * STATE VARIABLE TO HOLD THE INSTANCE OF OUR CONTRACT "FUNDME" WHICH WE WANT TO TEST. WE SCOOPED IT , TO BE VISIBLE TO THE OVERALL CONTRACT.
     */
    FundMe fundMe;


    // TO CREATE A FAKE-USER USING FOUNDRY CHEATCODE (TO MAKE A TEST)
    address USER = makeAddr("user");


    uint256 constant  SEND_VALUE = 0.1 ether; // 100000000000000000
    uint256 constant STARTING_BALANCE = 10 ether;

    uint256  constant GAS_PRICE = 1;


    /**
     * FOR BASIC TESTING PURPOSE , WE ARE USING THIS VARIABLE TO TEST OUR TESTING FRAMEWORK PROPERLY OR NOT.
     */
    // uint256 number = 1;
   

     // THIS FUNCTION WILL RUN BEFORE EACH TEST FUNCTION , IT IS USED TO SETUP THE ENVIRONMENT FOR OUR TESTS.
   function setUp() external {
        /**
         * FOR BASIC TESTING PURPOSE , WE ARE USING THIS VARIABLE TO TEST OUR TESTING FRAMEWORK PROPERLY OR NOT.
         */
        //    number = 3;


        /**
        * DEPLOYING OUR CONTRACT "FUNDME" TO TEST IT PROPERLY OR NOT.
        */
        // FundMe fundMe = new FundMe();

        //HARDCODING THE ADDRESS OF THE PRICE FEED CONTRACT TO THE CONSTRUCTOR OF OUR CONTRACT "FUNDME" TO DEPLOY IT PROPERLY OR NOT.
        // fundMe = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);


        // DEPLOYING OUR CONTRACT "FundMeTest" USING THE DEPLOY SCRIPT "DeployFundMe.s.sol" TO TEST IT PROPERLY OR NOT.
       DeployFundMe deployFundMe = new DeployFundMe();
       fundMe = deployFundMe.run();


       // GIVING OUR FAKE USER, AN ETHER TO START OUT WITH, WHICH I USED vm.deal() FOUNDRY CHEATCODE
        // vm.deal(USER, 10e18);
       vm.deal(USER, STARTING_BALANCE);
    }








    // THIS IS A DEMO TEST FUNCTION , IT IS USED TO TEST IF OUR TESTING FRAMEWORK WORKS PROPERLY OR NOT.
   //function testDemo() public {

        /**
         * FOR BASIC TESTING PURPOSE , WE ARE USING THIS VARIABLE TO TEST OUR TESTING FRAMEWORK PROPERLY OR NOT.'
         * 
        * console.log() IS A FUNCTION PROVIDED BY FORGE-STD LIBRARY , IT IS USED TO PRINT THE VALUE OF A VARIABLE IN THE CONSOLE.
        * 
        * assertEq() IS A FUNCTION PROVIDED BY FORGE-STD LIBRARY , IT IS USED TO ASSERT THAT TWO VALUES ARE EQUAL.
        */
        // console.log(number);
        // console.log("HELLO WORLD");
        // assertEq(number, 3);
    //}



    // THIS IS A TEST FUNCTION TO TEST THE MINIMUM_USD FUNCTION IN OUR CONTRACT "FUNDME" WORKS PROPERLY OR NOT.
    function testMinimumDollarIsFive() public {
        // MINIMUM_USD(), 5e18;
        assertEq(fundMe.MINIMUM_USD(), 5e18); 
    }


    function testOwnerIsMsgSender() public view   {
        
        /**
         * DEBUGING YOUR SOLIDITY TESTS USING console.log() FUNCTION PROVIDED BY FORGE-STD LIBRARY.
         */
        // console.log(fundMe.i_owner());
        // console.log(msg.sender);

        
        console.log(address(this));
        // assertEq(fundMe.i_owner(), address(this));
        
        //assertEq(fundMe.i_owner(), msg.sender);
        assertEq(fundMe.getOwner(), msg.sender);
    }

 

    /**
     * WHAT CAN WE DO , TO WORK WITH ADDRESSES OUTSIDE OUR SYSTEM ?
     * 
     * 1."Unit TESTING": TESTING A SPECIFIC PART OF A CODE.               WE CAN WRITE UNIT TESTS THAT FOCUS ON THE INTERNAL LOGIC OF OUR CONTRACTS WITHOUT INTERACTING WITH EXTERNAL ADDRESSES. THIS ALLOWS US TO TEST THE CORE FUNCTIONALITY OF OUR CONTRACTS IN ISOLATION.
     * Involves testing individual components, especially smart contract functions, in isolation to ensure they are logically correct and secure.
     * 
     * 2."INTEGRATION TESTING": TESTING HOW OUR CODE WORKS WITH OTHER PARTS OF OUR CODE. TESTING THE INTERACTION BETWEEN DIFFERENT PARTS OF A SYSTEM.  WE CAN WRITE INTEGRATION TESTS THAT SIMULATE INTERACTIONS WITH EXTERNAL ADDRESSES OR CONTRACTS. THIS CAN BE DONE USING MOCKS OR BY DEPLOYING TEST VERSIONS OF EXTERNAL CONTRACTS TO A LOCAL TESTNET.
     * Verifies the interactions and data flow between different modules, such as the smart contracts, external APIs, oracles, and the front-end application (dApp).
     * 
     * 3."FORKED TESTING": TESTING OUR CODE ON A STIMULATED REAL ENVIRONMENT.  
     * TESTING ON A FORK OF THE MAINNET. WE CAN USE FORKING TO CREATE A LOCAL COPY OF THE MAINNET, ALLOWING US TO INTERACT WITH REAL EXTERNAL ADDRESSES AND CONTRACTS IN A CONTROLLED ENVIRONMENT. THIS IS PARTICULARLY USEFUL FOR TESTING INTERACTIONS WITH DEFI PROTOCOLS OR OTHER EXTERNAL SERVICES. ( WE CAN USE "MOCKS" TO SIMULATE THE BEHAVIOR OF EXTERNAL ADDRESSES OR CONTRACTS. THIS ALLOWS US TO TEST OUR CONTRACTS IN ISOLATION WITHOUT DEPENDING ON ACTUAL EXTERNAL ENTITIES.)
     * 
     * 4. STAGING TESTING: TESTING OUR CODE IN A REAL ENVIRONMENT THAT IS NOT PROD. DEPLOYING TO A TESTNET , DEPLOYING OUR CONTRACTS TO A PUBLIC TESTNET (LIKE SEPOLIA) AND INTERACTING WITH REAL EXTERNAL ADDRESSES AND CONTRACTS IN A LIVE ENVIRONMENT. THIS CAN HELP US IDENTIFY ISSUES THAT MAY NOT BE APPARENT IN A LOCAL TESTING ENVIRONMENT.

     
     */



    function testPriceFeedVersionIsAccurate() public view  {
       uint256 version = fundMe.getVersion();


       /**
        * USED "ASSERTEQ()" FUNCTION TO ASSERT THAT THE VERSION RETURNED BY THE getVersion() FUNCTION IN OUR CONTRACT "FUNDME" IS EQUAL TO 4, WHICH IS THE EXPECTED VERSION OF THE PRICE FEED. 
        
        * USED THE "ASSERTEQ()"  TO VERIFY THAT THE VARIABLE "version" IS EQUAL TO 4, CONFIRMING THAT THE PRICE FEED VERSION IS ACCURATE. IF THE ASSERTION PASSES, IT MEANS THE PRICE FEED VERSION IS CORRECT; OTHERWISE, THE TEST WILL FAIL, INDICATING A DISCREPANCY IN THE EXPECTED VERSION.
        */
       
        assertEq(version, 4);

    // assertEq(version, 6);
    
    }



    /**
     * "MODULAR DEPLOYMENT":  THE PRACTICE OF STRUCTURING AND DEPLOYING SMART CONTRACTS IN A WAY THAT PROMOTES REUSABILITY, MAINTAINABILITY, AND SCALABILITY. IT INVOLVES BREAKING DOWN A COMPLEX SYSTEM INTO SMALLER, SELF-CONTAINED MODULES OR COMPONENTS THAT CAN BE DEVELOPED, TESTED, AND DEPLOYED INDEPENDENTLY. THESE MODULES CAN THEN BE COMPOSED TOGETHER TO FORM A COMPLETE APPLICATION OR SYSTEM. 
     * 
     * "MODULAR TESTING": THE PRACTICE OF STRUCTURING AND WRITING TESTS IN A WAY THAT PROMOTES REUSABILITY, MAINTAINABILITY, AND SCALABILITY. IT INVOLVES BREAKING DOWN TESTS INTO SMALLER, SELF-CONTAINED UNITS THAT CAN BE DEVELOPED, TESTED, AND MAINTAINED INDEPENDENTLY. THESE UNITS CAN THEN BE COMPOSED TOGETHER TO FORM A COMPLETE TEST SUITE.
     * 
     * "Refactoring my codebase to be more modular and reusable, both in terms of the smart contracts themselves and the tests we write for them. This can involve creating libraries, using inheritance, and structuring our code in a way that promotes separation of concerns and reusability".
     */





    /**
     * A TEST FUNCTION THAT CHECKS IF I DON'T SEND ENOUGH IT GREATER THAN OR EQUAL TO 5(AS I DECLARED ON FundMe.sol), IT SHOULD REVERT
     */
    function testFundFailsWithoutEnoughETH()  public {
        
        //IF I DO vm.expectRevert(); THEN AM KIND OF SAYING THE NEXT LINE SHOULD "REVERT"
        vm.expectRevert();

        //uint256 count = 1; // THIS LINE WILL MAKE IT NOT TO REVERT , BECAUSE THIS LINE OF CODe uint256 count = 1; IS CORRECT

        fundMe.fund(); // THIS LINE WILL MAKE IT REVERT AUTOMATICALLY , BECUS IS WRONG, WE  AUTOMATICALLY SAY HERE THAT undMe.fund() WHICH IS EMPTY MEANING LESS THAN 5 SHOULD MAKE A TRANSACTION, WHICH IS IMPOSSIBLE.. WHICH IS TO SAY THE LINE WILL BE SUCCESSFUL (BECUS THE CONDITION IS TRUE)
    }



    /**
     * IF WE DO SEND ENOUGH ETH (WITHOUT IT REVERTING), THEN LETS UPDATE THE FOLLOWING CODE ON THIS FUNCTION testFundUpdatesFundedDataStructure() 
     */
    function testFundUpdatesFundedDataStructure() public {
        vm.prank(USER);  // THIS LINE  vm.prank(USER); SAYS, THE NEXT  "TX" SHOULD BE SENT  BY USER
 
        // fundMe.fund{value: 13e18};
        //  fundMe.fund{value: 13e18}();
        fundMe.fund{value: SEND_VALUE}();

        //  uint256 amountFunded = fundMe.getAddressToAmountFunded(address(this));
          uint256 amountFunded = fundMe.getAddressToAmountFunded(USER);
        //  assertEq(amountFunded, 13e18);
        assertEq(amountFunded, SEND_VALUE);
    }




    function testAddsFunderToArrayOfFunders()  public {
        vm.prank(USER);

        fundMe.fund{value: SEND_VALUE}();

        //GETTING THIS AT INDEX 0, BECUS I HAVE ONE SINGLE FUNDER HERE 
        address funder = fundMe.getFunder(0);
        assertEq(funder, USER);
    }




    /**
     * "MODIFIER"  hERE (THIS ONE ON PARTICULAR), WILL HELP ANY OF OUR TEST TO BE REDUCED IN CODE ...
     * JUST BY ADDING " funded" AFTER THE THE "public" IN THE TEST DECORATION FOR THE PARTICULAR TEST..
     * 
     * 
     * EXAMPLE USED THE "modifier" IN THE TEST FUNCTION FOR testOnlyOwnerCanWithdraw FUNCTION,  testWithdrawWithASingleFunder() FUNCTION
     * 
     * NOTE: THE Modifier , WILL HELP US NOT TO KEEP REPATING OURSELVE OVER AND OVER AGAIN FOR A PARTICULAR SET OF SAME CODES
     */
    modifier funded() {
        vm.prank(USER);
        fundMe.fund{value: SEND_VALUE}();
        _;
    }



    // TESTING WITHDRAWAL FUNCTION (which is on FundMe.sol file) TO CHECK IF IT WORK CORRECTLY.
    // I  WANT TO MAKE SURE HERE . THAT onlyOwner CAN CALL THE "Withdrawal" FUNCTION
    //THIS "Withdrawal" FUNCTION HERE SET OF  CODE WONT WORK, BECUS IT WILL REVERT BECUS IT IS TRUE , THAT THE USER HAVE NO ACCESS TO WITHDRRAW AND WHICH TH USER IS NOT THE OWNER
    function testOnlyOwnerCanWithdraw() public funded {
        //  vm.prank(USER); // vm.prank(USER);  THIS WILL HELP "FUND" WITH SOME TEST VIRTUAL CHEATCODE ETH MONEY. ALL THIS IS DONE WITH THE HELP OF vm.deal()

        // fundMe.fund{value: SEND_VALUE}();

         //vm.prank(USER);
        vm.expectRevert(); //FROM HERE  vm.expectRevert() , THE LINE OF CODE WILL REVERT... (BECUS  THE "USER" TRIES TO WITHDRAW WHICH THE USER IS NOT THE OWNER)
         vm.prank(USER);

        fundMe.withdraw(); // ACCESSING THE FundMe.sol FILE OF "Withdrawal" FUNCTION
    }




    function testWithdrawWithASingleFunder()  public funded {
        /** THESE ARE USED FOR WORKING WITH TEST("Arrange", "Act", and "Assert" (AAA) are a widely adopted pattern for structuring tests in software development, including in the Foundry framework for Solidity smart contracts. This pattern divides each test into three distinct, sequential phases to improve readability, maintainability, and clarity.) 
         * 
         * THEY INCLUDE:
         * 
         *1. Arrange :- THIS IS FOR SETTING-UP THE INITIAL CONDITIONS AND ENVIRONMENT REQUIRED FOR THE TEST TO RUN CORRECTLY (Initializing variables and objects, such as deploying the smart contract under test.).
         - THIS "Arrange" BASCIALLY  ARRANGE THE TEST (SETTING IT UP
         * 
         *2.  Act :- THIS PHASE INVOLVES EXECUTING THE SPECIFIC FUNCTIONALITY OR METHOD OF THE SMART CONTRACT THAT YOU INTEND TO TEST.
         THIS "Act" BASICALLY  PERFORM THE ACTION, I ACTUALLY WANT TO TEST
         * 
         * 
         *3. Assert:- IN THE FINAL PHASE, YOU VERIFY THE OUTCOME OF THE ACTION PERFORMED IN THE "Act" STEPS AGAINST YOUR EXPECTED RESULT. THIS BESICALLY INVOLVES USING "assertion Functions" PROVIDED BY FOUNDRY TEST LIBRARY
         */



        /**
         * ON THE FUNCTION "testWithdrawWithASingleFunder()"
         * 
         * - 1st FIRST WE WANT TO TEST THAT FIRST IF withdrawal Function , IS GOING TO WORK. BY CHEKING OUR BALANCE BEFORE WE CALL Withdrawal , SO THAT WE CAN COMPARE IT TO WAT OUR BALANCES AFTER..
         * 
         * Arrange:
         */
        uint256 startingOwnerBalance = fundMe.getOwner().balance;

        uint256 startingFundMeBalance = address(fundMe).balance;




        /**
         * "Act" Section:
         * 
         * THE LINES ON THESE "ACT" SECTION, ACTUALLY WHAT WE ARE TESTING
         */

        uint256 gasStart =  gasleft(); //LETS SAY WE HAVE A 1000 

        //vm.txGasPrice(uint256) cheat code is used to set the gas price for the very next transaction in a test or script, enabling the simulation of different network congestion scenarios. Because Anvil and Foundry tests default the gas price to 0, this cheat code is crucial for testing contracts that calculate fees or depend on tx.gasprice
        // vm.txGasPrice(2 gwei);
       //vm.txGasPrice(GAS_PRICE); //LETS SAY COST WAS : 200


        vm.prank(fundMe.getOwner());
        fundMe.withdraw();

        // uint256 gasEnd =  gasleft(); //LETS SAY REMAINING 800

        // uint256  gasUsed = (gasStart - gasEnd) *  tx.gasprice;
        // console.log(gasUsed);



        /**
         * "Assert" SECTION
         *  
         */
        uint256 endingOwnerBalance = fundMe.getOwner().balance;
        uint256 endingFundMeBalance = address(fundMe).balance;

        assertEq(endingFundMeBalance, 0);
        assertEq(startingFundMeBalance + startingOwnerBalance, endingOwnerBalance); 
    }





    /** TEST FROM MULTIPLY FUNDERS "testWithdrawFromMultipleFunders" */
    function testWithdrawFromMutipleFunders() public funded {

        /**
         * ARRANGE SETUP 
         */
        uint160  numberOfFunders = 10;
        uint160 startingFunderIndex = 1;

        for (uint160 i =  startingFunderIndex; i < numberOfFunders; i++) {
            /**
             *  vm.prank (new address)
             *  vm.deal  (new address)
             *  
             * THEN FUND THE fundMe
             */

            //RECENTLY IN SOLIDITY 0.8, NOW  IF YOU WANT TO USE NUMBERS TO GENERATE "Addresses", YOU HAVE TO USE uint160 (NOT LONGER uint256)
            hoax(address(i), SEND_VALUE); 
            fundMe.fund{value: SEND_VALUE}();
        }
         uint256 startingOwnerBalance = fundMe.getOwner().balance;

        uint256 startingFundMeBalance = address(fundMe).balance;



        /**
         * "ACT" Section:
         * 
         * THE LINES ON THESE "ACT" SECTION, ACTUALLY WHAT WE ARE TESTING
         */
        // vm.prank(fundMe.getOwner());
        vm.startPrank(fundMe.getOwner());
        fundMe.withdraw();
        vm.stopPrank();



         /**
         * "Assert" SECTION PHASE
         *  
         */
        //HERE MAKING SURE THAT WE SHOULD HAVE REMOVED THE  FUNDS OUT OF THE fundMe
        assert(address(fundMe).balance == 0);
         assert(startingFundMeBalance + startingOwnerBalance ==  fundMe.getOwner().balance);
  
    }





    function testWithdrawFromMutipleFundersCheaper() public funded {

        /**
         * ARRANGE SETUP 
         */
        uint160  numberOfFunders = 10;
        uint160 startingFunderIndex = 1;

        for (uint160 i =  startingFunderIndex; i < numberOfFunders; i++) {
            /**
             *  vm.prank (new address)
             *  vm.deal  (new address)
             *  
             * THEN FUND THE fundMe
             */

            //RECENTLY IN SOLIDITY 0.8, NOW  IF YOU WANT TO USE NUMBERS TO GENERATE "Addresses", YOU HAVE TO USE uint160 (NOT LONGER uint256)
            hoax(address(i), SEND_VALUE); 
            fundMe.fund{value: SEND_VALUE}();
        }
         uint256 startingOwnerBalance = fundMe.getOwner().balance;

        uint256 startingFundMeBalance = address(fundMe).balance;



        /**
         * "ACT" Section:
         * 
         * THE LINES ON THESE "ACT" SECTION, ACTUALLY WHAT WE ARE TESTING
         */
        // vm.prank(fundMe.getOwner());
        vm.startPrank(fundMe.getOwner());
        fundMe.cheaperWithdraw();
        vm.stopPrank();



         /**
         * "Assert" SECTION PHASE
         *  
         */
        //HERE MAKING SURE THAT WE SHOULD HAVE REMOVED THE  FUNDS OUT OF THE fundMe
        assert(address(fundMe).balance == 0);
         assert(startingFundMeBalance + startingOwnerBalance ==  fundMe.getOwner().balance);

         
         
    }





}