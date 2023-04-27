// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.7.0 < 0.9.0;
pragma abicoder v2;

import "@uniswap/v3-periphery/contracts/libraries/TransferHelper.sol";
import "@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol";

contract SingleSwapToken{
    ISwapRouter public constant swapRouter = ISwapRouter(0xEB5BJDMDMMSFMFFGJDW4643M333MM333322B);

    address public constant DAI = 0x3kdkm4mmxkskdkdkk34093kdcx9499;
    address public constant WETH9 = 0x3kdkm4mmxkskdkdkk34093kdcx9499;
    address public constant USDC = 0x3kdkm4mmxkskdkdkk34093kdcx9499;

    function swapExactInputString(uint amountIn) external returns (uint amountOut){

        TransferHelper.safeTransferFrom(WETH9, msg.sender, address(this), amountIn);

        TransferHelper.safeApprove(WETH9, address(swapRouter), amountIn);

        ISwapRouter.ExactInputSingleParams memory params = ISwapRouter.ExactInputSingleParams({
            tokenIn: WETH9,
            tokenOut: DAI,

            fee: 3000,
            recipient: msg.sender,
            deadline: block.timestamp,
            amountIn: amountIn,
            amountOutMinimum: 0,
            sqrtPriceLimitx96: 0
        });

        amountOut = swapRouter.exactInputSingle(params);

    }
}