pragma solidity ^0.8.19;

import "contracts/caterPillar/AbstractFactory.sol";
import "contracts/caterPillar/BulkBuyer_.sol";

contract factoryBulkBuyer is AbstractFactory{
    address instance;
    function newInstance(address parent, address globalFactory) public override returns (address){
        BulkBuyer_ newContract = new BulkBuyer_();
        instance = address(newContract);
        return address(newContract);
        //return address(0);
    }

    function startInstanceExecution(address processAddress)public override{
        BulkBuyer_(processAddress).step(2);
    }

    function getInstance() public view returns (address){
        return instance;
    }
}