angular.module('app').controller("recipeCtrl", ($mdDialog, $routeParams, $scope, $location, $cookieStore, authorization, api, ingredientService, recipeService)->
    console.log 'recipeCtrl running'
    $scope.template = 'views/recipe.html'
    $scope.error = ''
    searchObject = recipeService.getSearch()
    $scope.recipe = searchObject.recipe
    $scope.labels = searchObject.labels
    $scope.denied = searchObject.denied
    $scope.data   = searchObject.data
    recipeService.getSearchReset()
    $scope.recipe.description = $routeParams.title || ""
    $scope.more_recipe = searchObject.more_recipe
    $scope.show_search_advanced = false
    $scope.show_search_advanced_label = false

    $scope.redir_recipe = (id) ->
      $location.url('/recipes/show/' + id)

    searchRecipe = () ->
      recipeService.getApplySearch()

    searchRecipe()
)
