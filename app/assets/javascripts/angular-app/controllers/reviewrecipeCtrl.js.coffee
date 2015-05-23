angular.module('app').controller("reviewrecipeCtrl", ($mdDialog, $scope, $location, $routeParams, authorization, api, recipeService, notifService)->
  $scope.review = {comment:"", mark: 5, recipeId: $routeParams.id}

  $scope.cancel = () ->
    $mdDialog.cancel()

  $scope.validate = () ->
    recipeService.createReview($scope.review
    ).success((data) ->
      notifService.success(data.success)
    ).error((data) ->
      notifService.error(data.error)
    )
    $mdDialog.cancel()
)
