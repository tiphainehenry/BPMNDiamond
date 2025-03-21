pragma solidity ^0.8.19;

import "contracts/caterPillar/Process_0_WorkList.sol";

contract BulkBuyer_ {
    uint tokens = 2;
    address owner;
    address parent;
    uint subprocesses = 0;
    uint [] requestedID;
    event Element_Execution_Completed(uint elementId);
    Process_0_WorkList workList;
    uint active_order_goods_ = 0;
    uint active_place_order_for_supplies_ = 0;
    uint active_forward_order_for_supplies_ = 0;
    uint active_place_order_for_transport_ = 0;
    uint active_request_details_ = 0;
    uint active_provide_details_ = 0;
    uint active_send_waybill_ = 0;
    uint active_deliver_supplies_ = 0;
    uint active_report_start_of_production_ = 0;
    uint active_Task_103qw3l = 0;
    uint nbBoucle;
    
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
            BulkBuyer_(parent).handleGlobalErrorEnd(eventName);
        else
            tokens &= uint(~kill_Process_0());
     }

    function handleGlobalEscalationEnd(bytes32 eventName) public {
        if (parent != address(0))
            BulkBuyer_(parent).handleGlobalEscalationEnd(eventName);
     }

    function kill_Process_0()public  returns (uint) {
        uint tokensToKill = 0;
        tokensToKill |= uint(32766);
        active_order_goods_ = 0;
        active_place_order_for_supplies_ = 0;
        active_forward_order_for_supplies_ = 0;
        active_place_order_for_transport_ = 0;
        active_request_details_ = 0;
        active_provide_details_ = 0;
        active_send_waybill_ = 0;
        active_deliver_supplies_ = 0;
        active_report_start_of_production_ = 0;
        active_Task_103qw3l = 0;
        tokens &= uint(~tokensToKill);
        return 0;   
    }

     function broadcastSignal_Process_0() public {
        // Nothing to do ...
    }


    function order_goods__start (uint localTokens) internal returns (uint) {
        uint reqId = workList.DefaultTask_start (this.order_goods__callback);
        active_order_goods_ |= uint(1) << reqId;
        return (localTokens & ~uint256(2));
    }

    function order_goods__callback (uint reqId) public returns (bool) {
        if (active_order_goods_ == 0) 
            return false;
        uint index = uint(1) << reqId;
        if(active_order_goods_ & index == index) {
            active_order_goods_ &= ~index;
            
            step (tokens | 4);
            emit Element_Execution_Completed(1);
            return true;
        }
        return false ;
    }


    function place_order_for_supplies__start (uint localTokens) internal returns (uint) {
        uint reqId = workList.DefaultTask_start (this.place_order_for_supplies__callback);
        active_place_order_for_supplies_ |= uint(1) << reqId;
        return (localTokens & ~uint256(4));
    }

    function place_order_for_supplies__callback (uint reqId) public returns (bool) {
        if (active_place_order_for_supplies_ == 0) 
            return false;
        uint index = uint(1) << reqId;
        if(active_place_order_for_supplies_ & index == index) {
            active_place_order_for_supplies_ &= ~index;
            nbBoucle =0;
            step (tokens | 8);
            emit Element_Execution_Completed(2);
            return true;
        }
        return false ;
    }


    function forward_order_for_supplies__start (uint localTokens) internal returns (uint) {
        uint reqId = workList.DefaultTask_start (this.forward_order_for_supplies__callback);
        active_forward_order_for_supplies_ |= uint(1) << reqId;
        return (localTokens & ~uint256(16));
    }

    function forward_order_for_supplies__callback (uint reqId) public returns (bool) {
        if (active_forward_order_for_supplies_ == 0) 
            return false;
        uint index = uint(1) << reqId;
        if(active_forward_order_for_supplies_ & index == index) {
            active_forward_order_for_supplies_ &= ~index;
            
            step (tokens | 128);
            emit Element_Execution_Completed(4);
            return true;
        }
        return false ;
    }


    function place_order_for_transport__start (uint localTokens) internal returns (uint) {
        uint reqId = workList.DefaultTask_start (this.place_order_for_transport__callback);
        active_place_order_for_transport_ |= uint(1) << reqId;
        return (localTokens & ~uint256(32));
    }

    function place_order_for_transport__callback (uint reqId) public returns (bool) {
        if (active_place_order_for_transport_ == 0) 
            return false;
        uint index = uint(1) << reqId;
        if(active_place_order_for_transport_ & index == index) {
            active_place_order_for_transport_ &= ~index;
            
            step (tokens | 64);
            emit Element_Execution_Completed(8);
            return true;
        }
        return false ;
    }


    function request_details__start (uint localTokens) internal returns (uint) {
        uint reqId = workList.DefaultTask_start (this.request_details__callback);
        active_request_details_ |= uint(1) << reqId;
        return (localTokens & ~uint256(256));
    }

    function request_details__callback (uint reqId) public returns (bool) {
        if (active_request_details_ == 0) 
            return false;
        uint index = uint(1) << reqId;
        if(active_request_details_ & index == index) {
            active_request_details_ &= ~index;
            
            step (tokens | 512);
            emit Element_Execution_Completed(16);
            return true;
        }
        return false ;
    }


    function provide_details__start (uint localTokens) internal returns (uint) {
        uint reqId = workList.DefaultTask_start (this.provide_details__callback);
        active_provide_details_ |= uint(1) << reqId;
        return (localTokens & ~uint256(512));
    }

    function provide_details__callback (uint reqId) public returns (bool) {
        if (active_provide_details_ == 0) 
            return false;
        uint index = uint(1) << reqId;
        if(active_provide_details_ & index == index) {
            active_provide_details_ &= ~index;
            
            step (tokens | 1024);
            emit Element_Execution_Completed(32);
            return true;
        }
        return false ;
    }


    function send_waybill__start (uint localTokens) internal returns (uint) {
        uint reqId = workList.DefaultTask_start (this.send_waybill__callback);
        active_send_waybill_ |= uint(1) << reqId;
        return (localTokens & ~uint256(1024));
    }

    function send_waybill__callback (uint reqId) public returns (bool) {
        if (active_send_waybill_ == 0) 
            return false;
        uint index = uint(1) << reqId;
        if(active_send_waybill_ & index == index) {
            active_send_waybill_ &= ~index;
            
            step (tokens | 2048);
            emit Element_Execution_Completed(64);
            return true;
        }
        return false ;
    }


    function deliver_supplies__start (uint localTokens) internal returns (uint) {
        uint reqId = workList.DefaultTask_start (this.deliver_supplies__callback);
        active_deliver_supplies_ |= uint(1) << reqId;
        return (localTokens & ~uint256(2048));
    }

    function deliver_supplies__callback (uint reqId) public returns (bool) {
        if (active_deliver_supplies_ == 0) 
            return false;
        uint index = uint(1) << reqId;
        if(active_deliver_supplies_ & index == index) {
            active_deliver_supplies_ &= ~index;
            
            step (tokens | 4096);
            emit Element_Execution_Completed(128);
            return true;
        }
        return false ;
    }


    function report_start_of_production__start (uint localTokens) internal returns (uint) {
        uint reqId = workList.DefaultTask_start (this.report_start_of_production__callback);
        active_report_start_of_production_ |= uint(1) << reqId;
        return (localTokens & ~uint256(4096));
    }

    function report_start_of_production__callback (uint reqId) public returns (bool) {
        if (active_report_start_of_production_ == 0) 
            return false;
        uint index = uint(1) << reqId;
        if(active_report_start_of_production_ & index == index) {
            active_report_start_of_production_ &= ~index;
            
            step (tokens | 8192);
            emit Element_Execution_Completed(256);
            return true;
        }
        return false ;
    }


    function Task_103qw3l_start (uint localTokens) internal returns (uint) {
        uint reqId = workList.DefaultTask_start (this.Task_103qw3l_callback);
        active_Task_103qw3l |= uint(1) << reqId;
        return (localTokens & ~uint256(8192));
    }

    function Task_103qw3l_callback (uint reqId) public returns (bool) {
        if (active_Task_103qw3l == 0) 
            return false;
        uint index = uint(1) << reqId;
        if(active_Task_103qw3l & index == index) {
            active_Task_103qw3l &= ~index;
            
            step (tokens | 16384);
            emit Element_Execution_Completed(512);
            return true;
        }
        return false ;
    }

    function EndEvent_0r1chkn(uint localTokens) internal returns (uint) {
        tokens = localTokens & ~uint(16384);
        if (tokens & 32766 != 0) {
            return tokens;
        }
        if (parent != address(0))
            BulkBuyer_(parent).handleGlobalDefaultEnd();
        emit Element_Execution_Completed(1024);
        return tokens;
    }

    function step(uint localTokens) public { 
        bool done = false;
        while (!done) {
            nbBoucle++;
            if (localTokens & 2 == 2) {
                localTokens = order_goods__start(localTokens);
                continue;
            }
            if (localTokens & 4 == 4) {
                localTokens = place_order_for_supplies__start(localTokens);
                continue;
            }
            if (localTokens & 16 == 16) {
                localTokens = forward_order_for_supplies__start(localTokens);
                continue;
            }
            if (localTokens & 32 == 32) {
                localTokens = place_order_for_transport__start(localTokens);
                continue;
            }
            if (localTokens & 256 == 256) {
                localTokens = request_details__start(localTokens);
                continue;
            }
            if (localTokens & 512 == 512) {
                localTokens = provide_details__start(localTokens);
                continue;
            }
            if (localTokens & 1024 == 1024) {
                localTokens = send_waybill__start(localTokens);
                continue;
            }
            if (localTokens & 2048 == 2048) {
                localTokens = deliver_supplies__start(localTokens);
                continue;
            }
            if (localTokens & 4096 == 4096) {
                localTokens = report_start_of_production__start(localTokens);
                continue;
            }
            if (localTokens & 8192 == 8192) {
                localTokens = Task_103qw3l_start(localTokens);
                continue;
            }
            if (localTokens & 16384 == 16384) {
                localTokens = EndEvent_0r1chkn(localTokens); 
                continue;
            }
            if (localTokens & 8 == 8) {      
                localTokens = localTokens & ~uint(8) | 48;
                continue;
            }
            if (localTokens & 192 == 192) {      
                localTokens = localTokens & ~uint(192) | 256;
                continue;
            }
            done = true;
        }
        tokens = localTokens;
    }
 
    function getRunningFlowNodes() public returns (uint) {
        uint flowNodes = 0;
        uint localTokens = tokens;
        return flowNodes;
    }

    function getStartedFlowNodes() public returns (uint) {
        uint flowNodes = 0;
        uint localTokens = tokens;
        if(active_order_goods_ != 0)
            flowNodes |= 1;
        if(active_place_order_for_supplies_ != 0)
            flowNodes |= 2;
        if(active_forward_order_for_supplies_ != 0)
            flowNodes |= 4;
        if(active_place_order_for_transport_ != 0)
            flowNodes |= 8;
        if(active_request_details_ != 0)
            flowNodes |= 16;
        if(active_provide_details_ != 0)
            flowNodes |= 32;
        if(active_send_waybill_ != 0)
            flowNodes |= 64;
        if(active_deliver_supplies_ != 0)
            flowNodes |= 128;
        if(active_report_start_of_production_ != 0)
            flowNodes |= 256;
        if(active_Task_103qw3l != 0)
            flowNodes |= 512;

        return flowNodes;
    }

    function getWorkListAddress()public view returns (address) {
        return address(workList);
    }

    function getTaskRequestIndex(uint taskId) public view returns (uint) { 
        if (taskId == 1)
            return active_order_goods_;
        if (taskId == 2)
            return active_place_order_for_supplies_;
        if (taskId == 4)
            return active_forward_order_for_supplies_;
        if (taskId == 8)
            return active_place_order_for_transport_;
        if (taskId == 16)
            return active_request_details_;
        if (taskId == 32)
            return active_provide_details_;
        if (taskId == 64)
            return active_send_waybill_;
        if (taskId == 128)
            return active_deliver_supplies_;
        if (taskId == 256)
            return active_report_start_of_production_;
        if (taskId == 512)
            return active_Task_103qw3l;
    }
    function getToken() public view returns (uint){
        return tokens;
    }

    function getBoucle() public view returns (uint){
        return nbBoucle;
    }

}



// contract Process_0_WorkList {
//     struct DefaultTask_Request {
//         function (uint) external returns (bool) callback;    
//     }
//     DefaultTask_Request [] DefaultTask_requests;

//     function DefaultTask_start (function (uint) external returns (bool) callback) returns (uint) {
//         uint index = DefaultTask_requests.length;
//         DefaultTask_requests.push(DefaultTask_Request(callback));
//         return index;
//     }
    
//     function DefaultTask_callback (uint reqId) {
//         DefaultTask_requests[reqId].callback(reqId);
//     }

// }
