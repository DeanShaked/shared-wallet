pragma solidity ^0.5.13;

import "./Allowance.sol"


contract SimpleWallet is Allowance {

    event MoneySent(address index _beneficiary, uint _amount);

    event MoneyRecieved(address index _from, uint _amount);

    function withdrawMoney(address payable _to,uint _amount) public ownerOrAllowed(_amount) {
        require(_amount < address(this).balance,'There are not enough funds in the smart contract');
        if(!isOwner()) {
            reduceAllowance(msg.sender,_amount);
        }
        emit MoneySent(_to,_amount);
        _to.transfer(_amount);
    }

    function renouceOwnership() public onlyOwner {
        revert('Cant renouce ownership here');
    }
    function () external payable {
        emit MoneyRecieved(msg.sender,msg.value);
    }
}