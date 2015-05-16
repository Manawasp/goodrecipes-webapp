angular.module('app').controller("profileCtrl", ($scope, $routeParams, $location, $cookieStore, userService, api)->

    $scope.template = 'views/editprofile.html'
    $scope.data = {
      send : false,
      error : '',
      isfriend : false
    }
    user_original = {}
    $scope.user = {}
    $scope.obj = {}
    $scope.upload = {avatarPict: undefined}

    $scope.show_picture = () ->
      if $scope.upload.avatarPict != undefined
        return "data:" + $scope.upload.avatarPict.filetype + ";base64," + $scope.upload.avatarPict.base64
      else if $scope.ingredient.icon != undefined && $scope.ingredient.icon.length > 0
        return $scope.ingredient.icon

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
            console.log("Upload success image return :")
            console.log(data)
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
      $scope.user = JSON.parse(JSON.stringify(data))
      console.log(data)
      console.log($scope.user)
      user_original = JSON.parse(JSON.stringify(data))
      console.log(user_original)
    ).error((data) ->
    )

    $scope.show_picture = () ->
      if $scope.upload.avatarPict != undefined
        return "data:" + $scope.upload.avatarPict.filetype + ";base64," + $scope.upload.avatarPict.base64
      else if $scope.user.avatar != undefined && $scope.user.avatar.length > 0
        return $scope.user.avatar
      else
        console.log("No choose")

    $scope.update_user = () ->
      $scope.data.send = true
      $scope.data.error = ''
      userService.update(user_original, $scope.user
      ).success((data) ->
        if ($scope.upload.avatarPict != undefined)
          upload_picture($routeParams.id)
        console.log(data)
        $scope.user = Object.create(data)
        user_original = Object.create(data)
        $scope.data.send = false
      ).error((data) ->
        if data.error != 'empty request'
          $scope.data.error = data.error
        else
          upload_picture($routeParams.id)
        $scope.data.send = false
      )
)
