angular.module('app')
  .factory('ingredientService', ($http, apiService) ->
      current_ingredient = {}

      return (
        create: (data) ->
          req = $http.post(apiService.url() + '/ingredients', data)
          return req
        get: (idhash) ->
          req = $http.get(apiService.url() + '/ingredients/' + idhash)
          return req
        search: (name, labels, savours, blacklist, offset, limit) ->
          data = {}
          if name && name.length > 0
            data.name = name
          if labels && labels.length > 0
            data.labels = labels
          if savours && savours.length > 0
            data.savours = savours
          if blacklist && blacklist.length > 0
            data.blacklist = blacklist
          if offset && offset.length > 0
            data.offset = offset
          if limit && limit.length > 0
            data.limit = limit
          req = $http.post(apiService.url() + '/ingredients/search', data)
          return req
        update: (data) ->
          req = $http.patch(apiService.url() + '/ingredients/' + data.id, data)
          return req
        setCurrent: (data) ->
          current_ingredient = data
        getCurrent: () ->
          return current_ingredient
      )
  )