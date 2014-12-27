angular.module('app').controller("profileCtrl", ($scope, $routeParams, $location, $cookieStore, userService, api)->

    $scope.followers = []
    $scope.template = 'views/profile.html'
    $scope.data = {
      selectedIndex : 99,
      send : false,
      error : '',
      isfriend : false
    }
    user_original = {}

    userService.get($routeParams.userid
    ).success((data) ->
      # Gestion avatar
      if data.avatar == undefined
        data.avatar = "/images/avatar.jpg"
      else if data.avatar == ""
        data.avatar = "/images/avatar.png"
      # save user data & Clone
      $scope.user = Object.create(data)
      user_original = Object.create(data)
      # redirection vers l'edition ou le profile de l'user 
      id = api.getUser().id
      if id == $scope.user.id
        $scope.template = 'views/editprofile.html'
      else
        $scope.template = 'views/profile.html'
        userService.getFollower(id
        ).success((data) ->
          for u of data
            if u.id == $routeParams.userid
              isfriend = true
        )
    ).error((data) ->
    )

    userService.getFollower($routeParams.userid
    ).success((data) ->
      # Fake data
      console.log data
      data = [{"id": "poejfe09ufe9fjeijowdw", "pseudo": "Clovis Kyndt", "avatar":"/images/avatar.jpg"},{"id": "poejfe09ufe9fjeijo", "pseudo": "Manawasp", "avatar":"/images/avatar.jpg"}]
      $scope.followers = data
    ).error((data) ->
    )

    $scope.friend = () ->
      $scope.data.send = true
      if $scope.data.isfriend == false
        userService.follow($routeParams.userid
        ).success((data)->
          $scope.data.isfriend = true
          $scope.data.send = true
        ).error((data) ->
          if data.error = "already in your followers"
            $scope.data.isfriend = true
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