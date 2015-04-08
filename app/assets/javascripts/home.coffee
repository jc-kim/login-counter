# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
codeToMsg =
  "-1": "The user name should be 5~20 characters long. Please try again."
  "-2": "The password should be 8~20 characters long. Please try again."
  "-3": "This user name already exists. Please try again."
  "-4": "Invalid username and password combination. Please try again. "

this.app = angular.module('app', [])
this.app.controller('loginController', ['$scope', '$http', ($scope, $http) ->
  $scope.login = (username, password) ->
    $http.post '/login',
      username: username
      password: password
    .success (data) ->
      console.log codeToMsg[data['error_code']]

  $scope.signup = (username, password) ->
    $http.post '/signup',
      username: username
      password: password
    .success (data) ->
      console.log codeToMsg[data['error_code']]
])
