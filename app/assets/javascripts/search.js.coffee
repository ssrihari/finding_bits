angular.module('findingBitsApp').controller 'SearchController', ['$log', '$scope', '$http', '$timeout', ($log, $scope, $http, $timeout) ->
  init = ->
    $scope.request_count = 0
    $scope.form = {
      search_snippet: "devil"
      language: 'ruby'
    }

    $scope.languagesList = [ 'ruby', 'python']

  $scope.search = ->
    $scope.is_searching = true
    $scope.search_results = {}
    $scope.make_request(4)

  # Make a search request, retry if the result isn't immediately available.
  $scope.make_request = (maximum_retries, current_retries=0) ->
    $http.get("search.json", {params: $scope.form}).
      success (data, status, headers, config) ->
        if data["status"] == 'available'
          $scope.search_results = data["result"]
          $scope.is_searching = false
        else if data["status"] == 'queued'
          if current_retries+1 == maximum_retries
            $scope.search_status = "Sorry, could not run the query. Please try again after sometime."
          else
            $scope.search_status = "Searching.."
            $timeout (->
              $scope.make_request maximum_retries, current_retries+1
            ), current_retries*1500

  init()
]