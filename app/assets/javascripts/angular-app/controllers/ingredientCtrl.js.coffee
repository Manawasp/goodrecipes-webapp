angular.module('app').controller("ingredientCtrl", ($scope, $location, $cookieStore, authorization, api)->
    console.log 'ingredientCtrl running'
    $scope.template = 'views/ingredient.html'
    $scope.error = ''
    $scope.ingredient = {labels: [], savours: [], blacklist: []}

    $scope.addLabel = (label) ->
      idx = $scope.ingredient.labels.indexOf(label)
      if label && label.length > 0 && idx == -1
        $scope.ingredient.labels.push label
    $scope.addSavour = (label) ->
      idx = $scope.ingredient.savours.indexOf(label)
      if label && label.length > 0 && idx == -1
        $scope.ingredient.savours.push label
    $scope.addBlacklist = (label) ->
      idx = $scope.ingredient.blacklist.indexOf(label)
      if label && label.length > 0 && idx == -1
        $scope.ingredient.blacklist.push label
    $scope.delLabel = (label) ->
      idx = $scope.ingredient.labels.indexOf(label)
      if idx != -1
        $scope.ingredient.labels.splice(idx, 1)
    $scope.delSavour = (label) ->
      idx = $scope.ingredient.savours.indexOf(label)
      if idx != -1
        $scope.ingredient.savours.splice(idx, 1)
    $scope.delBlacklist = (label) ->
      idx = $scope.ingredient.blacklist.indexOf(label)
      if idx != -1
        $scope.ingredient.blacklist.splice(idx, 1)


    $scope.advancedSearch = () ->
      $scope.data.showAdvancedSearch = !$scope.data.showAdvancedSearch

    $scope.data = {
      selectedIndex : 2,
      showAdvancedSearch : false
    }
)