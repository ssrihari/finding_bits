angular.module('findingBitsApp').controller 'SearchController', ['$log', '$scope', '$http', ($log, $scope, $http) ->
  init = ->
    $scope.languagesList = [ {name: 'ruby'}, {name: 'python'}]

  $scope.search_params = ->
    {
      search_snippet: $scope.search_snippet,
      language: $scope.language.name
    }

  $scope.search = ->
    $http.get("search.json", {params: $scope.search_params()}).
      success (data, status, headers, config) ->
        $scope.search_results = data

  init()
]