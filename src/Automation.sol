// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "chainlink/interfaces/automation/AutomationCompatibleInterface.sol";
import "chainlink/interfaces/AggregatorV3Interface.sol";

contract Automation is AutomationCompatibleInterface {
    AggregatorV3Interface internal dataFeed;

    uint public counter;
    uint256 public lastETH_USDC_Price;

    uint public immutable interval;
    uint public lastTimeStamp;

    constructor(uint updateInterval) {
        interval = updateInterval;
        lastTimeStamp = block.timestamp;

        dataFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306 // ETH/USD Sepolia
        );
    }

    function checkUpkeep(
        bytes calldata /* checkData */
    )
        external
        view
        override
        returns (bool upkeepNeeded, bytes memory /* performData */)
    {
        upkeepNeeded = (block.timestamp - lastTimeStamp) > interval;
    }

    function performUpkeep(
        bytes calldata /* performData */
    ) external override {
        //We highly recommend revalidating the upkeep in the performUpkeep function
        if ((block.timestamp - lastTimeStamp) > interval) {
            lastTimeStamp = block.timestamp;
            ++counter;
            lastETH_USDC_Price = uint256(getLatestData());
        }
    }

    function getLatestData() public view returns (int) {
        (
            ,
            /* uint80 roundID */ int answer /*uint startedAt*/ /*uint timeStamp*/ /*uint80 answeredInRound*/,
            ,
            ,

        ) = dataFeed.latestRoundData();
        return answer;
    }
}
