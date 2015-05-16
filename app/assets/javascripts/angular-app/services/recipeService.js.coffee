angular.module('app')
  .factory('recipeService', ($http, apiService) ->
      current_recipe = {}
      view = false
      searchObject = {recipe: {description: "", labels: [], blacklist: []}, labels: [{'c': false, 'name': 'breakfast & brunch'}, {'c': false, 'name': 'appetizer'}, {'c': false, 'name': 'dessert'}, {'c': false, 'name': 'healty'}, {'c': false, 'name': 'main dish'}, {'c': false, 'name': 'pasta'}, {'c': false, 'name': 'slow cooker'}, {'c': false, 'name': 'vegetarian'}, {'c': false, 'name': 'sauce'}, {'c': false, 'name': 'cheese'}, {'c': false, 'name': 'fruit'}, {'c': false, 'name': 'vegetable'}, {'c': false, 'name': 'sea food'}, {'c': false, 'name': 'fish'}, {'c': false, 'name': 'spicy'}, {'c': false, 'name': 'meat'}, {'c': false, 'name': 'chicken'}, {'c': false, 'name': 'beef'}], denied: [{'c': false, 'name': 'arachide'}, {'c': false, 'name': 'egg'}, {'c': false, 'name': 'milk'}, {'c': false, 'name': 'halal'}, {'c': false, 'name': 'kascher'}],data:{offset:0,limit:30},more_recipe: []}


      return (
        getMoreRecipe: ()->
          return more_recipe
        getApplySearch: ()->
          for element in searchObject.labels
            if element.c
              searchObject.recipe.labels.push element.name

          for element in searchObject.denied
            if element.c
              searchObject.recipe.blacklist.push element.name

          this.search(searchObject.recipe.description,
                                    searchObject.recipe.labels,
                                    searchObject.recipe.savours,
                                    searchObject.recipe.blacklist,
                                    [],
                                    searchObject.data.offset,
                                    searchObject.data.limit
          ).success((data) ->
            searchObject.more_recipe.length = 0
            for recipe in data.recipes
              searchObject.more_recipe.push recipe
            console.log(data.recipes)
            console.log(searchObject.more_recipe)
          ).error((data) ->
            console.log "error data in search ingredient"
            # console.log data
          )
        getSearchRecipe: () ->
          return searchObject.recipe
        getSearchHardReset: ()->
          this.getSearchReset()
          searchObject.recipe.description = ""
        getSearchReset: ()->
          for label in searchObject.labels
            label.c = false
          for deny in searchObject.denied
            deny.c = false
          searchObject.recipe.labels.length = 0
          searchObject.recipe.blacklist.length = 0
        getSearch: () ->
          return searchObject
        create: (data) ->
          req = $http.post(apiService.url() + '/recipes/', data)
          return req
        get: (idhash) ->
          req = $http.get(apiService.url() + '/recipes/' + idhash)
          return req
        search: (name, labels, savours, blacklist, ingredients, offset, limit, created_by) ->
          data = {}
          if name && name.length > 0
            data.title = name
          if labels && labels.length > 0
            data.labels = labels
          if savours && savours.length > 0
            data.savours = savours
          if blacklist && blacklist.length > 0
            data.blacklist = blacklist
          if ingredients && ingredients.length > 0
            data.ingredients = ingredients
          if offset && offset.length > 0
            data.offset = offset
          if limit && limit > 0
            data.limit = limit
          if created_by && created_by.length > 0
            data.create_by = created_by
          console.log(data)
          req = $http.post(apiService.url() + '/recipes/search', data)
          return req
        update: (data) ->
          req = $http.patch(apiService.url() + '/recipes/' + data.id, data)
          return req
        image: (data) ->
          req = $http.post(apiService.url() + '/recipes/' + data.id + '/pictures', data)
          return req
          console.log(type)
        setCurrent: (data) ->
          current_recipe = data
        getCurrent: () ->
          return current_recipe
        setView: (dview) ->
          view = dview
        getView: () ->
          return view
      )
  )
