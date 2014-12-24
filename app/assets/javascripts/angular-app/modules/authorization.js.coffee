angular.module('app')
  .factory('authorization', ($http) ->

      return (
        login: (email, password) ->
          email = email || ''
          password = password || ''
          req = $http({
              url:'http://localhost:8080/sessions',
              method: 'POST',
              data: JSON.stringify(email: email, password: password),
              headers: {'Content-Type': 'application/json'}
            })
          return req
      )
  )