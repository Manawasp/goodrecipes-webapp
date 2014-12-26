angular.module('app').controller("profileCtrl", ($scope, $routeParams, $location, $cookieStore, userService, api)->
    userService.get($routeParams.userid
    ).success((data) ->
      console.log data
      $scope.user = data
      # Gestion avatar
      if $scope.user.avatar == undefined
        $scope.user.avatar = "/images/avatar.jpg"
      else if $scope.user.avatar == ""
        $scope.user.avatar = "/images/avatar.png"
      # redirection vers l'edition ou le profile de l'user 
      if api.getUser().id == $scope.user.id
        $scope.template = 'views/editprofile.html'
      else
        $scope.template = 'views/profile.html'
    ).error((data) ->
    )

    $scope.template = 'views/profile.html'
    $scope.error = ''
    $scope.data = {
      selectedIndex : 99
    }
)