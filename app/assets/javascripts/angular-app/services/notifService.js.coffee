angular.module('app')
  .factory('notifService', ($mdToast, $animate) ->
			timeNotif = 2000
			return (
				error: (msg)->
		      $mdToast.show({
		        controller: 'ToastCtrl',
		        templateUrl: 'views/notif.html',
		        locals: {msg: msg, value: false}
		        hideDelay: timeNotif,
		        bindToController:true,
		        controllerAs: "notifCtrl",
		        position: "top right"
		      })
				success: (msg)->
		      $mdToast.show({
		        controller: 'ToastCtrl',
		        templateUrl: 'views/notif.html',
		        locals: {msg: msg, value: true}
		        hideDelay: timeNotif,
		        bindToController:true,
		        controllerAs: "notifCtrl",
		        position: "top right"
		      })
			)
	)
