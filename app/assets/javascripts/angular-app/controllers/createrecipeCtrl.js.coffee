angular.module('app').controller("createrecipeCtrl", ($scope, $location, $cookieStore, authorization, api)->
    console.log 'createrecipesCtrl running'
    $scope.template = 'views/createrecipe.html'
    $scope.error = ''
    $scope.recipe = {"image": "","title":"Fabulous chocolat pie","description":"Le paradis du chocolat","people": 6,"preparation": {"h": 0, "m": 0}, "total": {"h": 0, "m": 0}, ingredients: [{"icon": "chocolat"},{"icon": "chocolat"},{"icon": "chocolat"},{"icon": "chocolat"},{"icon": "chocolat"},{"icon": "chocolat"},{"icon": "chocolat"},{"icon": "chocolat"},{"icon": "chocolat"}], steps: [], ingredients_describe: [{title: "", description: ""}]}
    $scope.ingredients = [{"icon": "chocolat"},{"icon": "chocolat"},{"icon": "chocolat"},{"icon": "chocolat"},{"icon": "chocolat"},{"icon": "chocolat"},{"icon": "chocolat"},{"icon": "chocolat"},{"icon": "chocolat"}]
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
                      {'c': false, 'name': 'milk'},     {'c': true, 'name': 'halal'},
                      {'c': true, 'name': 'kascher'}]


    $scope.add_step = () ->
      $scope.recipe.steps.push ""

    $scope.remove_step = (id) ->
      $scope.recipe.steps.splice(id, 1)

    $scope.add_ingredients_describe = () ->
      obj = {title: "", description: ""}
      $scope.recipe.ingredients_describe.push obj

    $scope.remove_ingredients_describe = (id) ->
      $scope.recipe.ingredients_describe.splice(id, 1)

    $scope.validate = () ->

      $scope.recipe.labels = []
      for element in $scope.labels
        if element.c == true
          $scope.recipe.labels.push element.name

      $scope.recipe.denied = []
      for element in $scope.denied
        if element.c == true
          $scope.recipe.denied.push element.name

      console.log($scope.recipe)
)