angular.module('app').controller("homepageCtrl", (homepageService, $mdDialog, $routeParams, $scope, $location, $cookieStore, authorization, api, ingredientService, recipeService)->
    console.log 'homepageCtrl running'
    $scope.template = 'views/homepage.html'

    $scope.mark = [0.5, 1.5, 2.5, 3.5, 4.5]

    $scope.week_recipe = {'id': '1','week_length': 10 ,'ingredients': ['', '', '', '', '', '', '', '', '', '', ''], 'people': 6,'icon': '', 'title': 'Gateau a la mangue', 'comment_length': 12,'preparation': {'h': 0, 'm': 45},'total': {'h': 1, 'm': 0}, 'mark': 2.7, 'description': 'Try a new twist on a homemade meatball comes quickly dor a delicious dinner !Try a new twist on a homemade meatball comes quickly dor a deliciw !'}

    $scope.month_recipe = [{'id': '1', 'icon': '', 'title': 'Avocado Dessert', 'comment_length': 12,'total': {'h': 1, 'm': 0}, 'mark': 4.7},
                          {'id': '2', 'icon': '', 'title': 'Apple pie', 'comment_length': 12,'total': {'h': 0, 'm': 45}, 'mark': 4.2},
                          {'id': '3', 'icon': '', 'title': 'Moules cuites au wok', 'comment_length': 12,'total': {'h': 1, 'm': 45}, 'mark': 4.2},
                          {'id': '4', 'icon': '', 'title': 'Pizza viande de boeuf hachee', 'comment_length': 12,'total': {'h': 0, 'm': 45}, 'mark': 4.2}]
    $scope.latest_recipe = [{'id': '1', 'icon': '', 'title': 'Avocado Dessert', 'comment_length': 12,'total': {'h': 1, 'm': 0}, 'mark': 4.7},
                          {'id': '2', 'icon': '', 'title': 'Apple pie', 'comment_length': 12,'total': {'h': 0, 'm': 45}, 'mark': 4.2},
                          {'id': '3', 'icon': '', 'title': 'Moules cuites au wok', 'comment_length': 12,'total': {'h': 1, 'm': 45}, 'mark': 4.2},
                          {'id': '4', 'icon': '', 'title': 'Pizza viande de boeuf hachee', 'comment_length': 12,'total': {'h': 0, 'm': 45}, 'mark': 4.2}]
    $scope.random_recipe = [{'id': '1', 'icon': '', 'title': 'Avocado Dessert', 'comment_length': 12,'total': {'h': 1, 'm': 0}, 'mark': 4.7},
                          {'id': '2', 'icon': '', 'title': 'Apple pie', 'comment_length': 12,'total': {'h': 0, 'm': 45}, 'mark': 4.2},
                          {'id': '3', 'icon': '', 'title': 'Moules cuites au wok', 'comment_length': 12,'total': {'h': 1, 'm': 45}, 'mark': 4.2},
                          {'id': '4', 'icon': '', 'title': 'Pizza viande de boeuf hachee', 'comment_length': 12,'total': {'h': 0, 'm': 45}, 'mark': 4.2}]


    $scope.get_url_upload = () ->
      'http://localhost:8080/pictures/'

    $scope.image_path = (img) ->
      if img == ''
        ''
      else
        $scope.get_url_upload() + img

    $scope.redir_recipe = (id) ->
      $location.url('/recipes/show/' + id)

    homepageService.month(
    ).success((data) ->
      console.log(data.recipes)
      $scope.month_recipe = data.recipes
    ).error((data) ->
    )

    homepageService.week(
    ).success((data) ->
      console.log(data.recipes)
      $scope.week_recipe = data.recipes[0]
    ).error((data) ->
    )

    homepageService.latest(
    ).success((data) ->
      $scope.latest_recipe = data.recipes
    ).error((data) ->
    )

    homepageService.random(
    ).success((data) ->
      $scope.random_recipe = data.recipes
    ).error((data) ->
    )
)