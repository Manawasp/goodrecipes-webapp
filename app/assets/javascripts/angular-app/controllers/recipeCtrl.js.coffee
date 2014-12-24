angular.module('app').controller("recipeCtrl", ($scope, $location, $cookieStore, authorization, api)->
    console.log 'recipeCtrl running'
    $scope.template = 'views/recipe.html'
    $scope.error = ''
    $scope.recipe = {labels: [], savours: [], blacklist: []}

    $scope.data = {
      selectedIndex : 1
    }

    $scope.addLabels = (label) ->
      $scope.recipe.labels.push label
    $scope.addSavours = (label) ->
      $scope.recipe.savours.push label
    $scope.addBlacklist = (label) ->
      $scope.recipe.blacklist.push label
)