angular.module('app').controller("ingredientCtrl", ($mdDialog, $scope, $location, $cookieStore, authorization, api, ingredientService)->
    console.log 'ingredientCtrl running'
    $scope.template = 'views/ingredient.html'
    $scope.error = ''
    $scope.ingredient = {description: "", labels: [], savours: [], blacklist: []}
    $scope.garbage = ingredientService.garbage()

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
        ingredientService.garbageInit(data.ingredients)
        $scope.data.ingredients = ingredientService.garbage()
      ).error((data) ->
        # console.log "error data in search ingredient"
        # console.log data
      )


    $scope.showEditingIngredient = (ev) ->
      ingredientService.setView(true)
      ingredientService.setCurrent(ev)
      $mdDialog.show(
        controller: 'editingredientCtrl',
        templateUrl: "/views/editingredient.html",
        targetEvent: ev).then ((answer) ->
        # $scope.alert = 'You said the information was "' + answer + '".'
        return
      ), ->
        # $scope.alert = 'You cancelled the dialog.'
        return
    $scope.showCreateIngredient = (ev) ->
      $mdDialog.show(
        controller: 'createingredientCtrl',
        templateUrl: "/views/createingredient.html",
        targetEvent: ev).then ((answer) ->
        # $scope.alert = 'You said the information was "' + answer + '".'
        return
      ), ->
        # $scope.alert = 'You cancelled the dialog.'
        return
      return

    searchIngredient()
)
