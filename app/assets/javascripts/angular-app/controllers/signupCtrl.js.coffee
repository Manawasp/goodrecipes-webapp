angular.module('app').controller("signupCtrl", ($scope, $location, $cookieStore, userService, api)->
    console.log 'signupCtrl running'
    $scope.template = 'views/signup.html'
    $scope.error = ""
    $scope.haveError = ->
      return true if $scope.error != ''
      return false

    $scope.locate = (location) ->
      $location.url(location);

    $scope.send = ->
      userService.create(this.pseudo, this.email, this.password
      ).success((data) ->
        $scope.error = ""
        $cookieStore.put('token', data.token);
        $cookieStore.put('id', data.user.id);
        api.init(data.token);
        api.putUser(data.user)
        $location.path('/');
      ).error((data) ->
        $scope.error = data.error
      )

    # $scope.connected = authorization.isLogged()
)
