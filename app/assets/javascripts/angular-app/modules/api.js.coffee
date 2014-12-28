angular.module('app').factory('api', ($http, $cookies, $location, userService) ->
  current_user = {}    
  access_gastronomist  = false
  access_supplier      = false
  access_admin         = false

  init_access = () ->
    access_tabs = current_user.access || []
    for t_access in access_tabs
      if t_access == "gastronomist"
        access_gastronomist = true
      else if t_access == "supplier"
        access_supplier = true
      else if t_access == "admin"
        access_admin = true

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
            init_access()
          ).error((data, status, headers, config) ->
            console.log "WATT DAFUQ "
          )
      else
        $location.path('/login')
    putUser: (data) ->
      current_user = data
      init_access()
    delUser: () ->
      current_user = {}
    getUser: () ->
      return current_user
    getAccessGastronomist: () ->
      return (access_gastronomist)
    getAccessSupplier: () ->
      return (access_supplier)
    getAccessAdmin: () ->
      return (access_admin)
  )
)