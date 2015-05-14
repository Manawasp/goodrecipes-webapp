angular.module('app').controller("editerecipeCtrl", ($routeParams, $mdDialog, $scope, $location, authorization, api, recipeService)->
    console.log 'editrecipesCtrl running'

    $scope.template = 'views/createrecipe.html'
    $scope.type = 'edit'
    $scope.error = ''
    $scope.ingredients = []
    $scope.labels = [{'c': false, 'name': 'breakfast & brunch'},  {'c': false, 'name': 'appetizer'},
                    {'c': false, 'name': 'dessert'},              {'c': false, 'name': 'healty'},
                    {'c': false, 'name': 'main dish'},            {'c': false, 'name': 'pasta'},
                    {'c': false, 'name': 'slow cooker'},          {'c': false, 'name': 'vegetarian'},
                    {'c': false, 'name': 'sauce'},                {'c': false, 'name': 'cheese'},
                    {'c': false, 'name': 'fruit'},                {'c': false, 'name': 'vegetable'},
                    {'c': false, 'name': 'sea food'},             {'c': false, 'name': 'fish'},
                    {'c': false, 'name': 'spicy'},                {'c': false, 'name': 'meat'},
                    {'c': false, 'name': 'chicken'},              {'c': false, 'name': 'beef'}]
    $scope.denied = [{'c': false, 'name': 'arachide'},  {'c': false, 'name': 'egg'},
                      {'c': false, 'name': 'milk'},     {'c': false, 'name': 'halal'},
                      {'c': false, 'name': 'kascher'}]

    $scope.add_step = () ->
      $scope.recipe.steps.push ""

    $scope.remove_step = (id) ->
      if $scope.recipe.steps.length > 1
        $scope.recipe.steps.splice(id, 1)

    syncData = (data) ->
      $scope.recipe = data.recipe
      console.log($scope.recipe)
      data.recipe.time = $scope.recipe.time_total.h.toString() + "d" + $scope.recipe.time_total.m.toString()
      $scope.author = data.user
      $scope.ingredients = data.ingredients
      # init steps if empty
      if data.recipe.steps.length == 0
        $scope.recipe.steps.push ""
      # sync description ingredients
      # data.recipe.ingredients_describe = []
      # for desc in data.recipe.parts
      #   data.recipe.ingredients_describe.push desc
      # console.log($scope.recipe.ingredients_describe)
      # sync labels
      for rlab in data.recipe.labels
        for label in $scope.labels
          if label.name == rlab
            label.c = true
      # sync denied
      for rlab in data.recipe.blacklist
        for label in $scope.denied
          if label.name == rlab
            label.c = true

    recipeService.get($routeParams.id
    ).success((data) ->
      syncData(data)
    ).error((data) ->
      $location.url('/')
    )

    $scope.validate = () ->
      data = {"id": $scope.recipe.id, "ingredients": [],"time_total": {"h": 0, "m": 0}, "parts": ""}
      console.log("begin step")
      if ($scope.recipe.time.length > 0)
        res = $scope.recipe.time.split("h")
        console.log(parseInt(1))
        if res.length == 2
          if parseInt(res[0]) == NaN || parseInt(res[0]) == 0
            console.log("default so 0 h :" + res[0])
            data.time_total.h = 0
          else
            data.time_total.h = parseInt(res[0])
          if parseInt(res[1]) == NaN || parseInt(res[0]) == 0
            console.log("default so 0 m :" + res[1])
            data.time_total.m = 0
          else
            data.time_total.m = parseInt(res[1])
          console.log("time time : " + data.time_total.h.toString() + "h" + data.time_total.m.toString())
        else
          # Error
          console.log("Error: time bad format")
      else
        console.log("Error: time is empty")
      console.log("step1!")

      data.title        = $scope.recipe.title
      data.description  = $scope.recipe.description
      console.log("step2bis!")

      # debug if ingredients is empty
      if $scope.recipe.ingredients is undefined
        $scope.recipe.ingredients = []
      for element in $scope.recipe.ingredients
        if element.id
          data.ingredients.push element.id
      console.log("step2!")

      data.people       = $scope.recipe.people || 0
      data.steps        = $scope.recipe.steps  || []
      console.log("step3!")

      if $scope.recipe.image
        data.image = $scope.recipe.image
      console.log("step4!")

      data.parts = $scope.recipe.parts
      console.log("step5!")

      data.labels = []
      for element in $scope.labels
        if element.c == true
          data.labels.push element.name
      console.log("step6!")

      data.blacklist = []
      for element in $scope.denied
        if element.c == true
          data.blacklist.push element.name
      console.log("step7!")

      console.log(data)

      recipeService.update(data
      ).success((data) ->
        console.log "SUCCESS : Update RECIPE"
        console.log data
        $location.url('/recipes/show/' + data.recipe.id)
      ).error((data) ->
        console.log data
        $scope.error = data.error
      )
)
