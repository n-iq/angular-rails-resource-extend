(function() {
  angular.module('rails.extend').factory('RailsResourceFilterMixin', function(RailsResourceInjector, $q, $rootScope) {
    var RailsResourceFlashMixin;
    RailsResourceFlashMixin = function() {};
    RailsResourceFlashMixin.extended = function(Resource) {
      Resource.intercept('response', function(result) {
        if (result.originalData.filters) {
          $rootScope.filters = result.originalData.filters;
        }
        return result;
      });
      return Resource.intercept('responseError', function(rejection) {
        return $q.reject(rejection);
      });
    };
    return RailsResourceFlashMixin;
  });

}).call(this);
