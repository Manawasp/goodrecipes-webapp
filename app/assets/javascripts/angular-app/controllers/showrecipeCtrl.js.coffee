angular.module('app').controller("showrecipeCtrl", (homepageService, $routeParams, $mdDialog, $scope, $location, $cookieStore, authorization, api, recipeService, ingredientService, notifService)->
    console.log 'showrecipesCtrl running'

    $scope.api = api
    $scope.template = 'views/showrecipe.html'
    $scope.error = ''
    $scope.ingredients = []
    $scope.data = {
      page: 1
      offset: 0
      limit: 10
      comments : []
      results: 0;
      pagination: []
      sync: false
    }
    $scope.recipe = {}
    $scope.mark = [0.5, 1.5, 2.5, 3.5, 4.5]

    $scope.redir_recipe = (id) ->
      $location.url('/recipes/show/' + id)

    $scope.editRecipe = (id) ->
      $location.url('/recipes/edit/' + id)

    recipeService.get($routeParams.id
    ).success((data) ->
      syncData(data)
    ).error((data) ->
      $location.url('/')
    )

    $scope.userRecipe = (id) ->
      $location.url('recipes/search?userId='+id);

    syncData = (data) ->
      console.log(data)
      $scope.recipe = data.recipe
      $scope.data.results = $scope.recipe.reviews
      if $scope.recipe.minutes == undefined || $scope.recipe.hours == undefined
        data.recipe.time = "1h00"
      else
        addZero = if $scope.recipe.minutes < 10 then "0" else ""
        data.recipe.time = $scope.recipe.hours.toString() + "h" + $scope.recipe.minutes.toString() + addZero
      $scope.author = data.user
      # init steps if empty
      if data.recipe.steps.length == 0
        $scope.recipe.steps.push ""
      # sync ingredient
      ingredientService.clean()
      ingredientService.setLock(true)
      igs = ingredientService.getSearch()
      for ig in data.ingredients
        igs.push ig
      $scope.updateCommentPage(1)
      console.log($scope.recipe)
      $scope.data.sync = true

    homepageService.random(5
    ).success((data) ->
      $scope.more_recipe = data.recipes
      $scope.more_recipe.push data.recipes[0]
    ).error((data) ->
    )

    $scope.makeFavorite = (value) ->
      if value
        recipeService.unfavorite($scope.recipe.id
        ).success((data) ->
          notifService.success("You unlike this recipe")
          $scope.recipe.liked = false
        ).error((data) ->
          console.log("Make favorite error :" + data)
        )
      else
        recipeService.favorite($scope.recipe.id
        ).success((data) ->
          notifService.success("You like this recipe")
          $scope.recipe.liked = true
        ).error((data) ->
          notifService.error(data.error)
        )

    $scope.showReviewRecipe = (ev) ->
      $mdDialog.show(
        controller: 'reviewrecipeCtrl',
        templateUrl: "/views/reviewrecipe.html",
        targetEvent: ev).then ((answer) ->
        # $scope.alert = 'You said the information was "' + answer + '".'
        return
      ), ->
        # $scope.alert = 'You cancelled the dialog.'
        return
      return


    $scope.updateCommentPage = (value)->
      if value > 0
        $scope.data.page    = value
        $scope.data.offset  = (value - 1) * $scope.data.limit
        searchComments(()->
          $scope.data.pagination.length = 0
          n = $scope.data.page - 4
          while (n < ($scope.data.page + 4))
            if (n > 0 && ((n-1)*$scope.data.limit) < $scope.data.results)
              $scope.data.pagination.push n
            n += 1
        )

    searchComments = (paginationCallback) ->
      console.log("offset:" + $scope.data.offset)
      recipeService.searchReview($scope.recipe.id,
                                $scope.data.offset,
                                $scope.data.limit
      ).success((data) ->
        # console.log "success data in search ingredient"
        # console.log data
        console.log(data)
        $scope.data.results = data.max
        $scope.data.comments = data.reviews
        console.log($scope.data.comments)
        #paginarion
        paginationCallback()
      ).error((data) ->
        # console.log "error data in search ingredient"
        # console.log data
      )

    $scope.removeConfirm = (ev) ->
      confirm = $mdDialog.confirm()
        .title('Do you want to remove this recipe ?')
        .content($scope.recipe.title)
        .ariaLabel('Lucky day')
        .ok("I'm sure")
        .cancel('Cancel')
        .targetEvent(ev);
      $mdDialog.show(confirm).then(() ->
        recipeService.delete($scope.recipe.id
        ).success((data) ->
          notifService.success("Recipe removed")
          $location.url('/')
        ).error((data) ->
          notifService.error(data.error)
        )
      , () ->
        console.log("Choose to stop")
      )
)
