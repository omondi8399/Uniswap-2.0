// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.7.0 < 0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract BooToken is ERC20{

    constructor() ERC20("LF", "Boo"){
        _mint(msg.sender, 100000 * 10 ** decimals());
    }
}