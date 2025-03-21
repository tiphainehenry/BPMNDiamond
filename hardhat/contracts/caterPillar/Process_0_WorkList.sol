contract Process_0_WorkList {
    struct DefaultTask_Request {
        function (uint) external returns (bool) callback;    
    }
    DefaultTask_Request [] DefaultTask_requests;

    function DefaultTask_start (function (uint) external returns (bool) callback) public  returns (uint){
        uint index = DefaultTask_requests.length;
        DefaultTask_requests.push(DefaultTask_Request(callback));
        return index;
    }
    
    function DefaultTask_callback (uint reqId) public {
        DefaultTask_requests[reqId].callback(reqId);
    }

    }
