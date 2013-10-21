angular.module('app.console', []).controller('ConsoleCtrl', function ConsoleCtrl($scope, $window){

  socket = $window.io.connect(url);
  var url  = 'http://'+ $window.location.hostname;

  if($window.location.port){
    url += ':' + $window.location.port;
  }

  $scope.outgoing = {
    name: 'remote',
    payload: "{ val: Math.random() }"
  }
  socket.emit('ping', {})
  socket.on('pong', function(res){
    
    $scope.$apply(function() {
      $scope.response = res;
    })
  });

  socket.on('remote', function (data) {
    console.log('remote:', data);
  });

  $scope.send = function(){
    socket.emit($scope.outgoing.name, $scope.outgoing.payload);
  } 
})