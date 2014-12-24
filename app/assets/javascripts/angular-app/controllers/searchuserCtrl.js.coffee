angular.module('app').controller("searchuserCtrl", ($scope, $location, $cookieStore, userService, api)->
    console.log 'recipeCtrl running'
    $scope.template = 'views/searchuser.html'
    $scope.error = ''
    userService.search(
    ).success((data) ->
      console.log "works"
      console.log data
      $scope.users = data.users
    ).error((data) ->
      console.log "doesn't works"
    )
)