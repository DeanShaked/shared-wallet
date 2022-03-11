pragma solidity ^0.5.13;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Allowance is Ownable {

    event AllowanceChanged(address _forWho,address _fromWhom,uint _oldAmount,uint _newAmount);

    using SafeMath for uint;
    mapping (address => uint) public allowance;

    function addAllowance (address _who,uint _amount) public onlyOwner {
        emit AllowanceChanged(_who, msg.sender, allowance[_who], _amount);
        allowance[_who] = _amount;
    }


    modifier ownerOrAllowed(uint _amount) { 
        require(isOwner() || allowance[msg.sender] >= _amount,'You are not allowed');
        _;
    }

    function reduceAllowance(address _who, uint _amount) {
        emit AllowanceChanged(_who, msg.sender, allowance[_who], allowance[_who].sub(_amount));
        allowance[_who].sub(_amount);
    }

}