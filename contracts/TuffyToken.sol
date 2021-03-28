//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TuffyToken is ERC20 {

  constructor(uint256 initialSupply) ERC20("TuffyToken", "TT") {
    _mint(msg.sender, initialSupply);
  }

  modifier noZeroAddress(address a) {
    require(address(0) != a, "cannot use zero address");
    _;
  }

  function mintTokens(uint256 amount) public {
    _mint(msg.sender, amount);
  }

  function _balanceOf(address account) view public returns(uint256) {
    return balanceOf(account);
  }

  function _transfer(address recip, uint256 amount) 
  noZeroAddress(recip)
  public   
  {
    transfer(recip, amount);
  }
}
