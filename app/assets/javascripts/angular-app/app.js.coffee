@app = angular.module('app', [
  # additional dependencies here, such as restangular
  'ngRoute',
  'ngCookies',
  'ngMaterial',
  'monospaced.elastic',
  'naif.base64'
])

# for compatibility with Rails CSRF protection

@app.config(($mdThemingProvider, $routeProvider, $locationProvider, $httpProvider)->
  $httpProvider.interceptors.push('httpInterceptor');

  $routeProvider
    .when('/', {
      templateUrl: 'views/dashboard.html',
      controller: 'homepageCtrl' })

    .when('/recipes/users/:userid', {
      templateUrl: 'views/dashboard.html',
      controller: 'myrecipeCtrl' })
    .when('/recipes/edit/:id', {
      templateUrl: 'views/dashboard.html',
      controller: 'editerecipeCtrl' })
    .when('/recipes/search', {
      templateUrl: 'views/dashboard.html',
      controller: 'recipeCtrl' })
    .when('/recipes/create', {
      templateUrl: 'views/dashboard.html',
      controller: 'createrecipeCtrl' })
    .when('/recipes/show/:id', {
      templateUrl: 'views/dashboard.html',
      controller: 'showrecipeCtrl' })

    .when('/ingredients', {
      templateUrl: 'views/dashboard.html',
      controller: 'ingredientCtrl' })
    .when('/favorites', {
      templateUrl: 'views/dashboard.html',
      controller: 'favoriteCtrl' })


    .when('/users/search', {
      templateUrl: 'views/dashboard.html',
      controller: 'searchuserCtrl' })

    .when('/users/edit/:id', {
      templateUrl: 'views/dashboard.html',
      controller: 'profileCtrl' })

    .when('/login', { templateUrl: 'views/auth.html', controller: 'loginCtrl' })
    .when('/signup', { templateUrl: 'views/auth.html', controller: 'signupCtrl' })

    .when('/admin/users', {templateUrl: 'views/admin/dashboard.html', controller: 'adminUserCtrl'
      })

    .otherwise({ redirectTo: '/' })
)

@app.run((api)->
  api.init()
  console.log 'angular app running'
)
