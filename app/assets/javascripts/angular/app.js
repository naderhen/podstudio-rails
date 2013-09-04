var app = angular.module('app', ['ui', '$strap.directives']);

app.controller('FeedSearchCtrl', function($scope) {
  $scope.$watch('select2model', function() {
    console.log($scope.select2model);
  });

  $scope.select2Options = {
    minimumInputLength: 2,
    formatResult: function(object, container, query) {
      console.log(object, container, query);
      return "<img src='data:image/png;base64," + object.favicon + "'>";
    },
    ajax: {
      url: "http://query.yahooapis.com/v1/public/yql",
      data: function (term, page) {
        return {
          q:  "select * from json where url=\"http://www.newsblur.com/rss_feeds/feed_autocomplete?term=" + term + "\"",
          format: "json"
        };
      },
      results: function (data, page) {
        var results = angular.isDefined(data.query.results.json.json) ? data.query.results.json.json : [data.query.results.json];

        if (results) {
          _.map(results, function(result) {
            result.text = result.label;
          })
          return {results: results};
        } else {
          return {results: []};
        }
      }
    }
  }
});
