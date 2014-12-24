angular.module('app').controller("ExampleCtrl", [
  '$scope',
  ($scope)->
    console.log 'ExampleCtrl running'

    $scope.exampleValue = "Hello angular and rails"

])