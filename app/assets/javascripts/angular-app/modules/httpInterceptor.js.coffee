angular.module("app").factory "httpInterceptor", httpInterceptor = ($q, $window, $location) ->
  (promise) ->
    success = (response) ->
      response

    error = (response) ->
      # console.log response.data['error']
      # console.log response.status
      # console.log response.content
      $location.url "/login"  if response.status is 401
      $q.reject response

    promise.then success, error
