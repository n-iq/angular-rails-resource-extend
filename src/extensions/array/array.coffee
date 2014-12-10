angular.module("rails.extend").factory "RailsResourceArrayMixin", (RailsResourceInjector, $q, $log, $rootScope) ->
  RailsResourceArrayMixin = ->
    return

  RailsResourceArrayMixin.extended = (Resource) ->
    Resource.intercept "response", (result, resource, context) ->
      if angular.isArray(result.data) and angular.isDefined(result.originalData.meta)
        result.data.$count = result.originalData.meta.count
        result.data.$total = result.originalData.meta.total
        result.data.$page = result.originalData.meta.page
        result.data.$remoteBusy = false  if result.data.$remoteBusy is `undefined`
        result.data.$nextPage = ->
          return  if result.data.$remoteBusy
          result.data.$remoteBusy = true
          nextPage = result.data.$page + 1
          resource.query(page: nextPage).then (data) ->
            for key of data
              result.data.push data[key]  if data[key]? and data[key].constructor.name is "Resource"
            result.data.$page++
            result.data.$remoteBusy = false
      result

  RailsResourceArrayMixin
