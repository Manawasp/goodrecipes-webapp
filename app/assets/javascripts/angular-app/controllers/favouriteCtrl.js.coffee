angular.module('app').controller("favouriteCtrl", ($mdDialog, $scope, $location,$routeParams, $cookieStore, authorization, api, recipeService)->
    console.log 'favouriteCtrl running'
    $scope.template = 'views/favourite.html'
    $scope.data = {offset: 0, limit: 20, tableView: true}
    $scope.mark = [0.5, 1.5, 2.5, 3.5, 4.5]

    $scope.redir_recipe = (id) ->
      $location.url('/recipes/show/' + id)


    recipeService.searchFavourite($scope.data.offset, $scope.data.limit
    ).success((data) ->
      $scope.more_recipe = data.recipes
      console.log(data)
    ).error((data) ->
    )
)
