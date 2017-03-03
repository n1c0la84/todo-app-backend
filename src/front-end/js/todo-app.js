var app = angular.module('todo-app', []);
    app.controller('controller', function($scope, $http) {
        $http.get('http://localhost:4567/todo-app/todos').then(function(resp) {
        $scope.todos = resp.data; });
        
        $scope.add = function(contenuto) {
          $http.post('http://localhost:4567/todo-app/todos', {content: contenuto});
          window.location.reload();
        }
});
