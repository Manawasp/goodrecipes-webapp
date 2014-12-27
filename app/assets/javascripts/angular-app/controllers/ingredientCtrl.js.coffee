angular.module('app').controller("ingredientCtrl", ($scope, $location, $cookieStore, authorization, api, ingredientService)->
    console.log 'ingredientCtrl running'
    $scope.template = 'views/ingredient.html'
    $scope.error = ''
    $scope.ingredient = {description: "", labels: [], savours: [], blacklist: []}

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
      selectedIndex : 2
      showAdvancedSearch : false
      offset : 0
      limit : 40 
      ingredients : []
    }

    $scope.search = () ->
      searchIngredient()

    searchIngredient = () ->
      ingredientService.search($scope.ingredient.description,
                                $scope.ingredient.labels,
                                $scope.ingredient.savours,
                                $scope.ingredient.blacklist,
                                $scope.data.offset,
                                $scope.data.limit
      ).success((data) ->
        console.log "success data in search ingredient"
        console.log data
        $scope.data.ingredients = data.ingredients
      ).error((data) ->
        console.log "error data in search ingredient"
        console.log data
      )

    searchIngredient()
)