var app = angular.module('app', ['ui', '$strap.directives', 'siyfion.ngTypeahead']);

angular.module('siyfion.ngTypeahead', [])
  .directive('ngTypeahead', function () {
    return {
      restrict: 'ACE',
      scope: {
        datasets: '=',
        ngModel: '='
      },
      link: function (scope, element) {
        element.typeahead(scope.datasets);

        // Updates the ngModel binding when a value is manually selected from the dropdown.
        // ToDo: Think about how the value could be updated on user entry...
        element.bind('typeahead:selected', function (object, datum) {
          scope.$apply(function() {
            scope.ngModel = datum;
          });
        });

        // Updates the ngModel binding when a query is autocompleted.
        element.bind('typeahead:autocompleted', function (object, datum) {
          scope.$apply(function() {
            scope.ngModel = datum;
          });
        });
      }
    };
  });


app.controller('FeedSearchCtrl', function($scope) {
  $scope.$watch('new_feed', function() {
    console.log($scope.new_feed);
  });

  $scope.typeaheadData = {
    name: 'Feeds',
    template: function(feed) {
      var result = "";
      result += "<img src='data:image/png;base64," + feed.favicon + "'>";
      result += feed.label;
      return result;
    },
    remote: { 
      url: "http://query.yahooapis.com/v1/public/yql?format=json&q=select * from json where url=\"http://www.newsblur.com/rss_feeds/feed_autocomplete?term=",
      replace: function(url, uriEncodedQuery) {
        return url + encodeURI(uriEncodedQuery) + "\"";
      },
      filter: function(data) {
        var results = angular.isDefined(data.query.results.json.json) ? data.query.results.json.json : [data.query.results.json];

        if (results) {
          _.map(results, function(result) {
            result.text = result.label;
          })
          return results;
        } else {
          return [];
        }
      }
    }
  };
});
