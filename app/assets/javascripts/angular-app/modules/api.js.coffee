angular.module('app').factory('api', ($http, $cookies, $location, userService) ->
  current_user = {}

  return (
    init: (token) ->
      $http.defaults.useXDomain = true;
      delete $http.defaults.headers.common['X-Requested-With'];
      
      if $cookies.token && $cookies.id
        cookies_token = $cookies.token.replace(/"/g, '')
      if cookies_token || token
        $http.defaults.headers.common['Auth-Token'] = token || cookies_token
      if $cookies.token && $cookies.id
        cookies_id = $cookies.id.replace(/"/g, '')
        req = userService.get(cookies_id)
        req.success((data, status, headers, config) ->
            current_user = data
          ).error((data, status, headers, config) ->
            console.log "WATT DAFUQ "
          )
      else
        $location.path('/login')
    putUser: (data) ->
      current_user = data
    delUser: () ->
      current_user = {}
    getUser: () ->
      return current_user
  )
)