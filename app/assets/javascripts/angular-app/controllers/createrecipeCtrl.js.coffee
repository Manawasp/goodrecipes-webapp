angular.module('app').controller("createrecipeCtrl", ($scope, $location, $cookieStore, authorization, api)->
    console.log 'createrecipesCtrl running'
    $scope.template = 'views/createrecipe.html'
    $scope.error = ''
    $scope.recipe = {"image": "","title":"Fabulous chocolat pie","description":"Le paradis du chocolat","people": 6,"preparation": {"h": 0, "m": 0}, "total": {"h": 0, "m": 0}, ingredients: [{"icon": "chocolat"},{"icon": "chocolat"},{"icon": "chocolat"},{"icon": "chocolat"},{"icon": "chocolat"},{"icon": "chocolat"},{"icon": "chocolat"},{"icon": "chocolat"},{"icon": "chocolat"}], steps: [], ingredients_describe: [{title: "", description: ""}]}
    $scope.ingredients = [{"icon": "chocolat"},{"icon": "chocolat"},{"icon": "chocolat"},{"icon": "chocolat"},{"icon": "chocolat"},{"icon": "chocolat"},{"icon": "chocolat"},{"icon": "chocolat"},{"icon": "chocolat"}]


    $scope.add_step = () ->
      $scope.recipe.steps.push ""

    $scope.remove_step = (id) ->
      $scope.recipe.steps.splice(id, 1)

    $scope.add_ingredients_describe = () ->
      obj = {title: "", description: ""}
      $scope.recipe.ingredients_describe.push obj

    $scope.remove_ingredients_describe = (id) ->
      $scope.recipe.ingredients_describe.splice(id, 1)
)