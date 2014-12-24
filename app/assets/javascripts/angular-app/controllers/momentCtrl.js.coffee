angular.module('app').controller("momentCtrl", ($scope, $location, $cookieStore, userService, api)->
    console.log 'momentCtrl running'
    # $scope.user = api.getUser()
    $scope.connected = "evidemment"
    $scope.template = 'views/wall.html'

    $scope.data = {
      selectedIndex : 0
    }
)