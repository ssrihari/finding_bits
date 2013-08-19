angular.module('findingBitsApp').controller 'SearchController', ['$log', '$scope', '$http', ($log, $scope, $http) ->
  init = ->
    $scope.form = {
      search_snippet: "devil"
      language: 'ruby'
    }

    $scope.languagesList = [ 'ruby', 'python']

  $scope.search = ->
    $scope.is_searching = true;
    $http.get("search.json", {params: $scope.form}).
      success (data, status, headers, config) ->
        $scope.search_results = data
        $scope.is_searching = false

  init()
]