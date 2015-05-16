angular.module('app').controller("userCtrl", ($scope,  $mdSidenav, $location, $cookieStore, userService, api, recipeService)->
    $scope.search_name = ''
    $scope.searchValue = ''
    $scope.currentPath = $location.$$path || ""
    currentPathSplit   = $scope.currentPath.split('/')
    $scope.recipeSearch = recipeService.getSearchRecipe()
    if ($location.$$path != '/recipes/search')
      recipeService.getSearchHardReset()
    if currentPathSplit.length > 3
      console.log(currentPathSplit)
      $scope.currentPath = '/' + currentPathSplit[1] + '/' + currentPathSplit[2]

    $scope.toggleLeft = () ->
      $mdSidenav('left').toggle()

    $scope.user = api.getUser()
    $scope.id = $scope.user.id || ""
    console.log ($scope.user.avatar || "/images/avatar.jpg")

    if $scope.user.avatar == undefined
      $scope.avatar = "/images/avatar.jpg"
    else if $scope.user.avatar == ""
      $scope.avatar = "/images/avatar.png"
    else
      $scope.avatar = $scope.user.avatar

    $scope.access_gastronomist  = false
    $scope.access_supplier      = false
    $scope.access_admin         = false
    access_tabs = $scope.user.access || []
    for t_access in access_tabs
      if t_access == "gastronomist"
        $scope.access_gastronomist = true
      else if t_access == "supplier"
        $scope.access_supplier = true
      else if t_access == "admin"
        $scope.access_admin = true

    $scope.redir_title = () ->
      loc = 'recipes/search?title=' + $scope.search_name;
      $location.url(loc);

    $scope.locate = (location) ->
      $location.url(location);

    $scope.logout = () ->
      $cookieStore.remove('id')
      $cookieStore.remove('token')
      api.delUser()
      $location.path('/login');

    $scope.searchRecipe = () ->
      if ($location.$$path == '/recipes/search')
        recipeService.getApplySearch()
      else
        $location.url('recipes/search?title='+$scope.recipeSearch.description);

    $scope.redir_your_profile = () ->
      loc = 'users/' + $scope.id;
      $location.url(loc);

    # console.log  api.getUser()
    # $scope.connected = authorization.isLogged()
    console.log 'userCtrl running'
)
