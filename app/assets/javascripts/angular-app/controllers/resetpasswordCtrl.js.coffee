angular.module('app').controller("resetpasswordCtrl", ($scope, $location, $routeParams, userService, notifService)->
		console.log 'loginCtrl running'
		$scope.template = 'views/checkpassword.html'
		$scope.data = {password: "", passwordConfirmed: ""}
		$scope.error = ""
		$scope.haveError = ->
			return true if $scope.error != ''
			return false

		$scope.locate = (location) ->
			$location.url(location);

		$scope.resetPassword = (token, passwod) ->
			$scope.error = ""
			if ($scope.data.password.length >= 6)
				if ($scope.data.password == $scope.data.passwordConfirmed)
					userService.initPassword($routeParams.token, $scope.data.password
					).success((data)->
						notifService.success("Password updated")
						$location.url('login')
					).error((data) ->
						$scope.error = data.error
						)
				else
					$scope.error = "Passwords must be same"
			else
				$scope.error = "Password must be greater"

)
