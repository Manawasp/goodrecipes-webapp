angular.module('app').controller("createingredientCtrl", (FileUploader, $mdDialog, $scope, $location, $cookieStore, authorization, api, ingredientService)->
  console.log 'createingredientCtrl running'
  $scope.error = ''
  $scope.ingredient = {name: '', icon: ''}

  $scope.cancel = () ->
    $mdDialog.cancel()

  $scope.get_url_upload = () ->
    'http://localhost:8080/pictures/'

  $scope.image_path = (img) ->
    if img == ''
      ''
    else
      $scope.get_url_upload() + img

  $scope.uploader_avatar = new FileUploader();
  $scope.uploader_avatar.url = $scope.get_url_upload()
  $scope.uploader_avatar.onAfterAddingFile = () ->
    this.uploadAll()
  $scope.uploader_avatar.onSuccessItem = (item, response, status, headers) ->
    $scope.ingredient.icon = response.url

  $scope.create_ingredient = () ->
    $scope.error = ""
    if ($scope.ingredient.icon == '')
      $scope.error = "image"
    else
      data = {name: $scope.ingredient.name, icon: $scope.ingredient.icon}
      ingredientService.create(data
      ).success((data) ->
        $mdDialog.cancel()
        # console.log "sucees modif"
        console.log data
      ).error((data) ->
        if data.error == "name contain at least 2 characters"
          $scope.error = 'toosmall'
        else if data.error == "this ingredient already exist"
          $scope.error = 'exist'
        console.log "error :"
        console.log data
      )
)