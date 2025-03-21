pragma solidity ^0.8.19;

import "contracts/caterPillar/AbstractFactory.sol";
import "contracts/caterPillar/Process_0_Contract.sol";

contract factory3 is AbstractFactory{
    address instance;
    function newInstance(address parent, address globalFactory) public override returns (address){
        Process_0_Contract newContract = new Process_0_Contract();
        instance = address(newContract);
        return address(newContract);
        //return address(0);
    }

    function startInstanceExecution(address processAddress)public override{
        Process_0_Contract(processAddress).step(2);
    }

    function getInstance() public view returns (address){
        return instance;
    }
}