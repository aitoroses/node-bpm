'use strict';

var app = angular.module('eApproval', ['ngRoute']);

app.config(['$routeProvider', function($routeProvider){
	$routeProvider
	.when('/:requestId', {
		templateUrl: 'views/main.html',
		controller: 'mainCtrl as main'
	})
	.otherwise('/');
}]);

app.controller('mainCtrl', [ '$http', '$scope', '$routeParams' ,function($http, $scope, $routeParams){

	$scope.requestId = $routeParams.requestId || 2756;

	$http.get('http://localhost:9000/form/'+ $scope.requestId +'?format=json').success(function(data){
		$scope.form = data;
		$scope.general = data[1];
		$scope.details = data[2];
	});

}]);