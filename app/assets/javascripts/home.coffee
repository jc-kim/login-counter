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
  $scope.logined = false
  $scope.login_username = null
  $scope.login_count = null

  login_callback = (data) ->
    if 'error_code' of data
      console.log codeToMsg[data['error_code']]
    else
      $scope.logined = true
      $scope.login_username = data['user_name']
      $scope.login_count = data['login_count']
      $scope.username = null
      $scope.password = null

  $scope.login = (username, password) ->
    $http.post '/login',
      username: username
      password: password
    .success login_callback

  $scope.signup = (username, password) ->
    $http.post '/signup',
      username: username
      password: password
    .success login_callback

  $scope.logout = () ->
    $scope.login_username = null
    $scope.login_count = null
    $scope.logined = false
])
