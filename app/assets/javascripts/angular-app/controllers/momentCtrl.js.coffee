angular.module('app').controller("momentCtrl", ($scope, $location, $cookieStore, userService, api)->
    console.log 'momentCtrl running'
    $scope.template = 'views/wall.html'

    $scope.pseudo = "Manawasp"

    $scope.show_create_moment = false

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
)