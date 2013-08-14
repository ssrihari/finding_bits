angular.module('findingBitsApp').controller 'SearchController', ['$log', '$scope', '$http', ($log, $scope, $http) ->
  init = ->
    $scope.form = {
      search_snippet: ""
      language: 'python'
    }

    $scope.languagesList = [ 'ruby', 'python']

  $scope.search = ->
    $http.get("search.json", {params: $scope.form}).
      success (data, status, headers, config) ->
        $scope.search_results = data

  init()
]