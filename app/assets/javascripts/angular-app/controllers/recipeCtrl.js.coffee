angular.module('app').controller("recipeCtrl", ($mdDialog, $routeParams, $scope, $location, $cookieStore, authorization, api, ingredientService, recipeService)->
    console.log 'recipeCtrl running'
    $scope.template = 'views/recipe.html'
    $scope.error = ''
    $scope.recipe = {description: "", labels: [], blacklist: []}
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
                      {'c': false, 'name': 'milk'},     {'c': false, 'name': 'halal'},
                      {'c': false, 'name': 'kascher'}]
    $scope.ingredients = []
    $scope.search_ingredients = []
    $scope.show_search_advanced = false
    $scope.show_search_advanced_label = false
    $scope.form_ingredient = {description: ""}

    $scope.mark = [0.5, 1.5, 2.5, 3.5, 4.5]
    $scope.more_recipe = []

    $scope.data = {
      offset : 0
      limit : 30 
    }

    $scope.redir_recipe = (id) ->
      $location.url('/recipes/show/' + id)

    $scope.get_url_upload = () ->
      'http://localhost:8080/pictures/'

    $scope.image_path = (img) ->
      if img == ''
        ''
      else
        $scope.get_url_upload() + img

    $scope.search = () ->
      searchRecipe()

    searchRecipe = () ->
      for element in $scope.labels
        if element.c
          $scope.recipe.labels.push element.name

      for element in $scope.denied
        if element.c
          $scope.recipe.blacklist.push element.name

      console.log($scope.recipe.blacklist)
      console.log($scope.recipe.labels)
      console.log($scope.recipe.search_ingredients)
      recipeService.search($scope.recipe.description,
                                $scope.recipe.labels,
                                $scope.recipe.savours,
                                $scope.recipe.blacklist,
                                $scope.recipe.search_ingredients,
                                $scope.data.offset,
                                $scope.data.limit
      ).success((data) ->
        console.log "success data in search ingredient"
        console.log data
        $scope.more_recipe = data.recipes
        $scope.recipe.labels = []
        $scope.recipe.blacklist = []
        $scope.recipe.description = []
      ).error((data) ->
        $scope.recipe.labels = []
        $scope.recipe.blacklist = []
        $scope.recipe.description = []
        # console.log "error data in search ingredient"
        # console.log data
      )

        # $scope.alert = "You cancelled the dialog."
    if $routeParams.title
      console.log("search title")
    else if $routeParams.label
      console.log("search label : " + $routeParams.label)
    else
      console.log("search base no parametre")

    if $routeParams.label && $routeParams.label != ""
      $scope.recipe.labels = [$routeParams.label]
    if $routeParams.title && $routeParams.title != ""
      $scope.recipe.description = $routeParams.title

    searchRecipe()

    $scope.search_launch = () ->
      searchRecipe();

    $scope.searchIngredient = () ->
      ingredientService.search($scope.form_ingredient.description,
                                [],
                                [],
                                [],
                                0,
                                10
      ).success((data) ->
        # console.log "success data in search ingredient"
        # console.log data
        $scope.ingredients = data.ingredients
      ).error((data) ->
        # console.log "error data in search ingredient"
        # console.log data
      )
    $scope.search_with_ingredient = (id) ->
      if $scope.ingredients.length > id
        $scope.recipe.search_ingredients = [$scope.ingredients[id].id]
      searchRecipe()
)