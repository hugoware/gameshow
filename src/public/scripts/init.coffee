
# initialize app
angular.module 'gameshow', [

  # additional modules
  'ngRoute'

  ]

  # general configuration
  .value 'Config',
    CLIENT_ID: window.CLIENT_ID
    TYPES: window.TYPES
    POLL_INTERVAL: 5000
    TIERS: [ '$50', '$100', '$150', '$200', '$250', '$300', '$500' ]


  # extend angular
  .config () ->

    # safely performs an action in a scope
    angular.safe_apply = ( scope, action ) ->
      if /\$(apply|digest)/i.test( scope.$$phase )
        action()
      else
        scope.$apply action

    # helper to clear text selection
    angular.clear_selection = () ->
      try
        if document.selection and document.selection.empty
          document.selection.empty()
        else if window.getSelection
          sel = window.getSelection()
          sel.removeAllRanges()


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
