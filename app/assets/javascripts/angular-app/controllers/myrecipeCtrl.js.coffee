angular.module('app').controller("myrecipeCtrl", ($mdDialog, $scope, $location,$routeParams, $cookieStore, authorization, api, recipeService)->
    console.log 'myrecipeCtrl running'
    $scope.template = 'views/myrecipe.html'
    $scope.offset = 0
    $scope.limit = 20
    $scope.mark = [0.5, 1.5, 2.5, 3.5, 4.5]

    $scope.redir_recipe = (id) ->
      $location.url('/recipes/show/' + id)

    recipeService.search("",[],[],[],[], $scope.offset, $scope.limit, $routeParams.userid
    ).success((data) ->
      $scope.more_recipe = data.recipes
      console.log(data)
    ).error((data) ->
    )
)
