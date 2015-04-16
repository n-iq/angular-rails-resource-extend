angular.module('rails.extend')
.factory 'RailsResourcePermissionMixin', ->
  RailsResourcePermissionMixin = ->

  RailsResourcePermissionMixin.extended = (Resource) ->
    Resource.intercept 'response', (result, resource, context) ->
      return unless result.originalData.meta? and result.originalData.meta.permissions?
      if angular.isArray(result.data)

      else
        console.log 'asdf', result.originalData.meta
        result.data.$permissions = result.originalData.meta.permissions

      result

  RailsResourcePermissionMixin

