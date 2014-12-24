angular.module('app').controller("profileCtrl", ($scope, $routeParams, $location, $cookieStore, userService, api)->
    userService.get($routeParams.userid
    ).success((data) ->
      console.log data
      $scope.user = data
      if api.getUser().id == $scope.user.id
        $scope.template = 'views/editprofile.html'
      else
        $scope.template = 'views/profile.html'
    ).error((data) ->
    )

    $scope.template = 'views/profile.html'
    $scope.error = ''
)