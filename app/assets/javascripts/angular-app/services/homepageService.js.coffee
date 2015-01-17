angular.module('app')
  .factory('homepageService', ($http, apiService) ->
      current_recipe = {}
      view = false

      return (
        month: () ->
          req = $http.get(apiService.url() + '/homepage/month')
          return req
        week: () ->
          req = $http.get(apiService.url() + '/homepage/week')
          return req
        latest: () ->
          req = $http.get(apiService.url() + '/homepage/latest')
          return req
        random: () ->
          req = $http.get(apiService.url() + '/homepage/random')
          return req
      )
  )