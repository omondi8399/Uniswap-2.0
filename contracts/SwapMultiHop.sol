// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.7.0 < 0.9.0;
pragma abicoder v2;

import "@uniswap/v3-periphery/contracts/libraries/TransferHelper.sol";
import "@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol";


contract SwapMultiHop{
        ISwapRouter public constant swapRouter =
        ISwapRouter(0xE592427A0AEce92De3Edee1F18E0157C05861564);

    function swapExactInputMultihop(address token0, address token1, uint amountIn) external returns (uint amountOut){
        TransferHelper.safeTransferFrom(token0, msg.sender, address(this), amountIn);

        TransferHelper.safeApprove(token0, address(swapRouter), amountIn);

        ISwapRouter.ExactInputParams memory params = ISwapRouter.ExactInputParams({
            path: abi.encodePacked(
                token0,
                uint24(3000),
                token1
            ),
            recipient: msg.sender,
            deadline: block.timestamp,
            amountIn: amountIn,
            amountOutMinimum: 0
        });
        amountOut = swapRouter.exactInput(params);
    }

     function swapExactOutputMultihop(address token0, address token1, uint amountOut, uint amountInMaximum) external returns (uint amountIn){
        TransferHelper.safeTransferFrom(token0, msg.sender, address(this), amountInMaximum);

        TransferHelper.safeApprove(token0, address(swapRouter), amountInMaximum);

        ISwapRouter.ExactOutputParams memory params = ISwapRouter.ExactOutputParams({
            path: abi.encodePacked(
                token1,
                uint24(3000),
                token0
            ),
            recipient: msg.sender,
            deadline: block.timestamp,
            amountOut: amountOut,
            amountInMaximum: amountInMaximum
        });

        amountIn = swapRouter.exactOutput(params);

        if(amountIn < amountInMaximum){
            TransferHelper.safeApprove(token0, address(swapRouter), 0);
            TransferHelper.safeTransferFrom(token0, address(this), msg.sender, amountInMaximum - amountIn);
        }
    }


}