angular.module('app').controller("editingredientCtrl", ($mdDialog, $scope, $location, $cookieStore, authorization, api, ingredientService)->
  $scope.ingredient = ingredientService.getCurrent()
  $scope.view = ingredientService.getView()
  $scope.error = ''
  $scope.ingredientPicture = undefined

  $scope.cancel = () ->
    $mdDialog.cancel()

  # $scope.uploader_avatar = new FileUploader();
  # $scope.uploader_avatar.url = $scope.get_url_upload()
  # $scope.uploader_avatar.onAfterAddingFile = () ->
  #   this.uploadAll()
  # $scope.uploader_avatar.onSuccessItem = (item, response, status, headers) ->
  #   $scope.ingredient.icon = response.url
  $scope.show_picture = () ->
    if $scope.ingredientPicture != undefined
      return "data:" + $scope.ingredientPicture.filetype + ";base64," + $scope.ingredientPicture.base64
    else if $scope.ingredient.icon != undefined && $scope.ingredient.icon.length > 0
      return $scope.ingredient.icon


  $scope.update_ingredient = () ->
    $scope.error = ""
    data = {id: $scope.ingredient.id, name: $scope.ingredient.name, icon: $scope.ingredient.icon}
    ingredientService.update(data
    ).success((data) ->
      console.log("create ingredient success")
      console.log(data)
      if ($scope.ingredientPicture != undefined)
        $scope.upload_picture(data.id)
      else
        $mdDialog.cancel()
    ).error((data) ->
        if data.error == "name contain at least 2 characters"
          $scope.error = 'toosmall'
        else if data.error == "this ingredient already exist"
          $scope.error = 'exist'
        console.log "error :"
        console.log data
    )

  $scope.upload_picture = (id) ->
    console.log("need an upload of picture !")
    $scope.error = ""
    result = $scope.ingredientPicture.filetype.split(/\//)
    if result[0] == "image"
      console.log("C'est une image !")
      if result[1] != undefined && result[1] == "jpeg"
        result[1] = "jpg"
      if result[1] != undefined && (result[1] == "jpg" || result[1] == "png")
        console.log("le type de l'image est valide")
        dataPicture = {id: id, extend: result[1], picture: $scope.ingredientPicture.base64}
        ingredientService.image(dataPicture).success((data) ->
          console.log("Upload success image return :")
          console.log(data)
          $mdDialog.cancel()
        ).error((data) ->
          console.log("Putain d'erreur :")
          console.log(data)
        )
      else
        console.log("le type de l'image n'est pas valide")
    else
      console.log("Ce n'est pas une image :( !")

  $scope.accessSuplier = api.getAccessSupplier();
)
