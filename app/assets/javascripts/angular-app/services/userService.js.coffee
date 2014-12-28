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
        update: (user_origin, user_new) ->
          data = {}
          if user_new.password
            data.password = user_new.password
          if user_new.email != user_origin.email
            data.email = user_new.email
          if user_new.firstname != user_origin.firstname
            data.firstname = user_new.firstname
          if user_new.lastname != user_origin.lastname
            data.lastname = user_new.lastname
          if user_new.pseudo != user_origin.pseudo
            data.pseudo = user_new.pseudo
          req = $http.patch(apiService.url() + '/users/' + user_origin.id, data)
          return req
        follow: (idhash) ->
          idhash = idhash || ''
          req = $http.post(apiService.url() + '/followers', {user_id: idhash})
          return req
        getFollowed: (idhash) ->
          req = $http.get(apiService.url() + '/followeds/' + idhash)
          return req
        getFollower: (idhash) ->
          req = $http.get(apiService.url() + '/followers/' + idhash)
          return req
        removeFollower: (idhash) ->
          req = $http.delete(apiService.url() + '/followers/' + idhash)
          return req
      )
  )