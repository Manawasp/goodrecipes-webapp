angular.module('app').controller("profileCtrl", ($scope, $routeParams, $location, $cookieStore, userService, api)->

    $scope.followers = []
    $scope.template = 'views/profile.html'
    $scope.data = {
      send : false,
      error : '',
      isfriend : false
    }
    user_original = {}
    $scope.obj = {}
    $scope.upload = {avatarPict: undefined}

    userService.get($routeParams.userid
    ).success((data) ->
      # Gestion avatar
      if data.avatar == undefined
        data.avatar = "/images/avatar.jpg"
      else if data.avatar == ""
        data.avatar = "/images/avatar.png"
      # save user data & Clone
      $scope.upload.user = Object.create(data)
      user_original = Object.create(data)
      # redirection vers l'edition ou le profile de l'user
      id = api.getUser().id
      if id == $scope.upload.user.id
        $scope.template = 'views/editprofile.html'
      else
        $scope.template = 'views/profile.html'
    ).error((data) ->
    )

    $scope.show_picture = () ->
      if $scope.upload.avatarPict != undefined
        return "data:" + $scope.upload.avatarPict.filetype + ";base64," + $scope.upload.avatarPict.base64
      else if $scope.upload.user.avatar != undefined && $scope.upload.user.avatar.length > 0
        return $scope.upload.user.avatar
      else
        console.log("No choose")

    updateFollowed = () ->
      userService.getFollowed($routeParams.userid
      ).success((data) ->
        id = api.getUser().id
        for v, u of data
          if u.id == id
            $scope.data.isfriend = true
        $scope.followeds = data
      ).error((data) ->
      )

    updateFollowed()

    userService.getFollower($routeParams.userid
    ).success((data) ->
      $scope.followers = data
    ).error((data) ->
    )

    $scope.friend = () ->
      $scope.data.send = true
      if $scope.data.isfriend == false
        userService.follow($routeParams.userid
        ).success((data)->
          updateFollowed()
          $scope.data.isfriend = true
          $scope.data.send = false
        ).error((data) ->
          if data.error = "already in your followers"
            $scope.data.isfriend = true
          $scope.data.send = false
        )
      else
        userService.removeFollower($routeParams.userid
        ).success((data)->
          updateFollowed()
          $scope.data.isfriend = false
          $scope.data.send = false
        ).error((data) ->
          $scope.data.send = false
        )


    $scope.update_user = () ->
      $scope.data.send = true
      $scope.data.error = ''
      userService.update(user_original, $scope.user
      ).success((data) ->
        if data.user.avatar == undefined
          data.user.avatar = "/images/avatar.jpg"
        else if data.user.avatar == ""
          data.user.avatar = "/images/avatar.png"
        $scope.user = Object.create(data.user)
        user_original = Object.create(data.user)
        $scope.data.send = false
      ).error((data) ->
        if data.error != 'empty request'
          $scope.data.error = data.error
        $scope.data.send = false
      )
)
