angular.module('findingBitsApp').directive('syntaxcode', ($timeout) ->
  return {
    restrict: 'EA',
    replace: true,
    transclude: false,
    scope: { language: "@", snippet: "="},
    template: "<pre></pre>",
    link: (scope, $iElement, iAttrs) ->
      $timeout( ->
#        window.x=hljs.highlight(scope.language, scope.snippet, true)
        $iElement.html(hljs.highlight(scope.language, scope.snippet, true).value)
#        console.log($iElement)
#        SyntaxHighlighter.highlight({}, $iElement[0])
      , 0)

  }
)
