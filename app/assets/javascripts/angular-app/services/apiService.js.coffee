angular.module('app')
  .factory('apiService', ($http) ->
      return (
        url: () ->
          'http://localhost:8080/'
      )
  )