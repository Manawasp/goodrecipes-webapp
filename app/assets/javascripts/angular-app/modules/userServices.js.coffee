angular.module('app')
  .factory('userService', ($http, apiService) ->
      return (
        create: (pseudo, email, password) ->
          email     = email     || ''
          password  = password  || ''
          pseudo    = pseudo    || ''
          req = $http.post(apiService.url() + '/users', {pseudo: pseudo, email: email, password: password})
          return req
        get: (idhash) ->
          req = $http.get(apiService.url() + '/users/' + idhash)
          return req
        search: () ->
          req = $http.post(apiService.url() + '/users/search')
        follow: (idhash) ->
          idhash = idhash || ''
          req = $http.post(apiService.url() + '/followers', {id: idhash})
          return req
        getFollower: (idhash) ->
          req = $http.get(apiService.url() + '/followers/' + idhash)
          return req
        removeFollower: (idhash) ->
          req = $http.del(apiService.url() + '/followers/' + idhash)
          return req
      )
  )