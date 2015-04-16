angular.module('rails.extend').factory 'RailsResourceFilterMixin', (RailsResourceInjector, $q, $rootScope) ->

  RailsResourceFlashMixin = ->

  RailsResourceFlashMixin.extended = (Resource) ->
    Resource.intercept 'response', (result) ->
      if result.originalData.filters
        #TODO: wait the correct serve data
        $rootScope.filters = result.originalData.filters
      result
    Resource.intercept 'responseError', (rejection) ->
      $q.reject rejection

  RailsResourceFlashMixin
