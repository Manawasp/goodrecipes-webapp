angular.module('app').controller("ingredientCtrl", ($mdDialog, $scope, $location, $cookieStore, authorization, api, ingredientService)->
    console.log 'ingredientCtrl running'
    $scope.template = 'views/ingredient.html'
    $scope.error = ''
    $scope.ingredient = {description: "", labels: [], savours: [], blacklist: []}

    $scope.data = {
      offset : 0
      limit : 40
      ingredients : []
    }

    $scope.get_url_upload = () ->
      'http://localhost:8080/pictures/'

    $scope.image_path = (img) ->
      img

    $scope.search = () ->
      searchIngredient()

    searchIngredient = () ->
      ingredientService.search($scope.ingredient.description,
                                $scope.ingredient.labels,
                                $scope.ingredient.savours,
                                $scope.ingredient.blacklist,
                                $scope.data.offset,
                                $scope.data.limit
      ).success((data) ->
        # console.log "success data in search ingredient"
        # console.log data
        $scope.data.ingredients = data.ingredients
      ).error((data) ->
        # console.log "error data in search ingredient"
        # console.log data
      )


    $scope.showEditingIngredient = (data) ->
      ingredientService.setView(true)
      ingredientService.setCurrent(data)
      console.log(data)
      $mdDialog.show(
        controller: 'editingredientCtrl'
        templateUrl: "/views/editingredient.html"
      ).then (() ->
        # $scope.alert = "You said the information was \"" + answer + "\"."
      ), ->
        # $scope.alert = "You cancelled the dialog."

    $scope.showCreateIngredient = (data) ->
      $mdDialog.show(
        controller: 'createingredientCtrl'
        templateUrl: "/views/createingredient.html"
      ).then (() ->
        # $scope.alert = "You said the information was \"" + answer + "\"."
      ), ->
        # $scope.alert = "You cancelled the dialog."

    searchIngredient()
)
