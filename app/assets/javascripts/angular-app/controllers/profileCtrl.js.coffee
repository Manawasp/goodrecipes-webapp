angular.module('app').controller("profileCtrl", ($scope, $routeParams, $location, $cookieStore, userService, api)->

    $scope.followers = []
    $scope.template = 'views/profile.html'
    $scope.data = {
      selectedIndex : 99,
      send : false
      error : ''
    }
    user_original = {}

    userService.get($routeParams.userid
    ).success((data) ->
      console.log data
      # Gestion avatar
      if data.avatar == undefined
        data.avatar = "/images/avatar.jpg"
      else if data.avatar == ""
        data.avatar = "/images/avatar.png"
      # save user data & Clone
      $scope.user = Object.create(data)
      user_original = Object.create(data)
      # redirection vers l'edition ou le profile de l'user 
      if api.getUser().id == $scope.user.id
        $scope.template = 'views/editprofile.html'
      else
        $scope.template = 'views/profile.html'
    ).error((data) ->
    )

    userService.getFollower($routeParams.userid
    ).success((data) ->
      # Fake data
      data = [{"id": "poejfe09ufe9fjeijowdw", "pseudo": "Clovis Kyndt", "avatar":"/images/avatar.jpg"},{"id": "poejfe09ufe9fjeijo", "pseudo": "Manawasp", "avatar":"/images/avatar.jpg"}]
      $scope.followers = data
    ).error((data) ->
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