angular.module('app').controller("myrecipeCtrl", ($mdDialog, $scope, $location,$routeParams, $cookieStore, authorization, api, recipeService)->
    console.log 'myrecipeCtrl running'
    $scope.template = 'views/myrecipe.html'
    $scope.data = {
      page:       1,
      pagination: [],
      results:    0,
      offset:     0,
      limit:      12,
      tableView:  true,
    }
    $scope.mark = [0.5, 1.5, 2.5, 3.5, 4.5]

    $scope.redir_recipe = (id) ->
      $location.url('/recipes/show/' + id)

    $scope.updatePage = (value)->
      if value > 0
        $scope.data.page    = value
        $scope.data.offset  = (value - 1) * $scope.data.limit
        searchUserRecipes(()->
          $scope.data.pagination.length = 0
          n = $scope.data.page - 4
          while (n < ($scope.data.page + 4))
            if (n > 0 && ((n-1)*$scope.data.limit) < $scope.data.results)
              $scope.data.pagination.push n
            n += 1
        )

    searchUserRecipes = (paginationCallback) ->
      recipeService.search("",[],[],[],[], $scope.data.offset, $scope.data.limit, $routeParams.userid
      ).success((data) ->
        $scope.more_recipe = data.recipes
        #paginarion
        $scope.data.results = data.max
        paginationCallback()
      ).error((data) ->
      )

    $scope.updatePage(1)
)
