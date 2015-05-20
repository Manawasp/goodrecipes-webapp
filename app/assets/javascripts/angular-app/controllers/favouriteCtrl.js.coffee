angular.module('app').controller("favoriteCtrl", ($mdDialog, $scope, $location,$routeParams, $cookieStore, authorization, api, recipeService)->
    console.log 'favoriteCtrl running'
    $scope.template = 'views/favorite.html'
    $scope.data = {
      page:       1,
      pagination: [],
      results:    0,
      offset:     0,
      limit:      20,
      tableView:  true,
    }

    $scope.redir_recipe = (id) ->
      $location.url('/recipes/show/' + id)

    $scope.updatePage = (value)->
      if value > 0
        $scope.data.page    = value
        $scope.data.offset  = (value - 1) * $scope.data.limit
        searchFavorites(()->
          $scope.data.pagination.length = 0
          n = $scope.data.page - 4
          while (n < ($scope.data.page + 4))
            if (n > 0 && ((n-1)*$scope.data.limit) < $scope.data.results)
              $scope.data.pagination.push n
            n += 1
        )

    searchFavorites = (paginationCallback) ->
      recipeService.searchFavorite($scope.data.offset, $scope.data.limit
      ).success((data) ->
        $scope.more_recipe = data.recipes
        #paginarion
        $scope.data.results = data.max
        paginationCallback()
      ).error((data) ->
      )

    $scope.updatePage(1)
)
