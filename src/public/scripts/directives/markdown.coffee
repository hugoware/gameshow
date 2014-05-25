
angular.module 'gameshow'
  .directive 'markdown', () ->
    restrict: 'A'
    scope:
      markdown: '='

    # replace content
    controller: ( $scope, $element ) ->
      $scope.$watch 'markdown', ( value ) ->

        # create markup
        html = markdown.toHTML value or ''

        # custom replacements


        # update the content
        $element.html html
