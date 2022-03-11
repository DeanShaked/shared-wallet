pragma solidity ^0.5.13;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract SimpleWallet  is Ownable {

    using SafeMath for uint;
    mapping (address => uint) public allowance;

    function addAllowance (address _who,uint _amount) public onlyOwner {
        allowance[_who] = _amount;
    }


    modifier ownerOrAllowed(uint _amount) { 
        require(isOwner() || allowance[msg.sender] >= _amount,'You are not allowed');
        _;
    }

    function reduceAllowance(address _who, uint _amount) {
        allowance[_who].sub(_amount);
    }


    function withdrawMoney(address payable _to,uint _amount) public ownerOrAllowed(_amount) {
        if(!isOwner()) {
            reduceAllowance(msg.sender,_amount);
        }
        _to.transfer(_amount);
    }

    function () external payable {
        
    }
}