angular.module('app')
  .factory('recipeService', ($http, apiService) ->
      current_recipe = {}
      view = false

      return (
        create: (data) ->
          req = $http.post(apiService.url() + '/recipes/', data)
          return req
        get: (idhash) ->
          req = $http.get(apiService.url() + '/recipes/' + idhash)
          return req
        search: (name, labels, savours, blacklist, ingredients, offset, limit) ->
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
