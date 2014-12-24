angular.module('app').controller("loginCtrl", ($scope, $location, $cookieStore, authorization, api)->
    console.log 'loginCtrl running'
    $scope.template = 'views/signup.html'
    $scope.error = ""
    $scope.haveError = ->
      return true if $scope.error != ''
      return false

    $scope.send = ->
      authorization.login(this.email, this.password 
      ).success((data) ->
        $scope.error = ""
        $cookieStore.put('token', data.token);
        $cookieStore.put('id', data.user.id);
        console.log "USER ID :: " + data.user.id
        api.init(data.token);
        api.putUser(data.user)
        $location.path('/');
      ).error((data) ->
        if data.error == "match email/password failed"
          $scope.error = "Match email / password failed"
        else if data.error == "bad request"
          $scope.error = "You need to complete all input"
        else if data.error == "resource not found"
          $scope.error = "This account doesn't exist"
      )

    # $scope.connected = authorization.isLogged()
)