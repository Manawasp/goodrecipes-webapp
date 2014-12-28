angular.module('app').controller("recipeCtrl", ($scope, $location, $cookieStore, authorization, api, ingredientService)->
    console.log 'recipeCtrl running'
    # $scope.template = 'views/recipe.html'
    # $scope.error = ''
    # $scope.recipe = {labels: [], savours: [], blacklist: []}

    # $scope.data = {
    #   selectedIndex : 1
    # }

    # $scope.addLabels = (label) ->
    #   $scope.recipe.labels.push label
    # $scope.addSavours = (label) ->
    #   $scope.recipe.savours.push label
    # $scope.addBlacklist = (label) ->
    #   $scope.recipe.blacklist.push label

    # console.log 'ingredientCtrl running'
    $scope.template = 'views/recipe.html'
    $scope.error = ''
    $scope.recipe = {description: "", labels: [], savours: [], blacklist: []}

    $scope.addLabel = (label) ->
      idx = $scope.recipe.labels.indexOf(label)
      if label && label.length > 0 && idx == -1
        $scope.recipe.labels.push label
    $scope.addSavour = (label) ->
      idx = $scope.recipe.savours.indexOf(label)
      if label && label.length > 0 && idx == -1
        $scope.recipe.savours.push label
    $scope.addBlacklist = (label) ->
      idx = $scope.recipe.blacklist.indexOf(label)
      if label && label.length > 0 && idx == -1
        $scope.recipe.blacklist.push label
    $scope.delLabel = (label) ->
      idx = $scope.recipe.labels.indexOf(label)
      if idx != -1
        $scope.recipe.labels.splice(idx, 1)
    $scope.delSavour = (label) ->
      idx = $scope.recipe.savours.indexOf(label)
      if idx != -1
        $scope.recipe.savours.splice(idx, 1)
    $scope.delBlacklist = (label) ->
      idx = $scope.recipe.blacklist.indexOf(label)
      if idx != -1
        $scope.recipe.blacklist.splice(idx, 1)

    $scope.advancedSearch = () ->
      $scope.data.showAdvancedSearch = !$scope.data.showAdvancedSearch

    $scope.data = {
      selectedIndex : 1
      showAdvancedSearch : false
      offset : 0
      limit : 40 
      recipes : []
    }

    $scope.search = () ->
      searchRecipe()

    searchRecipe = () ->
      recipeService.search($scope.recipe.description,
                                $scope.recipe.labels,
                                $scope.recipe.savours,
                                $scope.recipe.blacklist,
                                $scope.data.offset,
                                $scope.data.limit
      ).success((data) ->
        # console.log "success data in search ingredient"
        # console.log data
        $scope.data.recipes = data.recipes
      ).error((data) ->
        # console.log "error data in search ingredient"
        # console.log data
      )


    $scope.showEditingRecipe = (data) ->
      ingredientRecipe.setView(true)
      ingredientRecipe.setCurrent(data)
      console.log(data)
      $mdDialog.show(
        controller: 'editrecipeCtrl'
        templateUrl: "/views/editrecipe.html"
      ).then (() ->
        # $scope.alert = "You said the information was \"" + answer + "\"."
      ), ->
        # $scope.alert = "You cancelled the dialog."

    $scope.showCreateRecipe = (data) ->
      $mdDialog.show(
        controller: 'createrecipeCtrl'
        templateUrl: "/views/createrecipe.html"
      ).then (() ->
        # $scope.alert = "You said the information was \"" + answer + "\"."
      ), ->
        # $scope.alert = "You cancelled the dialog."

    searchRecipe()
)