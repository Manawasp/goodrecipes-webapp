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
    .when('/moment', {
      templateUrl: 'views/dashboard.html',
      controller: 'momentCtrl' })
    .when('/moment/create', {
      templateUrl: 'views/dashboard.html',
      controller: 'createmomentCtrl' })

    .when('/recipe', {
      templateUrl: 'views/dashboard.html',
      controller: 'recipeCtrl' })
    .when('/recipe/create', {
      templateUrl: 'views/dashboard.html',
      controller: 'createrecipeCtrl' })
    .when('/recipe/show/:id', {
      templateUrl: 'views/dashboard.html',
      controller: 'showrecipeCtrl' })

    .when('/ingredient/create', {
      templateUrl: 'views/dashboard.html',
      controller: 'createingredientCtrl' })
    .when('/ingredient', {
      templateUrl: 'views/dashboard.html',
      controller: 'ingredientCtrl' })


    .when('/user/search', {
      templateUrl: 'views/dashboard.html',
      controller: 'searchuserCtrl' })

    .when('/users/:userid', {
      templateUrl: 'views/dashboard.html',
      controller: 'profileCtrl' })
    .when('/login', { templateUrl: 'views/auth.html', controller: 'loginCtrl' })
    .when('/signin', { templateUrl: 'views/auth.html', controller: 'signupCtrl' })
    .otherwise({ redirectTo: '/moment' })
)

@app.run((api)->
  api.init()
  console.log 'angular app running'
)