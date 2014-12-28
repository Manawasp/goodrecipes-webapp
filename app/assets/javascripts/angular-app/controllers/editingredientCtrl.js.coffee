angular.module('app').controller("editingredientCtrl", ($mdDialog, $scope, $location, $cookieStore, authorization, api, ingredientService)->
  $scope.ingredient = ingredientService.getCurrent()

  $scope.addLabel = (label) ->
    idx = $scope.ingredient.labels.indexOf(label)
    if label && label.length > 0 && idx == -1
      $scope.ingredient.labels.push label
  $scope.addBlacklist = (label) ->
    idx = $scope.ingredient.blacklist.indexOf(label)
    if label && label.length > 0 && idx == -1
      $scope.ingredient.blacklist.push label
  $scope.delLabel = (label) ->
    idx = $scope.ingredient.labels.indexOf(label)
    if idx != -1
      $scope.ingredient.labels.splice(idx, 1)
  $scope.delBlacklist = (label) ->
    idx = $scope.ingredient.blacklist.indexOf(label)
    if idx != -1
      $scope.ingredient.blacklist.splice(idx, 1)

  $scope.hide = ->
    $mdDialog.hide()

  $scope.cancel = ->
    $mdDialog.cancel()

  $scope.answer = (answer) ->
    $mdDialog.hide answer

  $scope.update_ingredient = () ->
    data = {id: $scope.ingredient.id, labels: $scope.ingredient, blacklist: $scope.blacklist, name: $scope.name}
    ingredientService.update(data
    ).success((data) ->
      console.log "sucees modif"
      console.log data
    ).error((data) ->
      console.log "echec modif"
      console.log data
    )
)