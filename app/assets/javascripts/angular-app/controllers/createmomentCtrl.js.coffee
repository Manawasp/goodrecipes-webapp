angular.module('app').controller("createmomentCtrl", ($scope, $location, $cookieStore, authorization, api)->
    console.log 'createmomentCtrl running'
    $scope.template = 'views/createmoment.html'
    $scope.error = ''
    $scope.moment = {}
)