angular.module('app').controller("createrecipeCtrl", ($timeout, $q, $scope, $location, $cookieStore, authorization, api, ingredientService, recipeService, notifService)->
    console.log 'createrecipesCtrl running'
    $scope.template = 'views/createrecipe.html'
    $scope.error = ''
    $scope.form_ingredient = {description: ""}
    $scope.recipePict = undefined
    $scope.type = 'create'

    $scope.data = {
      offset : 0
      limit : 8
    }

    $scope.recipe = {"image": "","title":"Fabulous chocolat pie","description":"Le paradis du chocolat","people": 6,"preparation": {"h": 0, "m": 0}, "total": {"h": 0, "m": 0}, "time": "1h00", ingredients: [], steps: [""], ingredients_describe: [{title: "", description: ""}]}
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
                      {'c': false, 'name': 'milk'},     {'c': true, 'name': 'halal'},
                      {'c': true, 'name': 'kascher'}]

    $scope.show_picture = () ->
      if $scope.recipe.recipePict != undefined
        return "data:" + $scope.recipe.recipePict.filetype + ";base64," + $scope.recipe.recipePict.base64
      else if $scope.recipe.image != undefined && $scope.recipe.image.length > 0
        return $scope.recipe.image
      else
        console.log("No choose")

    ingredientService.clean()

    $scope.add_step = () ->
      $scope.recipe.steps.push ""

    $scope.remove_step = (id) ->
      if $scope.recipe.steps.length > 1
        $scope.recipe.steps.splice(id, 1)

    $scope.validate = () ->
      data = {"id": $scope.recipe.id, "ingredients": [],"time_total": {"h": 0, "m": 0}, "parts": ""}
      if ($scope.recipe.time.length > 0)
        res = $scope.recipe.time.split("h")
        if res.length == 2
          if parseInt(res[0]) == NaN || parseInt(res[0]) == 0
            data.time_total.h = 0
          else
            data.time_total.h = parseInt(res[0])
          if parseInt(res[1]) == NaN || parseInt(res[0]) == 0
            data.time_total.m = 0
          else
            data.time_total.m = parseInt(res[1])

      data.title        = $scope.recipe.title
      data.description  = $scope.recipe.description

      # debug if ingredients is empty

      data.people       = $scope.recipe.people || 0
      data.steps        = $scope.recipe.steps  || []

      if $scope.recipe.image
        data.image = $scope.recipe.image

      data.parts = $scope.recipe.parts

      data.labels = []
      for element in $scope.labels
        if element.c == true
          data.labels.push element.name

      data.blacklist = []
      for element in $scope.denied
        if element.c == true
          data.blacklist.push element.name

      ig = ingredientService.getSearch()
      for elem in ig
        data.ingredients.push elem.id

      recipeService.create(data
      ).success((datares) ->
        if ($scope.recipe.recipePict != undefined)
          $scope.upload_picture(datares.recipe.id)
        else
          notifService.success("Recipe created")
          $location.url('/recipes/show/' + datares.recipe.id)
      ).error((datares) ->
        notifService.success(datares.error)
      )

    $scope.upload_picture = (id) ->
      console.log("need an upload of picture !")
      $scope.error = ""
      result = $scope.recipe.recipePict.filetype.split(/\//)
      if result[0] == "image"
        if result[1] != undefined && result[1] == "jpeg"
          result[1] = "jpg"
        if result[1] != undefined && (result[1] == "jpg" || result[1] == "png")
          dataPicture = {id: id, extend: result[1], picture: $scope.recipe.recipePict.base64}
          recipeService.image(dataPicture).success((data) ->

            notifService.success("Recipe created")
            $location.url('/recipes/show/' + id)
          ).error((data) ->

            notifService.error(data.error)
            $location.url('/recipes/show/' + id)
          )
        else
          notifService.error("Wrong picture type, only jpg & png")
      else
        notifService.error("Isn't a picture")
)
