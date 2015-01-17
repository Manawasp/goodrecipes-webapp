angular.module('app').controller("createmomentCtrl", ($scope, $location, $cookieStore, authorization, api)->
    console.log 'createmomentCtrl running'
    $scope.template = 'views/createmoment.html'
    # data.selectedIndex = '2'
    $scope.error = ''
    $scope.moment = {}

    $scope.cancel = () ->
      $mdDialog.cancel()

    $scope.get_url_upload = () ->
      'http://localhost:8080/pictures/'

    $scope.image_path = (img) ->
      $scope.get_url_upload() + img

    $scope.uploader_avatar = new FileUploader();
    $scope.uploader_avatar.url = $scope.get_url_upload()
    $scope.uploader_avatar.onAfterAddingFile = () ->
      this.uploadAll()
    $scope.uploader_avatar.onSuccessItem = (item, response, status, headers) ->
      $scope.ingredient.icon = response.url
)