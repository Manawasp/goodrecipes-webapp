angular.module('app').controller("createingredientCtrl", ($scope, $location, $cookieStore, authorization, api)->
    console.log 'createingredientCtrl running'
    $scope.template = 'views/createingredient.html'
    # $scope.data.selectedIndex = 'tab2'
    $scope.error = ''
    $scope.recipe = {}

    $scope.data = {
      selectedIndex : 2
    }
)