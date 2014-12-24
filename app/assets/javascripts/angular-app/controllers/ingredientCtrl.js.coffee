angular.module('app').controller("ingredientCtrl", ($scope, $location, $cookieStore, authorization, api)->
    console.log 'ingredientCtrl running'
    $scope.template = 'views/ingredient.html'
    $scope.error = ''
    $scope.ingredient = {labels: [], savours: [], blacklist: []}

    $scope.addLabels = (label) ->
      $scope.ingredient.labels.push label
    $scope.addSavours = (label) ->
      $scope.ingredient.savours.push label
    $scope.addBlacklist = (label) ->
      $scope.ingredient.blacklist.push label


    $scope.data = {
      selectedIndex : 3
    }
)