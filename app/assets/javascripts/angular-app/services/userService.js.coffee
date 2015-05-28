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
        search: (params) ->
          if (params == undefined)
            data = {};
          else
            data = {};
            if (params.pseudo.length > 0)
              data.pseudo = params.pseudo;
            data.access = []
            if (params.grosist)
              data.access.push("supplier");
            if (params.cooker)
              data.access.push("gastronomist");
            if (params.admin)
              data.access.push("admin")
          return $http.post(apiService.url() + '/users/search', data)
        isEmpty: (data) ->
          if data.password == undefined && data.email == undefined && data.firstname == undefined && data.pseudo  == undefined && data.lastname == undefined
            return true
          return false
        diff: (user_origin, user_new) ->
          data = {}
          if user_new.password && user_new.password.length > 0
            data.password = user_new.password
          if user_new.email != user_origin.email
            data.email = user_new.email
          if user_new.firstname != user_origin.firstname
            data.firstname = user_new.firstname
          if user_new.lastname != user_origin.lastname
            data.lastname = user_new.lastname
          if user_new.pseudo != user_origin.pseudo
            data.pseudo = user_new.pseudo
          return data
        update: (id, data) ->
          req = $http.patch(apiService.url() + '/users/' + id, data)
          return req
        updateAdminAccess: (data, id) ->
          return $http.patch(apiService.url() + '/admin/users/' + id, data)
        image: (data) ->
          req = $http.post(apiService.url() + '/users/' + data.id + '/pictures', data)
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
