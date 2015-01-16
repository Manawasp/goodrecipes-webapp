angular.module('app').controller("markrecipeCtrl", ($mdDialog, $scope, $location, $cookieStore, authorization, api, ingredientService)->
  $scope.mark = 5


  $scope.cancel = () ->
    $mdDialog.cancel()


  $scope.validate = () ->
    $mdDialog.cancel()
)