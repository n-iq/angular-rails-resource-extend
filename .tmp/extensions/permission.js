(function() {
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
