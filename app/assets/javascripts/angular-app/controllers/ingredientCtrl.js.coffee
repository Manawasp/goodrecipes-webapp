angular.module('app').controller("ingredientCtrl", ($mdDialog, $scope, $location, $cookieStore, authorization, api, ingredientService)->
    console.log 'ingredientCtrl running'
    $scope.template = 'views/ingredient.html'
    $scope.error = ''
    $scope.ingredient = {description: "", labels: [], savours: [], blacklist: []}
    $scope.garbage = ingredientService.garbage()

    $scope.data = {
      page: 1
      offset: 0
      limit: 40
      ingredients : []
      results: 0;
      pagination: []
    }

    $scope.loadPage = (value) ->
      console.log("ok....")
      $scope.updatePage(2)
      searchIngredient()


    $scope.updatePage = (value)->
      if value > 0
        $scope.data.page    = value
        $scope.data.offset  = (value - 1) * $scope.data.limit
        searchIngredient(()->
          $scope.data.pagination.length = 0
          console.log("updated... ? page:" + $scope.data.page)
          n = $scope.data.page - 4
          while (n < ($scope.data.page + 4))
            if (n > 0 && (n*$scope.data.limit) < $scope.data.results)
              $scope.data.pagination.push n
            n += 1
        )


    $scope.get_url_upload = () ->
      'http://localhost:8080/pictures/'

    $scope.image_path = (img) ->
      img

    $scope.search = () ->
      searchIngredient()

    searchIngredient = (paginationCallback) ->
      console.log("offset:" + $scope.data.offset)
      ingredientService.search($scope.ingredient.description,
                                $scope.ingredient.labels,
                                $scope.ingredient.savours,
                                $scope.ingredient.blacklist,
                                $scope.data.offset,
                                $scope.data.limit
      ).success((data) ->
        # console.log "success data in search ingredient"
        # console.log data
        $scope.data.results = data.max
        ingredientService.garbageInit(data.ingredients)
        $scope.data.ingredients = ingredientService.garbage()
        console.log(data)
        #paginarion
        paginationCallback()
      ).error((data) ->
        # console.log "error data in search ingredient"
        # console.log data
      )


    $scope.showEditingIngredient = (ev, id) ->
      ingredientService.setView(true)
      ingredientService.setCurrent(id)
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

    $scope.updatePage(1)
)
