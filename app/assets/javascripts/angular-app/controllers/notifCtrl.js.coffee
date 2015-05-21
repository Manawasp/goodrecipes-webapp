angular.module('app').controller('ToastCtrl', ($scope, $mdToast) ->
  $scope.closeToast = ()->
    $mdToast.hide();
)
