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

    $scope.mark = [0.5, 1.5, 2.5, 3.5, 4.5]
    $scope.more_recipe = [{'id': '1', 'icon': '', 'title': 'Avocado Dessert', 'comment_length': 12,'total': {'h': 1, 'm': 0}, 'mark': 4.7},
                          {'id': '2', 'icon': '', 'title': 'Apple pie', 'comment_length': 12,'total': {'h': 0, 'm': 45}, 'mark': 4.2},
                          {'id': '3', 'icon': '', 'title': 'Moules cuites au wok', 'comment_length': 12,'total': {'h': 1, 'm': 45}, 'mark': 4.2},
                          {'id': '4', 'icon': '', 'title': 'Pizza viande de boeuf hachee', 'comment_length': 12,'total': {'h': 0, 'm': 45}, 'mark': 4.2}]



    $scope.data = {
      offset : 0
      limit : 40 
    }

    $scope.search = () ->
      searchRecipe()

    searchRecipe = () ->
      recipeService.search($scope.recipe.description,
                                $scope.recipe.labels,
                                $scope.recipe.savours,
                                $scope.recipe.blacklist,
                                $scope.data.offset,
                                $scope.data.limit
      ).success((data) ->
        console.log "success data in search ingredient"
        console.log data
        $scope.data.recipes = data.recipes
      ).error((data) ->
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
    searchRecipe()
)