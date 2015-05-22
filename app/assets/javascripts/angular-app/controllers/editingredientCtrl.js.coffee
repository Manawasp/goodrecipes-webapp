angular.module('app').controller("editingredientCtrl", ($timeout, $q, $mdDialog, $scope, $location, $cookieStore, authorization, api, ingredientService, notifService)->
  $scope.ingredient = ingredientService.getCurrent()
  $scope.view = ingredientService.getView()
  $scope.error = ''
  $scope.ingredientPicture = undefined

  $scope.cancel = () ->
    $mdDialog.hide("answer");

  $scope.show_picture = () ->
    if $scope.ingredientPicture != undefined
      return "data:" + $scope.ingredientPicture.filetype + ";base64," + $scope.ingredientPicture.base64
    else if $scope.ingredient.icon != undefined && $scope.ingredient.icon.length > 0
      return $scope.ingredient.icon

  $scope.remove = () ->
    ingredientService.delete($scope.ingredient.id
    ).success((data) ->
      ingredientService.garbageRemove($scope.ingredient.id)
      $scope.cancel()
      notifService.success("Ingredient removed")
    ).error((data)->
      notifService.error(data.error)
    )

  $scope.update_ingredient = () ->
    $scope.error = ""
    data = {id: $scope.ingredient.id, name: $scope.ingredient.name, icon: $scope.ingredient.icon}
    ingredientService.update(data
    ).success((data) ->
      ingredientService.garbageUpdate(data) # - DEBUG
      if ($scope.ingredientPicture != undefined)
        $scope.upload_picture(data.id)
      else
        notifService.success("Ingredient updated !")
        $mdDialog.cancel()
    ).error((data) ->
      notifService.error(data.error)
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
          ingredientService.garbageUpdate(data)
          notifService.success("Ingredient updated !")
          $mdDialog.cancel()
        ).error((data) ->
          notifService.error(data.error)
        )
      else
        notifService.error("Wrong picture type, only jpg & png")
    else
      notifService.error("Isn't a picture")

  $scope.accessSuplier = api.getAccessSupplier();
)
