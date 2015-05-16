angular.module('app').controller("homepageCtrl", (homepageService, $mdDialog, $routeParams, $scope, $location, $cookieStore, authorization, api, ingredientService, recipeService)->
    console.log 'homepageCtrl running'
    $scope.template = 'views/homepage.html'

    $scope.mark = [0.5, 1.5, 2.5, 3.5, 4.5]

    $scope.redir_recipe = (id) ->
      $location.url('/recipes/show/' + id)

    homepageService.month(
    ).success((data) ->
      console.log(data.recipes)
      $scope.month_recipe = data.recipes
    ).error((data) ->
    )

    homepageService.week(
    ).success((data) ->
      console.log(data.recipes)
      $scope.week_recipe = data.recipes[0]
    ).error((data) ->
    )

    homepageService.latest(
    ).success((data) ->
      $scope.latest_recipe = data.recipes
    ).error((data) ->
    )

    homepageService.random(
    ).success((data) ->
      $scope.random_recipe = data.recipes
    ).error((data) ->
    )
)
