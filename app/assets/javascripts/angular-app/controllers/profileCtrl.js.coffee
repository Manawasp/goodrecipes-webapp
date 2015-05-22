angular.module('app').controller("profileCtrl", ($scope, $routeParams, $location, $cookieStore, userService, api, notifService)->

    $scope.template = 'views/editprofile.html'
    $scope.data = {
      send : false,
      error : '',
      isfriend : false
    }
    user_original = {}
    $scope.editUser = {}
    $scope.obj = {}
    $scope.upload = {avatarPict: undefined}

    upload_picture = (id) ->
      $scope.error = ""
      result = $scope.upload.avatarPict.filetype.split(/\//)
      if result[0] == "image"
        console.log("C'est une image !")
        if result[1] != undefined && result[1] == "jpeg"
          result[1] = "jpg"
        if result[1] != undefined && (result[1] == "jpg" || result[1] == "png")
          console.log("le type de l'image est valide")
          dataPicture = {id: id, extend: result[1], picture: $scope.upload.avatarPict.base64}
          userService.image(dataPicture).success((data) ->
            api.putUser(data.user)
            notifService.success("Profile picture updated !")
          ).error((data) ->
            $scope.upload.avatarPict = undefined
            console.log("Putain d'erreur :")
            console.log(data)
          )
        else
          console.log("le type de l'image n'est pas valide")
      else
        console.log("Ce n'est pas une image :( !")

    userService.get($routeParams.id
    ).success((data) ->
      # save user data & Clone
      $scope.editUser = JSON.parse(JSON.stringify(data))
      user_original = JSON.parse(JSON.stringify(data))
    ).error((data) ->
    )

    $scope.show_picture = () ->
      if $scope.upload.avatarPict != undefined
        return "data:" + $scope.upload.avatarPict.filetype + ";base64," + $scope.upload.avatarPict.base64
      else if $scope.editUser.avatar != undefined && $scope.editUser.avatar.length > 0
        return $scope.editUser.avatar
      else
        console.log("No choose")

    $scope.update_user = () ->
      datas = userService.diff(user_original, $scope.editUser)
      if userService.isEmpty(datas)
        if ($scope.upload.avatarPict != undefined)
          upload_picture($routeParams.id)
      else
        userService.update($scope.editUser.id, datas
        ).success((data) ->
          if ($scope.upload.avatarPict != undefined)
            upload_picture($routeParams.id)
          $scope.editUser = JSON.parse(JSON.stringify(data.user))
          user_original = JSON.parse(JSON.stringify(data.user))
          api.putUser($scope.editUser)
          notifService.success("Profile Updated")
        ).error((data) ->
          console.log(data)
          if ($scope.upload.avatarPict != undefined)
            upload_picture($routeParams.id)
        )
)
