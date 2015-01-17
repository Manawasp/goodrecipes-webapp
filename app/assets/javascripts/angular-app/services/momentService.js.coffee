angular.module('app')
  .factory('momentService', ($http, apiService) ->
      current_recipe = {}
      view = false

      return (
        create: (data) ->
          req = $http.post(apiService.url() + '/moments/', data)
          return req
        get: (idhash) ->
          req = $http.get(apiService.url() + '/moments/' + idhash)
          return req
        search: (created_by, offset, limit) ->
          data = {}
          if created_by && created_by.length > 0
            data.title = name
          if offset && offset.length > 0
            data.offset = offset
          if limit && limit > 0
            data.limit = limit
          req = $http.post(apiService.url() + '/moments/search', data)
          return req
        update: (data) ->
          req = $http.patch(apiService.url() + '/moments/' + data.id, data)
          return req
      )
  )