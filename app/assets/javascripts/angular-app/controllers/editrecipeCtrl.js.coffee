angular.module('app').controller("editrecipeCtrl", (homepageService, $routeParams, $mdDialog, $scope, $location, $cookieStore, authorization, api, recipeService)->
    console.log 'editrecipesCtrl running'
    $scope.template = 'views/showrecipe.html'
    $scope.error = ''
    $scope.form_ingredient = {description: ""}
    $scope.ingredientPicture = undefined

		$scope.recipe = {"image": "","title":"","description":"","people": 1,"preparation": {"h": 0, "m": 0}, "total": {"h": 0, "m": 0}, "time": "", ingredients: [], steps: [], "ingredients_describe": [{title: "", description: ""}]}
    $scope.ingredients = []
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

    recipeService.get($routeParams.id
    ).success((data) ->
      console.log(data)
      $scope.recipe = data.recipe
      $scope.author = data.user
      $scope.ingredients = data.ingredients
      console.log($scope.recipe)
      console.log($scope.ingredients)
    ).error((data) ->
      $location.url('/')
    )

    $scope.data = {
      offset : 0
      limit : 8
    }

    $scope.show_picture = () ->
      if $scope.ingredientPicture != undefined
        return "data:" + $scope.ingredientPicture.filetype + ";base64," + $scope.ingredientPicture.base64
      else if $scope.recipe.icon != undefined && $scope.recipe.icon.length > 0
        return $scope.recipe.icon
      else
        console.log($scope.ingredientPicture)
    $scope.image_path = (img) ->
      if img == ''
        ''
      else
        img

    $scope.add_step = () ->
      $scope.recipe.steps.push ""

    $scope.remove_step = (id) ->
      if $scope.recipe.steps.length > 1
        $scope.recipe.steps.splice(id, 1)

    $scope.add_ingredients_describe = () ->
      obj = {title: "", description: ""}
      $scope.recipe.ingredients_describe.push obj

    $scope.remove_ingredients_describe = (id) ->
      $scope.recipe.ingredients_describe.splice(id, 1)

    $scope.add_ingredients_in_box = (id) ->
      if $scope.ingredients.length > id
        for ig in $scope.recipe.ingredients
          if $scope.ingredients[id].id && ig.id && $scope.ingredients[id].id == ig.id
            # exist deja
            return
        obj = JSON.parse(JSON.stringify($scope.ingredients[id]));
        $scope.recipe.ingredients.push obj

    $scope.rm_ingredients_in_box = (id) ->
      if $scope.recipe.ingredients.length > id
        $scope.recipe.ingredients.splice(id, 1)

    $scope.validate = () ->
      data = {"ingredients": [],"time_prep": {"h": 0, "m": 0}, "time_total": {"h": 0, "m": 0}}
      if ($scope.recipe.preparation.h && $scope.recipe.preparation.h > 0)
        data.time_prep.h = parseInt($scope.recipe.preparation.h)
      if ($scope.recipe.preparation.m && $scope.recipe.preparation.m > 0)
        data.time_prep.m = parseInt($scope.recipe.preparation.m)
      if ($scope.recipe.total.h && $scope.recipe.total.h > 0)
        data.time_total.h = parseInt($scope.recipe.total.h)
      if ($scope.recipe.total.m && $scope.recipe.total.m > 0)
        data.time_total.m = parseInt($scope.recipe.total.m)

      data.title        = $scope.recipe.title
      data.description  = $scope.recipe.description
      for element in $scope.recipe.ingredients
        if element.id
          data.ingredients.push element.id

      data.people       = $scope.recipe.people || 0
      data.steps        = $scope.recipe.steps  || []

      if $scope.recipe.image
        data.image = $scope.recipe.image

      if $scope.recipe.ingredients_describe && $scope.recipe.ingredients_describe[0]
        data.parts      = $scope.recipe.ingredients_describe[0]

      data.labels = []
      for element in $scope.labels
        if element.c == true
          data.labels.push element.name

      data.blacklist = []
      for element in $scope.denied
        if element.c == true
          data.blacklist.push element.name

      console.log(data)

      recipeService.create(data
      ).success((data) ->
        console.log "SUCCESS : CREATE RECIPE"
        console.log data
        $location.url('/recipes/show/' + data.recipe.id)
      ).error((data) ->
        console.log data
        $scope.error = data.error
      )

    $scope.searchIngredient = () ->
      ingredientService.search($scope.form_ingredient.description,
                                [],
                                [],
                                [],
                                $scope.data.offset,
                                $scope.data.limit
      ).success((data) ->
        # console.log "success data in search ingredient"
        # console.log data
        $scope.ingredients = data.ingredients
      ).error((data) ->
        # console.log "error data in search ingredient"
        # console.log data
      )

    $scope.searchIngredient()
)
