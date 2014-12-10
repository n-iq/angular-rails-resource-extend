(function() {
  angular.module('rails.extend', ['rails.extend.extensions']);

}).call(this);
;(function() {
  angular.module('rails.extend.extensions', ['rails.extend.extensions.array', 'rails.extend.extensions.permission', 'rails.extend.extensions.attribute', 'rails.extend.extensions.permission', 'rails.extend.extensions.flash']);

  angular.module('rails.extend.extensions.array', []);

  angular.module('rails.extend.extensions.permission', []);

  angular.module('rails.extend.extensions.attribute', []);

  angular.module('rails.extend.extensions.permission', []);

  angular.module('rails.extend.extensions.flash', []);

}).call(this);
;(function() {
  angular.module("rails.extend").factory("RailsResourceArrayMixin", ['RailsResourceInjector', '$q', '$log', '$rootScope', function(RailsResourceInjector, $q, $log, $rootScope) {
    var RailsResourceArrayMixin;
    RailsResourceArrayMixin = function() {};
    RailsResourceArrayMixin.extended = function(Resource) {
      return Resource.intercept("response", function(result, resource, context) {
        if (angular.isArray(result.data) && angular.isDefined(result.originalData.meta)) {
          result.data.$count = result.originalData.meta.count;
          result.data.$total = result.originalData.meta.total;
          result.data.$page = result.originalData.meta.page;
          if (result.data.$remoteBusy === undefined) {
            result.data.$remoteBusy = false;
          }
          result.data.$nextPage = function() {
            var nextPage;
            if (result.data.$remoteBusy) {
              return;
            }
            result.data.$remoteBusy = true;
            nextPage = result.data.$page + 1;
            return resource.query({
              page: nextPage
            }).then(function(data) {
              var key;
              for (key in data) {
                if ((data[key] != null) && data[key].constructor.name === "Resource") {
                  result.data.push(data[key]);
                }
              }
              result.data.$page++;
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


}).call(this);
;(function() {
  angular.module("rails.extend.extensions.attribute").factory("RailsResourceAttributeMixin", function() {
    var RailsResourceAttributeMixin, extractedValue, updateOnly;
    RailsResourceAttributeMixin = function() {};

    /**
    update the attributes only with given keys
     */
    updateOnly = function() {
      if (arguments.length < 1) {
        return;
      }
      return this.constructor.$put(this.$url(), extractedValue(this, arguments));
    };

    /**
    extracted the values into a new hash
     */
    extractedValue = function(obj, argArr) {
      var arg, hash, _i, _len;
      hash = {};
      for (_i = 0, _len = argArr.length; _i < _len; _i++) {
        arg = argArr[_i];
        hash[arg] = obj[arg];
      }
      return hash;
    };
    RailsResourceAttributeMixin.extended = function(Resource) {
      return Resource.include({
        updateOnly: updateOnly,
        extractedValue: extractedValue
      });
    };
    return RailsResourceAttributeMixin;
  });

}).call(this);
;(function() {


}).call(this);
;(function() {


}).call(this);
;(function() {
  angular.module("rails.extend.extensions.permission").factory("RailsResourcePermissionMixin", ['RailsResourceInjector', '$railsExtendPermission', function(RailsResourceInjector, $railsExtendPermission) {
    var $can, RailsResourcePermissionMixin, _permissionNode;
    _permissionNode = $railsExtendPermission.getPermissionNode();
    RailsResourcePermissionMixin = function() {};
    $can = function(action) {
      var permissions;
      permissions = this[_permissionNode];
      return ((permissions != null) && permissions[action]) || false;
    };
    RailsResourcePermissionMixin.extended = function(Resource) {
      return Resource.include({
        $can: $can
      });
    };
    return RailsResourcePermissionMixin;
  }]);

}).call(this);
;(function() {
  'use strict';
  angular.module('rails.extend.extensions.permission').provider('$railsExtendPermission', function() {
    var $injector, _permissionNode;
    $injector = null;
    _permissionNode = 'permission';
    this.setupProviders = function(injector) {
      return $injector = injector;
    };
    this.getPermissionNode = function() {
      return angular.copy(_permissionNode);
    };
    this.setPermissionNode = function(node) {
      return this.permissionNode = node;
    };
    this.get = function($injector) {
      this.setupProviders($injector);
      return {
        getPermissionNode: this.getPermissionNode,
        setPermissionNode: this.setPermissionNode
      };
    };
    this.get.$inject = ['$injector'];
    this.$get = this.get;
  });

}).call(this);
