angular.module('app').controller("createingredientCtrl", ($scope, $location, $cookieStore, authorization, api)->
    console.log 'createingredientCtrl running'
    $scope.template = 'views/createingredient.html'
    $scope.error = ''
    $scope.recipe = {}
)