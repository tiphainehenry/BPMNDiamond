pragma solidity >=0.4.22 <0.9.0;

abstract contract AbstractFactory {
    address internal worklist = address(0);

    function setWorklist(address _worklist) external {
        worklist = _worklist;
    }

    function newInstance(address parent, address globalFactory) public virtual returns(address);
    function startInstanceExecution(address processAddress) public virtual;
}
