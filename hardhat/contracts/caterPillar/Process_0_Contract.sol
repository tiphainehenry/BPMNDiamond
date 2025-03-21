pragma solidity ^0.8.19;

import "contracts/caterPillar/Process_0_WorkList.sol";

contract Process_0_Contract {
        uint tokens = 2;
        address owner ;
        address parent ;
        uint subprocesses = 0;
        uint [] requestedID;
        event Element_Execution_Completed(uint elementId);
        Process_0_WorkList workList;// = new Process_0_WorkList();
        uint active_a = 0;
                        
        constructor() {
            owner = msg.sender;
            for (uint i = 0; i < 0; i++)
                requestedID.push(0);
                workList = new Process_0_WorkList();
            //step(tokens);
        }
    
        function setParent(address newParent) public {
            if (owner == msg.sender)
                parent = newParent;
        }
    
        function handleGlobalDefaultEnd() public{
            // ................ Nothing to do ...........
        }

        function handleGlobalErrorEnd(bytes32 eventName) public {
            if (parent != address(0))
            Process_0_Contract(parent).handleGlobalErrorEnd(eventName);
            else
            tokens &= uint(~kill_Process_0());
         }

        function handleGlobalEscalationEnd(bytes32 eventName) public {
            if (parent != address(0))
            Process_0_Contract(parent).handleGlobalEscalationEnd(eventName);
         }

        function kill_Process_0() public returns (uint)  {
        uint tokensToKill = 0;
            tokensToKill |= uint(6);
            active_a = 0;
            tokens &= uint(~tokensToKill);
        return 0;   
        }

         function broadcastSignal_Process_0() public {
        // Nothing to do ...
        }
    
                        
        function a_start (uint localTokens) internal returns (uint) {
            uint reqId = workList.DefaultTask_start (this.a_callback);
            active_a |= uint(1) << reqId;
            return (localTokens & ~uint256(2));
        }
    
        function a_callback (uint reqId) public returns (bool) {
            if (active_a == 0) 
                return false;
            uint index = uint(1) << reqId;
            if(active_a & index == index) {
                active_a &= ~index;
                    
                step (tokens | 4);
                    emit Element_Execution_Completed(1);
                return true;
            }
            return false ;
        }
    
            function EndEvent_1rfz6w8(uint localTokens) internal returns (uint) {
            tokens = localTokens & ~uint(4);
                if (tokens & 6 != 0) {
                    return tokens;
            }
                if (parent != address(0))
                Process_0_Contract(parent).handleGlobalDefaultEnd();
                emit Element_Execution_Completed(2);
                return tokens;
        }
    
        function step(uint localTokens) public { 
            bool done = false;
            while (!done) {
                    if (localTokens & 2 == 2) {
                    localTokens = a_start(localTokens);
                    continue;
                }
                    if (localTokens & 4 == 4) {
                    localTokens = EndEvent_1rfz6w8(localTokens); 
                    continue;
                }
                    done = true;
            }
            tokens = localTokens;
        }
     
        function getRunningFlowNodes() public  returns (uint) {
            uint flowNodes = 0;
            uint localTokens = tokens;
                return flowNodes;
        }
    
            function getStartedFlowNodes() public  returns (uint) {
            uint flowNodes = 0;
            uint localTokens = tokens;
                if(active_a != 0)
                flowNodes |= 1;
                
                    return flowNodes;
        }
    
        function getWorkListAddress() public view returns (address) {
            return address(workList);
        }
    
        function getTaskRequestIndex(uint taskId) public view returns (uint) { 
            if (taskId == 1)
            return active_a;
        }
        function getToken() public view returns (uint){
            return tokens;
        }
            }
        

    
    

