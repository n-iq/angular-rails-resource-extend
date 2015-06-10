(function() {
  angular.module('rails.extend');

}).call(this);
;(function() {
  angular.module('rails.extend').factory('RailsResourceArrayMixin', ['RailsResourceInjector', function(RailsResourceInjector) {
    var RailsResourceArrayMixin;
    RailsResourceArrayMixin = function() {};
    RailsResourceArrayMixin.extended = function(Resource) {
      return Resource.intercept('response', function(result, resource, context) {
        if (angular.isArray(result.data) && angular.isDefined(result.originalData.meta)) {
          result.data.$count = result.originalData.meta.count;
          result.data.$total = result.originalData.meta.total;
          result.data.$page = result.originalData.meta.page;
          result.data.$originalParams = result.config.params;
          if (result.data.$remoteBusy === void 0) {
            result.data.$remoteBusy = false;
          }
          result.data.$nextPage = function() {
            var nextPage;
            if (result.data.$remoteBusy) {
              return;
            }
            result.data.$remoteBusy = true;
            nextPage = result.data.$page + 1;
            resource.query({
              page: nextPage
            }).then(function(data) {
              var key;
              for (key in data) {
                if (data[key] !== void 0 && data[key].constructor.name === 'Resource') {
                  result.data.push(data[key]);
                }
              }
              result.data.$page++;
              result.data.$remoteBusy = false;
            });
          };
          result.data.$goToPage = function(currentPage) {
            var params;
            if (result.data.$remoteBusy) {
              return;
            }
            result.data.$remoteBusy = true;
            params = jQuery.extend(result.data.$originalParams, {
              page: currentPage
            });
            return resource.query(params).then(function(data) {
              var delete_idxs, key;
              delete_idxs = [];
              for (key in result.data) {
                if (result.data[key] !== void 0 && result.data[key].constructor.name === 'Resource') {
                  delete_idxs.push(key);
                }
              }
              for (key in delete_idxs) {
                result.data.splice(0, 1);
              }
              for (key in data) {
                if (data[key] !== void 0 && data[key].constructor.name === 'Resource') {
                  result.data.push(data[key]);
                }
              }
              return result.data.$remoteBusy = false;
            });
          };
        }
        return result;
      });
    };
    return RailsResourceArrayMixin;
  }]);

}).call(this);
;(function() {
  angular.module('rails.extend').factory('RailsResourceFilterMixin', ['RailsResourceInjector', '$q', '$rootScope', function(RailsResourceInjector, $q, $rootScope) {
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
  }]);

}).call(this);
;(function() {
  angular.module('rails.extend').factory('RailsResourcePermissionMixin', function() {
    var RailsResourcePermissionMixin;
    RailsResourcePermissionMixin = function() {};
    RailsResourcePermissionMixin.extended = function(Resource) {
      return Resource.intercept('response', function(result, resource, context) {
        if (!((result.originalData.meta != null) && (result.originalData.meta.permissions != null))) {
          return;
        }
        if (angular.isArray(result.data)) {

        } else {
          console.log('asdf', result.originalData.meta);
          result.data.$permissions = result.originalData.meta.permissions;
        }
        return result;
      });
    };
    return RailsResourcePermissionMixin;
  });

}).call(this);
