angular.module('app').directive('ngRecipes', ['$location', function($location) {

  return {
    restrict: 'A',
    require: '^ngModel',
    scope: {
      ngModel: '='
    },
    templateUrl: 'views/recipe-card.html',
    link: function($scope, element, attrs) {
      $scope.redirRecipe = function(id) {
        $location.url('/recipes/show/' + id)
      }
    }
  }
}]);
