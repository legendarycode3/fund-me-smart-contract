/*
    WHAT I WANT TO DO IN THIS PROJECT IS :
    1. Get Funds from users
    2. Withdraw funds (to the owner of the Contract)
    3. Set a minimum funding value in USD
*/



// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;  //Versiion


/*IMPORTING THE "AggregatorV3Interface" HERE ON THIS fundMe.sol CONTRACT PAGE
*/

// import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol"; 


// interface AggregatorV3Interface {
//   function decimals() external view returns (uint8);

//   function description() external view returns (string memory);

//   function version() external view returns (uint256);

//   function getRoundData(
//     uint80 _roundId
//   ) external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);

//   function latestRoundData()
//     external
//     view
//     returns (
//         uint80 roundId, 
//         int256 price, 
//         uint256 startedAt, 
//         uint256 updatedAt, 
//         uint80 answeredInRound
//     );
// }

// import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";  

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol"; 

import { PriceConverterLibrary }  from "./PriceConverterLibrary.sol";


/*
  INSTEAD OF USING "revert function" ON MODIFIER onlyOwner , WE ARE KNOW USING "CUSTOM ERROR CREATED", CREATED OUTSIDE THE CONTRACT 

*/ 
error FundMe__NotOwner();



//780,190 760251
/*
  Using constant and immutable in Solidity is a best practice for optimizing smart contract gas consumption and enhancing security by ensuring that specific state variables cannot be changed after initialization. 
  -  Immutable variables are like constants. Values of immutable variables can be set inside the constructor but cannot be modified afterwards.
  -  Constants : are variables that cannot be modified. Their value is hard coded and using constants can save gas cost.
  
*/


// 1ST CREATED THE FUNDME CONTRACT , BEFORE STARTING TO USE THE "AggregatorV3Interface"
contract FundMe {

    /*
        ATTACHING THE FUNCTIONS IN OUR "PriceConverterLibrary" TO ALL uint256 HERE, WE DO:  "using PriceConverterLibrary for uint256;"
    */
    using PriceConverterLibrary for uint256; 

    //uint256 public  myValue = 1;

    // uint256 public minimumUsd = 5; 
    //uint256 public minimumUsd = 5 * 1e18; 

    //  uint256 public minimumUsd = 51e18; 


    /**
     * USED "CONSTANT"  HERE, TO HELP ON "GAS OPTIMATION", TO HELP SAVE GAS..  
     * */ 
    //  uint256 public constant MINIMUM_USD = 5 * 10 ** 18;
    uint256 public constant MINIMUM_USD = 5e18;  //STATE VARIABLE FOR THE MINIMUM DOLLAR VALUE TO FUND THE CONTRACT, USING CONSTANT KEYWORD TO HELP ON GAS OPTIMATION.
   

     /*
        GAS OPTIMATION USING "Constant" HERE
        21,415 gas  - constant
        23,644  - non-constant
      */
    /*
      executionPrice * gweiGasPriceOnEth(take the wei price after using Eth converter) =  gasPrice (in wei)
      21,415 * 141000000000 = 3.019515e+15 (3,019,515,000,000,000)      

      - Then take this "WeiPrice" , put it on Eth Converter and see "ETh price Value" (0.003019515).
      - Then wehn done with the top step Take the "Ether Price Value"(0.003019515) * "EthPrice current"(3000)
      then you see the cost of both using constant and not using constant .
     
      Total calculation => 21,415 * 141000000000 = $9.058545
    */


    /*
        - LIST OF PEOPLE WHO FUNDED.
        - ARRAYS AND MAPPINGS TO TRACT USERS SENDING MONEY TO A CONTRACT. IT COVERS CREATIN A MECHANISM
        TO RECORD ADDRESSES AND AMOUNTS SENT BY USERS USING 'MSG.SENDER' AND MAPPINGS. HELPS TRACK contributions from different users. 
      */
    // address[] public  s_funders; //STATE VARIABLE TO STORE THE FUNDERS (USERS WHO FUNDED THE CONTRACT)

    address[] private  s_funders; 

    // mapping(address => uint256) public addressToAmountFunded;
    // mapping(address funder => uint256 amountFunded) public s_addressToAmountFundeds;

    //PRIVATE VARIABLES, ARE MORE GAS EFFICIENT THAN PUBLIC
    mapping(address funder => uint256 amountFunded) private s_addressToAmountFundeds;




    
      /*
        - "CONSTRUCTOR" IN SOLIDITY
        HERE ON THE WITHDRAW FUNCTION). WE USED IT SO THAT WE MAKE "ANY BODY CAN FUND THE CONTRACT" BUT NOT
        THE OWNER, TO BE ABLE TO "WITHDRAW THE CONTRACT".

        USING THE CONSTRUCTOR "ANY BODY CAN WITHDRAW THE CONTRACT". SO WE USED THE CONSTRUCTOR TO MAKE THE OWNER OF THE CONTRACT
         THE ONLY ONE WHO CAN WITHDRAW THE CONTRACT.
        "
      */
      // address public  owner;

      // /*USING IMMUTABLE */
      // address public immutable  i_owner;  //STATE VARIABLE FOR THE OWNER OF THE CONTRACT, USING IMMUTABLE KEYWORD TO HELP ON GAS OPTIMATION.
      /*USING IMMUTABLE */

      address private immutable  i_owner;  //STATE VARIABLE FOR THE OWNER OF THE CONTRACT, USING IMMUTABLE KEYWORD TO HELP ON GAS OPTIMATION.


      /*
        GAS OPTIMATION USING "Immutable" HERE
        21,508 gas  - immutable
        23,644  - non-immutable
      */


       // // Functions Order:
        // constructor
        // receive
        // fallback
        // external
        // public
        // internal
        // private
        // view / pure

      
      AggregatorV3Interface private s_priceFeed; //STATE VARIABLE FOR THE PRICE FEED INTERFACE, TO BE ABLE TO CALL THE FUNCTIONS IN THE "AggregatorV3Interface" USING THIS VARIABLE.

      constructor(address priceFeedAddress) {
        // ON THIS CONTRUCTOR, ONLY  CAN bE CALLED  BY THE "OWNER OF THE ADDRESS" 
        i_owner = msg.sender;
        s_priceFeed = AggregatorV3Interface(priceFeedAddress);
        // CHECK ON THE WITHDRAW FUNCTION, AND MODIFY THE FUNCTION - require(msg.sender == owner, "Must be owner");
      }
      


    /*
       - THIS IS A FUNCTION TO BE CALLED , TO "SEND MONEY TO OUR CONTRACT". 
       REQUIREMENT
          ALLOWS USERS TO SEND DOLLAR $.
          HVE A MINIMUM DOLLAR $ SENT.
       1. HOW DO WE SEND ETH WITH THIS FUNCTION.
    */ 
    function fund() public payable   {
        
        /*  - Payable keyword: IS USED TO ALLOW, A FUNCTION TO RECEIVCE  NATIVE BLOCKCHAIN TOKENS SUCH AS  $ETH

            - WHAT IS A REVERT ?  A REVERT UNDO ANY ACTIONS THAT HAVE BEEN DONE , AND SENDS THE REMAINING GAS
        */
       // myValue = myValue + 2;


        // THE FIRST THING TO DO , TO ALLOW OUR FUNCTION TO ACCEPT THE NATIVE BLOCKCHAIN CURRENCY, IS TO MAKE TH FUNCTION "PAYABLE"
        // YOU CAN ACCESS THE "VALUE" OF THE TRANSaCTION  WITH msg.value (GLOBALLY AVAILABLE KEYWORDS IN SOLIDITY DOCs)
       
       /*
        - The "require" statement in Solidity is a built-in function used for input validation 
        and ensuring that valid conditions or contract state variables are met before proceeding 
        with the execution of a function. If the condition provided to require evaluates to false,
         the function execution stops immediately, and the transaction is 
         reverted, undoing any state changes made during the transaction.

         - The convenience functions "assert" and "require" can be used to check for conditions and 
         throw an exception if the condition is not met.
       */
        /*
            require(msg.value > 1e18, "didn't send enough ETH"); //1e18 = 1 ETH = 1000000000000000000 = 1 * 10  ** 18
            msg.value : IS THE "NUMBER OF WEI SENT WITH THE MESSAGE".
            msg.sender : IS THE "SENDER OF THE MESSAGE(CURRENT CALL)"
        */
    
        
        /**
         * THIS LINES SIMPLY MEANS THAT IF, I DON'T SEND ENOUGH THAT IS GREATER THAN OR EQUAL TO 5 , IT SHOULD AUTOMATICALLY REVERT
         */
        //require(getConversionRate(msg.value) >= minimumUsd, "didn't send enough ETH");
        require(msg.value.getConversionRate(s_priceFeed) >= MINIMUM_USD, "didn't send enough ETH");
        // IF SUCCESSFUL, EXECTUTE THE 2 LINES OF  CODE BELOW
        s_addressToAmountFundeds[msg.sender] += msg.value;
        s_funders.push(msg.sender);



        //  s_funders.push(msg.sender);
        // // addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
        // s_addressToAmountFundeds[msg.sender] += msg.value;
    }





    /**
     * FUNCTION READING AND WRITING FROM THE "MEMORY"
     * TO REPLACE IT WITH FUNCTION WE PREVIOUSLY WAS READING AND WRITING FROM THE "STORAGE"
     */
    function cheaperWithdraw() public onlyOwner {
      uint256  funderLength = s_funders.length;

      for (uint funderIndex = 0; funderIndex < funderLength; funderIndex++) {
         address funder = s_funders[funderIndex]; // WE STILL READ FROM STORAGE HERE , EVERY SINGLE TIME address funder = s_funders[funderIndex];

         s_addressToAmountFundeds[funder] = 0; // WE STILL READ FROM STORAGE HERE    s_addressToAmountFundeds[funder] = 0;
      }

       s_funders = new address[](0); // WE STILL READ FROM STORAGE HERE

       (bool callSuccess,) = payable(msg.sender).call{value:address(this).balance}("");
      // (bool callSuccess, bytes memory dataReturned) = payable(msg.sender).call{value:address(this).balance}("");
      require(callSuccess, "Call failed");
    }






    /*
      THIS IS TH FUNCTION THAT THE "OWNER OF THE CONTRACT IS GOING TO USE TO WITHDRAW THE MONEY"
      - USING "FOR LOOP" ,  A FOR LOOP IS A TO LOOP THROUGH A LIST OF SOMETHING, OR DO SOMETHING , 
        THAT WILL BE REPATED FOR A SPECIFIC AMOUNT OF TIME
      - E.G CONCEPT [1,2,3,4] elements
        0,1,2,3 indexes
        
        for(starting index, ending index, step amount ){}
    */


    /*
      - MODIFIERS in Solidity are primarily used to change the behavior of functions in a declarative,
       reusable way, enhancing code readability, maintainability, and security. 
      - They are mostly used to implement pre-conditions, such as access control (e.g.onlyOwner) or input validation, preventing duplicate code across multiple functions.
    */

   /**
     * FUNCTION READING AND WRITING FROM THE "STORAGE" , GAS WAY EXPENSIVE (E.G s_funders;  IS A STORAGE VARIABLE)
    */
    function withdraw() public onlyOwner {
      //require(msg.sender == owner, "Must be owner");

      for (uint funderIndex = 0; funderIndex < s_funders.length; funderIndex++) 
      {
        /* address funder = funders[funderIndex]; THIS IS GOING TO RETURN AN "ADDRESS", SINCE IT IS AN ARRAY OF ADDRESSES*/
        address funder = s_funders[funderIndex];
        /*
          USING THIS 'funder' TO RESET OUR MAPPING ADDRESS 'addressToAmountFunded' TO 
        */
        s_addressToAmountFundeds[funder] = 0;

      }

      // RESETING THE ARRAY (RESETING THE FUNDERS ARRAY TO A BRAND NEW LENGTH)
      s_funders = new address[](0);



      /*
        -  ACTUALLY NOW , WITHDRAWING THE FUNDS FROM THE CONTRACT TO THE OWNER (FROM THE WITHDRAW FUNCTION)
        -  NOW , TO ACTUALLY "SEND ETH" OR "DATA BLOCKCHAIN CURRENCY", THERE ACTUALL 3 DIFFERENT WAYS TO DO IT, 
           THEY INCLUDE: Transfer(), Send(), Call()
      */

      // //1.  TRANSFER 
      // // msg.sender , IS OF TYPE "ADDRESS". AND WE TYPE-CASTED IT TO PAYABLE ADDRESS USING "payable()" 
      // payable(msg.sender).transfer(address(this).balance);

      // //2. SEND
      // bool sendSuccess = payable (msg.sender).send(address(this).balance);
      // require(sendSuccess, "Send failed");



      //3. CALL
         (bool callSuccess,) = payable(msg.sender).call{value:address(this).balance}("");
      // (bool callSuccess, bytes memory dataReturned) = payable(msg.sender).call{value:address(this).balance}("");
      require(callSuccess, "Call failed");



      /*
        - "CONSTRUCTOR" IN SOLIDITY
        HERE ON THE WITHDRAW FUNCTION). WE USED IT SO THAT WE MAKE "ANY BODY CAN FUND THE CONTRACT" BUT NOT
        THE OWNER, TO BE ABLE TO "WITHDRAW THE CONTRACT".

        USING THE CONSTRUCTOR "ANY BODY CAN WITHDRAW THE CONTRACT". SO WE USED THE CONSTRUCTOR TO MAKE THE OWNER OF THE CONTRACT
         THE ONLY ONE WHO CAN WITHDRAW THE CONTRACT.
        "
      */
    }
   


    /*
        - getPrice(){},  A tFUNCTION , THAT CONVERTS THE AMOUNT OF "ETHEREUM (msg.value)" INTO THE VALUE OF DOLLARS.
          getPrice() {} , A FUNCTION THAT THE PRICE OF "ETHEREUM" In TERMS OF USD.

        - getConvertionRate() {}, CONVERTS THE VALUE (msg.value) TO IT CONVERTED VALUE, BASED OF THE price.
    */

    // function getPrice() public view returns (uint256) {
    //     /*
    //         view  -  VIEW IS USED HERE ON TH getPrice() FUNCTION BECAUSE SINCE "WE ARE NOT MODIFYING ANY STATE" , BUT WE ARE "READING STORAGE".
    //     */
    //     //Address  0x694AA1769357215DE4FAC081bf1f309aDC325306  (USING THE "ETH/USD" pair FROM THE  CHAINLINK DATA FEEDS ON SEPOLIA NETWORK)
        

    //     //ABI - (USING Solidity Interface)
    //     // AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();


    //     /*
    //         // ... AGGREGATOR SETUP ...
    //     */
    //     AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
       

    //     /**RETURNING MULTIPLY TYPE (BELOW)
    //     int256 price: THE REASON WHY PRICE IS INT256 IS BECAUSE , SOME PRICEFEED CAN BE "NEGATIVE"(DECIMAL) 18
    //     */
    //     (, int256 price,,,) = priceFeed.latestRoundData();
    //     // (uint80 roundId, int256 price, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound) = priceFeed.latestRoundData();


    //      /*
    //         - PRICE OF ETH IN TERMS OF USD
    //          3000.00000000

    //         - "return price * 1e10;" IS A LINE OF SOLIDITY CODE COMMONLY USED TO CONVERT CHAINLINK PRICE FEED
    //             DATA (WHICH OFTEN HAS 8 DECIMALS) TO THE 18-DECIMAL PRECISION USED BY  Ether (Wei). 
    //     */
    //     return uint256(price * 1e10);
    // }


    // function getConversionRate(uint256 ethAmount) public view returns(uint256) {
    //     uint256 ethPrice = getPrice();

    //     /*
    //         E.G1  1000000000000000000 * 1000000000000000000  = 1000000000000000000000000000000000000 / 1e18
            
    //         E.G2 : 1 ETH = 2000_000000000000000000 (2000 USD)
    //         (2000_000000000000000000 * 1_000000000000000000) / 1e18
    //         $2000 = 1ETH
    //     */
    //     uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        
    //     return ethAmountInUsd;
    // }



    // function getVersion() public view returns (uint256) {
    //     //  return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
        
    //     //ALTERNATIVELY, WE CAN ALSO DO THIS INSTEAD OF CALLING THE "AggregatorV3Interface" AGAIN, WE CAN JUST CREATE A VARIABLE FOR IT AND THEN CALL THE VERSION FUNCTION ON THE VARIABLE.
    //     AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    //     return priceFeed.version();
    // }



    /**
     * - IN ORDER NOT TO "HARDCODE THE ADDRESS" OF THE PRICE FEED. 
     * 
     * - WHAT WE CAN DO INSTEAD IS TO "PASS THE ADDRESS OF THE PRICE FEED" AS A PARAMETER TO THE "CONSTRUCTOR"[which is above] WHICH IS: constructor() {
        i_owner = msg.sender;}; 
      AND THEN WE CAN USE THAT ADDRESS TO CALL THE FUNCTIONS IN THE "AggregatorV3Interface". 
     * 
     * - SO THAT WE CAN DEPLOY THIS CONTRACT TO OTHER NETWORKS WITHOUT HAVING TO CHANGE THE CODE, WE JUST NEED TO PASS THE ADDRESS OF THE PRICE FEED FOR THAT NETWORK.
     */
    
    // RETURNED THE s_priceFeed VARIABLE , SO WE CAN REUSE THE CONTRACT TO OTHER NETWORKS WITHOUT HAVING TO CHANGE THE CODE, WE JUST NEED TO PASS THE ADDRESS OF THE PRICE FEED FOR THAT NETWORK.
      function getVersion() public view returns (uint256) {
        
        return s_priceFeed.version();
      }
    




//    function getConversionRate() public {

//     }

        
            /*
      - MODIFIERS in Solidity are primarily used to change the behavior of functions in a declarative,
       reusable way, enhancing code readability, maintainability, and security. 
      - They are mostly used to implement pre-conditions, such as access control (e.g.onlyOwner) or input validation, preventing duplicate code across multiple functions.
    */
    modifier onlyOwner() {
      // require(msg.sender == i_owner, "Sender is to owner, Must be owner");
      //_;

      /*INSTEAD OF USING A "revert" I USED A CUSTOM ERROR HERE
      */
      if (msg.sender != i_owner) {
        revert FundMe__NotOwner();
      }
      _;

      /*
      " Underscore" is a special character only used inside a function modifier and it tells Solidity to execute the rest of the code.
         TAKE THE FUNCTION MODIFIER onlyOwner, AND STICK IT IN THE FUNCTION "WITHDRAW".. 
         WHEN IT RUNS, IT GOONA EXECUTE THE  FUNCTION  "onlyOwner" , THEN IT WILL THEN EXECUTE OTHER THINGS ON THE FUNCTION ON "Withdraw"
      */ 
    }



    /*
      WHAT HAPPENS IF SOMEONE SENDS THIS ENTIRE CONTRACT (ETH) WITHOUT CALLING THE - FUND FUNCTION
    */
  receive() external payable {
    fund();
   }


   fallback() external payable {
     fund();
   }



  /**
   * CREATED THIS 3 FUNCTION (getter FUNCTIONS), TO CHECK TO SEE IF TO SEE THE 2 NUMBER " s_addressToAmountFundeds" & " s_funders" IF THEY ARE VISIBLE OR NOT (SINCE WE DEFINED IT private INITILALLY)
   * 
   *  
   * View / Pure FUNCTIONS (GETTERS)
   * 
   * CREATED THIS BECUS OF :  "mapping(address funder => uint256 amountFunded) private s_addressToAmountFundeds;" AND " address[] private  s_funders;" WHICH I MADE PRIVATE
   */

  // THIS IS FOR TESTING THE testFundUpdatesFundedDataStructure() FUNCTION, IN THE FundMeTest.t.sol file
  function  getAddressToAmountFunded (
    address fundingAddress
  )external view returns (uint256) {
    return s_addressToAmountFundeds[fundingAddress];
  }


// THIS IS FOR TESTING testAddsFunderToArrayOfFunders() FUNCTION , IN THE FundMeTest.s.sol file
  function getFunder(uint256 index) external view returns(address) {
    return s_funders[index];
  }


  function getOwner() external view returns(address) {

    return i_owner;
  } 


}















