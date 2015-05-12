angular.module('app').controller("showrecipeCtrl", (homepageService, $routeParams, $mdDialog, $scope, $location, $cookieStore, authorization, api, recipeService)->
    console.log 'showrecipesCtrl running'

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

    $scope.template = 'views/showrecipe.html'
    $scope.error = ''
#     $scope.author = {"name": "Manawasp", "id": "unknow"}
#     $scope.recipe = {"mark_length": 12, "comment_length": 23,"mark": 3.6,"image": "","title":"Fabulous chocolat pie","description":"Le paradis du chocolat","people": 6,"preparation": {"h": 0, "m": 45}, "total": {"h": 1, "m": 0}, ingredients: [{"icon": "chocolat"},{"icon": "chocolat"},{"icon": "chocolat"},{"icon": "chocolat"},{"icon": "chocolat"},{"icon": "chocolat"},{"icon": "chocolat"},{"icon": "chocolat"},{"icon": "chocolat"}], steps: ["In large bowl, mix meatball ingredients. With wet hands, shape mixture into 18 bails.","Heat 12-inch nonstick skillet over medium-high heat; add oil. Add meatball, and cooks 5 to 6 minutes, turning frequently to brown evenly.
# Reduce heat to medium-low, add chicken broth and cooking sauce. Simmer 15 to 20 minutes or until thoroughly cooked and no longer pink in center.", "Heat 12-inch nonstick skillet over medium-high heat; add oil. Add meatball, and cooks 5 to 6 minutes, turning frequently to brown evenly.
# Reduce heat to medium-low, add chicken broth and cooking sauce. Simmer 15 to 20 minutes or until thoroughly cooked and no longer pink in center."], ingredients_describe: [{title: "Meatballs", description: "1 lb lean (at least 80%) ground beef\n1/2 cup Progresso plain panko bread crumbs\n1 medium onion, finely chopped (1/2 cup)\n1/2 teaspoon died oregano leaves\n1/2 teaspoon salt\n3 gloves garlic, finely chopped\n1 egg, beaten"}]}
#     $scope.ingredients = [{"icon": "chocolat"},{"icon": "chocolat"},{"icon": "chocolat"},{"icon": "chocolat"},{"icon": "chocolat"},{"icon": "chocolat"},{"icon": "chocolat"},{"icon": "chocolat"},{"icon": "chocolat"}]
    $scope.mark = [0.5, 1.5, 2.5, 3.5, 4.5]
    # $scope.more_recipe = [{'id': '1', 'icon': '', 'title': 'Avocado Dessert', 'comment_length': 12,'total': {'h': 1, 'm': 0}, 'mark': 4.7},
    #                       {'id': '2', 'icon': '', 'title': 'Apple pie', 'comment_length': 12,'total': {'h': 0, 'm': 45}, 'mark': 4.2},
    #                       {'id': '3', 'icon': '', 'title': 'Moules cuites au wok', 'comment_length': 12,'total': {'h': 1, 'm': 45}, 'mark': 4.2},
    #                       {'id': '4', 'icon': '', 'title': 'Pizza viande de boeuf hachee', 'comment_length': 12,'total': {'h': 0, 'm': 45}, 'mark': 4.2}]



    homepageService.random(
    ).success((data) ->
      $scope.more_recipe = data.recipes
    ).error((data) ->
    )

    $scope.get_url_upload = () ->
      'http://localhost:8080/pictures/'

    $scope.image_path = (img) ->
      if img == ''
        ''
      else
        img

    $scope.markRecipe = (data) ->
      $mdDialog.show(
        controller: 'markrecipeCtrl'
        templateUrl: "/views/markrecipe.html"
      ).then (() ->
        # $scope.alert = "You said the information was \"" + answer + "\"."
      ), ->
        # $scope.alert = "You cancelled the dialog."

)
