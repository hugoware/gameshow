
# initialize app
angular.module 'gameshow', [

  # additional modules
  'ngRoute'

  ]

  # general configuration
  .value 'Config',
    CLIENT_ID: window.CLIENT_ID
    TIERS: [ '$100', '$200', '$300', '$400', '$500', '$600', '$700' ]

  # setup the app
  .config ( $routeProvider ) ->

    # safely performs an action in a scope
    angular.safe_apply = ( scope, action ) ->
      if /\$(apply|digest)/i.test( scope.$$phase )
        action()
      else
        scope.$apply action

    # define routes
    $routeProvider
     .when '/display', { templateUrl: '/views/display', controller: 'DisplayController' }
     .when '/remote', { templateUrl: '/views/remote', controller: 'RemoteController' }
     .when '/view', { templateUrl: '/views/view', controller: 'ViewController' }
     .when '/', { templateUrl: '/views/login', controller: 'LoginController' }
     .otherwise { templateUrl: '/views/missing', controller: 'MissingController' }
