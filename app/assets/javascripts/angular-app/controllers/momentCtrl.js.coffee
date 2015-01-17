angular.module('app').controller("momentCtrl", (momentService, $routeParams, $scope, $location, $cookieStore, userService, api)->
    console.log 'momentCtrl running'
    $scope.template = 'views/wall.html'
    $scope.create_moment = {'description':'', 'recipe_id':''}

    $scope.pseudo = "Manawasp"

    $scope.data = {
      offset: 0,
      limit: 10,
    }

    $scope.mark = [0.5, 1.5, 2.5, 3.5, 4.5]

    $scope.create_moment = {'description': "", 'recipe_id': ''}

    moment1   = {"id": "iwojdoiw6fwt67fw7", "description": "Hello world !", "likes": 1023,"comment_length": 744, "create_at": "okdowkwpodk"}
    user1     = {"id": "chocolat", "avatar": "/images/baravatar2.jpg","pseudo": "Superadmin"}
    recipe1   = {'id': '1','week_length': 10 ,'ingredients': ['', '', '', '', '', '', '', '', '', '', ''],'people': 6,'icon': '','title': 'Gateau a la mangue','comment_length': 12,'preparation': {'h': 0, 'm': 45},'total': {'h': 1, 'm': 0},'mark': 2.7, 'description': 'Try a new twist on a homemade meatball comes quickly dor a delicious dinner !Try a new twist on a homemade meatball comes quickly dor a deliciw !'}
            
    moment2   = {"id": "iwojdoiw6fwt67fw7", "description": "2 moments", "likes": 13,"comment_length": 4, "create_at": "okdowkwpodk","updated_at": "okok"}
    user2     = {"id": "chocolat", "avatar": "/images/bakemono.png", "pseudo": "Superadmin"}
    recipe2   = {'id': '1','week_length': 10 ,'ingredients': ['', '', '', '', '', '', '', '', '', '', ''],'people': 6,'icon': '','title': 'Gateau a la mangue','comment_length': 12,'preparation': {'h': 0, 'm': 45},'total': {'h': 1, 'm': 0},'mark': 2.7, 'description': 'Try a new twist on a homemade meatball comes quickly dor a delicious dinner !Try a new twist on a homemade meatball comes quickly dor a deliciw !'}

    $scope.moments = [{"moment": moment1, "user": user1, "recipe": recipe1},
                      {"moment": moment2, "user": user2, "recipe": recipe2}]

    if $routeParams.action == "new"
      $scope.show_create_moment = true
    else
      $scope.show_create_moment = false

    $scope.get_url_upload = () ->
      'http://localhost:8080/pictures/'

    $scope.image_path = (img) ->
      if img == ''
        ''
      else
        $scope.get_url_upload() + img

    $scope.redir_recipe = (id) ->
      $location.url('/recipes/show/' + id)

    $scope.push_new_moment = () ->
      momentService.create({'description': $scope.create_moment.description, 'recipe': $scope.create_moment.recipe_id}
      ).success((data) ->
        console.log(data)
        $scope.result_new_moment = data.moments
      ).error((data) ->
        console.log(data)
      )

    $scope.search_moment = () ->
      momentService.search($routeParams.userid, $scope.data.offset, $scope.data.limit
      ).success((data) ->
        console.log(data)
        $scope.moments = data.moments
      ).error((data) ->
        console.log(data)
      )

    $scope.search_moment()
)