angular.module('app').controller("recipeCtrl", ($mdDialog, $scope, $location, $cookieStore, authorization, api, ingredientService, recipeService)->
    console.log 'recipeCtrl running'
    $scope.template = 'views/recipe.html'
    $scope.error = ''
    $scope.recipe = {description: "", labels: [], blacklist: []}
    $scope.labels = [{'c': false, 'name': 'breakfast & brunch'},  {'c': false, 'name': 'appetizer'},
                    {'c': false, 'name': 'dessert'},              {'c': false, 'name': 'healty'},
                    {'c': false, 'name': 'main dish'},            {'c': false, 'name': 'pasta'},
                    {'c': false, 'name': 'slow cooker'},          {'c': false, 'name': 'vegetarian'},
                    {'c': false, 'name': 'sauce'},                {'c': false, 'name': 'cheese'},
                    {'c': false, 'name': 'fruit'},                {'c': false, 'name': 'vegetable'},
                    {'c': false, 'name': 'sea food'},             {'c': false, 'name': 'fish'},
                    {'c': false, 'name': 'spicy'},                {'c': false, 'name': 'meat'},
                    {'c': false, 'name': 'chicken'},              {'c': false, 'name': 'beef'}]
    $scope.denied = [{'c': false, 'name': 'arachide'},  {'c': false, 'name': 'egg'},
                      {'c': false, 'name': 'milk'},     {'c': false, 'name': 'halal'},
                      {'c': false, 'name': 'kascher'}]
    $scope.ingredients = []
    $scope.search_ingredients = []
    $scope.show_search_advanced = false

    $scope.addLabel = (label) ->
      idx = $scope.recipe.labels.indexOf(label)
      if label && label.length > 0 && idx == -1
        $scope.recipe.labels.push label
    $scope.addBlacklist = (label) ->
      idx = $scope.recipe.blacklist.indexOf(label)
      if label && label.length > 0 && idx == -1
        $scope.recipe.blacklist.push label
    $scope.delLabel = (label) ->
      idx = $scope.recipe.labels.indexOf(label)
      if idx != -1
        $scope.recipe.labels.splice(idx, 1)
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
        console.log "success data in search ingredient"
        console.log data
        $scope.data.recipes = data.recipes
      ).error((data) ->
        # console.log "error data in search ingredient"
        # console.log data
      )


    $scope.showEditingRecipe = (data) ->
      recipeService.setView(true)
      recipeService.setCurrent(data)
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