angular.module('app').controller("myrecipeCtrl", ($mdDialog, $scope, $location, $cookieStore, authorization, api, ingredientService, recipeService)->
    console.log 'myrecipeCtrl running'
    $scope.template = 'views/myrecipe.html'

    $scope.mark = [0.5, 1.5, 2.5, 3.5, 4.5]
    $scope.more_recipe = [{'id': '1', 'icon': '', 'title': 'Avocado Dessert', 'comment_length': 12,'total': {'h': 1, 'm': 0}, 'mark': 4.7},
                          {'id': '2', 'icon': '', 'title': 'Apple pie', 'comment_length': 12,'total': {'h': 0, 'm': 45}, 'mark': 4.2},
                          {'id': '3', 'icon': '', 'title': 'Moules cuites au wok', 'comment_length': 12,'total': {'h': 1, 'm': 45}, 'mark': 4.2},
                          {'id': '4', 'icon': '', 'title': 'Pizza viande de boeuf hachee', 'comment_length': 12,'total': {'h': 0, 'm': 45}, 'mark': 4.2}]
)