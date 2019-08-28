pragma solidity 0.4.25;

contract Pointer {
  address public getAddress;

  constructor(address _addr) public {
    getAddress = _addr;
  }
}
