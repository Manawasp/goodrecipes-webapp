angular.module('app').controller("createmomentCtrl", ($scope, $location, $cookieStore, authorization, api)->
    console.log 'createmomentCtrl running'
    $scope.template = 'views/createmoment.html'
    # data.selectedIndex = '2'
    $scope.error = ''
    $scope.moment = {}

    $scope.data = {
      selectedIndex : 0
    }
)