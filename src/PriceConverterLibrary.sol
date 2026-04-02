// SPDX-License-Identifier: MIT


pragma solidity ^0.8.18;

 /*
  - LIBRARIES IN SOLIDITY ARE CREATED PRIMARIRY FOR "CODE REUSABILITY" , "MODULARITY" AND GAS EFFICIENCY.
  - THEY FUNCTION AS COLLECTIONS OF FUNCTIONS THAT CAN BE USED BY MULTIPLE SMART CONTRACTS.
*/



import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";



library PriceConverterLibrary {

    /**
     *  WE CAN OR COULD MAKE THIS FUNCTION  "PUBLIC" OR "EXTERNAL" BUT WE MADE IT "INTERNAL" BECAUSE THIS FUNCTION IS ONLY USED INSIDE THIS LIBRARY AND ALSO THIS FUNCTION IS CALLED BY OTHER FUNCTION IN THIS LIBRARY.
    */
      function getPrice(AggregatorV3Interface priceFeed) internal  view returns (uint256) {
      
        //Sepolia ETH / USD Address
        //https://docs.chain.link/data-feeds/price-feeds/addresses
        //https://docs.chain.link/data-feeds/price-feeds/addresses?network=sepolia


        // AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
       

        /**RETURNING MULTIPLY TYPE (BELOW)
        int256 price: THE REASON WHY PRICE IS INT256 IS BECAUSE , SOME PRICEFEED CAN BE "NEGATIVE"(DECIMAL) 18
        */
        (, int256 price,,,) = priceFeed.latestRoundData();
        // (uint80 roundId, int256 price, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound) = priceFeed.latestRoundData();


         /*
            - PRICE OF ETH IN TERMS OF USD
             3000.00000000

            - "return price * 1e10;" IS A LINE OF SOLIDITY CODE COMMONLY USED TO CONVERT CHAINLINK PRICE FEED
                DATA (WHICH OFTEN HAS 8 DECIMALS) TO THE 18-DECIMAL PRECISION USED BY  Ether (Wei). 
        */
        // return uint256(price * 1e10);
          return uint256(price * 10000000000);
    }



    function getConversionRate(uint256 ethAmount, AggregatorV3Interface priceFeed) internal view returns(uint256) {
        uint256 ethPrice = getPrice(priceFeed);

        /*
            E.G1  1000000000000000000 * 1000000000000000000  = 1000000000000000000000000000000000000 / 1e18
            
            E.G2 : 1 ETH = 2000_000000000000000000 (2000 USD)
            (2000_000000000000000000 * 1_000000000000000000) / 1e18
            $2000 = 1ETH
        */
        // uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1000000000000000000;
        
        return ethAmountInUsd;
    }


    function getVersion() internal  view returns (uint256) {
         return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }    
}








