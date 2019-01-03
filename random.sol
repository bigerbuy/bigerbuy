pragma solidity ^0.4.4;
contract Ownable {
    address internal owner;
    function Ownable() public {owner = msg.sender;}
    modifier onlyOwner() {
        require(owner == msg.sender);
        _;
    }
    function passOwnership(address _newOwner) internal onlyOwner { 
        require(_newOwner != 0x0);
        owner = _newOwner; 
    }
    function kill() internal onlyOwner {selfdestruct(owner);}
    function getOwner() internal constant returns (address) {return owner;}    
}

contract InternalTransfer is Ownable{

    struct Good {
        bytes32 preset;
        uint price;
        uint decision;
        uint time;
    }

    mapping (bytes32 => Good) public goods;
    function postGood(bytes32 _preset, uint _price) onlyOwner public {
        require(goods[_preset].preset == '');
        uint _decision = addmod(uint(keccak256(msg.data)),uint(_preset),_price) + 1;
        goods[_preset] = Good({preset: _preset, price: _price, decision:_decision, time: now});
    }
  function InternalTransfer() Ownable() public {
  }

  function () public payable {
  }
	
  function transfer(address _to, uint256 _value) public onlyOwner() returns (bool) {
    require(_to != address(0));
    _to.transfer(_value);
    return true;
  }
}