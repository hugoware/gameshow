
# initialize app
angular.module 'gameshow', [

  # additional modules
  'ngRoute'

  ]

  # general configuration
  .value 'Config',
    CLIENT_ID: window.CLIENT_ID
    TIERS: [ '$100', '$200', '$300', '$400', '$500', '$600', '$700' ]


  # extend angular
  .config () ->

    # safely performs an action in a scope
    angular.safe_apply = ( scope, action ) ->
      if /\$(apply|digest)/i.test( scope.$$phase )
        action()
      else
        scope.$apply action


  # setup the app
  .config ( $routeProvider ) ->

    # define routes
    $routeProvider
     .when '/display', { templateUrl: '/views/display', controller: 'DisplayController' }
     .when '/remote', { templateUrl: '/views/remote', controller: 'RemoteController' }
     .when '/view', { templateUrl: '/views/view', controller: 'ViewController' }
     .when '/login', { templateUrl: '/views/login', controller: 'LoginController' }
     .when '/', { templateUrl: '/views/home', controller: 'HomeController' }
     .otherwise { templateUrl: '/views/missing', controller: 'MissingController' }


  # starting the app
  .run ( $location ) ->

    # add fast click support
    FastClick.bind document.body

    # go to loading first
    $location.path '/'
