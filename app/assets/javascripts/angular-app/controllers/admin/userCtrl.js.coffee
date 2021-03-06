angular.module('app').controller("adminUserCtrl", ($timeout, $q, $scope, $location, $cookieStore, authorization, api, userService, recipeService, notifService)->
    console.log 'adminuserCtrl running'
    $scope.template = 'views/admin/user.html'
    $scope.data = {
      page: 1
      offset: 0
      limit: 20
      users : []
      results: 0;
      pagination: []
      search: {grosist: false, cooker: false, admin: false, pseudo: ""}
    }

    $scope.updatePage = (value)->
      if value > 0
        $scope.data.page    = value
        $scope.data.offset  = (value - 1) * $scope.data.limit
        searchUser(()->
          $scope.data.pagination.length = 0
          n = $scope.data.page - 4
          while (n < ($scope.data.page + 4))
            if (n > 0 && ((n-1)*$scope.data.limit) < $scope.data.results)
              $scope.data.pagination.push n
            n += 1
        )

    # CURRENT PATH
    $scope.currentPath = $location.$$path || ""
    currentPathSplit   = $scope.currentPath.split('/')
    if ($location.$$path != '/recipes/search')
      recipeService.getSearchHardReset()
    if currentPathSplit.length > 3
      console.log(currentPathSplit)
      $scope.currentPath = '/' + currentPathSplit[1] + '/' + currentPathSplit[2]
    console.log($scope.currentPath)

    # tabbox
    $scope.items = ["Grosist", "Cooker", "Admin"];
    $scope.selected = [];
    $scope.toggle = (item, list) ->
      idx = list.indexOf(item);
      if (idx > -1)
        list.splice(idx, 1);
      else
        list.push(item);
    $scope.exists = (item, list) ->
      return list.indexOf(item) > -1;

    #search
    searchUser = (paginationCallback) ->
      $scope.data.users = []
      userService.search($scope.data.search).success((data) ->
        console.log(data)
        $scope.data.users = data.users
        for user in data.users
          user.admin    = false
          user.cooker   = false
          user.supplier  = false
          console.log(user.access)
          for acc in user.access
            if acc == "gastronomist"
              user.cooker   = true
            else if acc == "supplier"
              user.supplier = true
            else if acc == "admin"
              user.admin    = true
        $scope.data.results = data.max
        #paginarion
        paginationCallback()
      ).error((data) ->
        console.log(data)
      )

    # SCOPE method
    $scope.userAccess = (typeAccess, value, id) ->
      console.log("type: "+typeAccess+"/userAcces : "+value, "/.id:" + id)
      data = {}
      value = !value
      if (typeAccess == 'admin')
        data.admin = value
      else if (typeAccess == 'cooker')
        data.cooker = value
      else if (typeAccess == 'supplier')
        data.supplier = value
      userService.updateAdminAccess(data, id
      ).success((data) ->
        #
      ).error((data) ->
        # back to real value if error with the api
        if (typeAccess == 'admin')
          data.admin = value
        else if (typeAccess == 'cooker')
          data.cooker = value
        else if (typeAccess == 'supplier')
          data.supplier = value
      )

    # check access
    $scope.updatePage(1)
)
