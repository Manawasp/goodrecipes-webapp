angular.module('app').controller("showrecipeCtrl", (homepageService, $routeParams, $mdDialog, $scope, $location, $cookieStore, authorization, api, recipeService, ingredientService, notifService)->
    console.log 'showrecipesCtrl running'
    $scope.template = 'views/showrecipe.html'
    $scope.error = ''
    $scope.ingredients = []
    $scope.recipe = {}
    $scope.mark = [0.5, 1.5, 2.5, 3.5, 4.5]

    $scope.redir_recipe = (id) ->
      $location.url('/recipes/show/' + id)

    $scope.editRecipe = (id) ->
      $location.url('/recipes/edit/' + id)

    recipeService.get($routeParams.id
    ).success((data) ->
      syncData(data)
    ).error((data) ->
      $location.url('/')
    )

    $scope.userRecipe = (id) ->
      $location.url('recipes/search?userId='+id);

    syncData = (data) ->
      console.log(data)
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

    $scope.makeFavorite = (value) ->
      if value
        recipeService.unfavorite($scope.recipe.id
        ).success((data) ->
          $scope.recipe.liked = false
        ).error((data) ->
          console.log("Make favorite error :" + data)
        )
      else
        recipeService.favorite($scope.recipe.id
        ).success((data) ->
          $scope.recipe.liked = true
        ).error((data) ->
          console.log("Make favorite error :" + data)
        )

    $scope.removeConfirm = (ev) ->
      confirm = $mdDialog.confirm()
        .title('Do you wnat to remove this recipe ?')
        .content($scope.recipe.title)
        .ariaLabel('Lucky day')
        .ok("I'm sure")
        .cancel('Cancel')
        .targetEvent(ev);
      $mdDialog.show(confirm).then(() ->
        recipeService.delete($scope.recipe.id
        ).success((data) ->
          notifService.success("Recipe removed")
          $location.url('/')
        ).error((data) ->
          notifService.error(data.error)
        )
      , () ->
        console.log("Choose to stop")
      )
)
