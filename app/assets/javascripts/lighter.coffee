angular.module('findingBitsApp').directive('syntaxcode', ($timeout) ->
  return {
    restrict: 'EA',
    replace: true,
    transclude: false,
    scope: { language: "@", snippet: "="},
    template: "<pre class='brush: {{language}}'>{{snippet}}</pre>",
    link: (scope, $iElement, iAttrs) ->
      $timeout( ->
        SyntaxHighlighter.highlight({}, $iElement[0])
      , 0)

  }
)
