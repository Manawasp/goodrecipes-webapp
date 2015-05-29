angular.module('app').controller("loginCtrl", ($scope, $location, $cookieStore, $routeParams, authorization, api, userService, notifService)->
    console.log 'loginCtrl running'
    $scope.template = 'views/login.html'
    $scope.error = ""
    this.email = ""
    $scope.haveError = ->
      return true if $scope.error != ''
      return false

    $scope.locate = (location) ->
      $location.url(location);

    $scope.sendResetEmail = () ->
      re = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
      console.log(this.email)
      if (this.email != undefined && this.email.length > 5 && re.test(this.email))
        userService.sendMailResetPassword(this.email
        ).success((data) ->
          notifService.success("check your mail box to reset your password")
        ).error((data) ->
          $scope.error = data.error
        )
      else
        $scope.error = 'Email empty or invalid'

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

    if $routeParams.action != undefined
      if $routeParams.action == 'resetpassword' && $routeParams.token != undefined
        $location.url('resetpassword?action=resetpassword&token=' + $routeParams.token);
    # $scope.connected = authorization.isLogged()
)
