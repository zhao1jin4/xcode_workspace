function sendCommand(cmd,param){
    var url="testapp:"+cmd+":"+param;
    document.location = url;
}
function clickLink(){
    sendCommand("alert","你好吗？");
}