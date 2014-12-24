angular.module('app').controller("createrecipeCtrl", ($scope, $location, $cookieStore, authorization, api)->
    console.log 'createrecipesCtrl running'
    $scope.template = 'views/createrecipe.html'
    $scope.error = ''
    $scope.recipe = {}
)