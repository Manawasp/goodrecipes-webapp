@app = angular.module('app', [
  # additional dependencies here, such as restangular
  'ngRoute',
  'ngCookies',
  'ngMaterial',
  'monospaced.elastic'
])

# for compatibility with Rails CSRF protection

@app.config(($mdThemingProvider, $routeProvider, $locationProvider, $httpProvider)->
  $httpProvider.interceptors.push('httpInterceptor');
  
  $routeProvider
    .when('/', {
      templateUrl: 'views/dashboard.html',
      controller: 'homepageCtrl' })

    .when('/moments', {
      templateUrl: 'views/dashboard.html',
      controller: 'momentCtrl' })
    .when('/moments/create', {
      templateUrl: 'views/dashboard.html',
      controller: 'createmomentCtrl' })

    .when('/recipes/users/:userid', {
      templateUrl: 'views/dashboard.html',
      controller: 'myrecipeCtrl' })
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


    .when('/users/search', {
      templateUrl: 'views/dashboard.html',
      controller: 'searchuserCtrl' })

    .when('/users/:userid', {
      templateUrl: 'views/dashboard.html',
      controller: 'profileCtrl' })
    .when('/login', { templateUrl: 'views/auth.html', controller: 'loginCtrl' })
    .when('/signin', { templateUrl: 'views/auth.html', controller: 'signupCtrl' })
    .otherwise({ redirectTo: '/' })
)

@app.run((api)->
  api.init()
  console.log 'angular app running'
)