angular.module('app').controller("showrecipeCtrl", (homepageService, $routeParams, $mdDialog, $scope, $location, $cookieStore, authorization, api, recipeService, ingredientService)->
    console.log 'showrecipesCtrl running'
    $scope.template = 'views/showrecipe.html'
    $scope.error = ''
    $scope.ingredients = []
    $scope.mark = [0.5, 1.5, 2.5, 3.5, 4.5]

    recipeService.get($routeParams.id
    ).success((data) ->
      syncData(data)
    ).error((data) ->
      $location.url('/')
    )

    syncData = (data) ->
      $scope.recipe = data.recipe
      if $scope.recipe.minutes == undefined || $scope.recipe.hours == undefined
        data.recipe.time = "1h00"
      else
        addZero = if $scope.recipe.minutes < 10 then "0" else ""
        data.recipe.time = $scope.recipe.hours.toString() + "h" + $scope.recipe.minutes.toString() + addZero
      $scope.author = data.user
      # init steps if empty
      if data.recipe.steps.length == 0
        $scope.recipe.steps.push ""
      # sync ingredient
      ingredientService.clean()
      ingredientService.setLock(true)
      igs = ingredientService.getSearch()
      for ig in data.ingredients
        igs.push ig

    homepageService.random(3
    ).success((data) ->
      $scope.more_recipe = data.recipes
    ).error((data) ->
    )

    $scope.markRecipe = (data) ->
      $mdDialog.show(
        controller: 'markrecipeCtrl'
        templateUrl: "/views/markrecipe.html"
      ).then (() ->
        # $scope.alert = "You said the information was \"" + answer + "\"."
      ), ->
        # $scope.alert = "You cancelled the dialog."

)
