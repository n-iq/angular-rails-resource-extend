angular.module("rails.extend").factory "RailsResourceArrayMixin", (RailsResourceInjector, $q, $log, $rootScope) ->

  _changePage = (collection, page, resource, opts) ->
    return if collection.$remoteBusy
    collection.$remoteBusy = true
    params = {page: page}
    angular.extend(params, collection.$filterCriteria)
    angular.extend(params, opts)
    resource.query(params).then (data) ->
      for key of data
        collection.push data[key]  if data[key]? and data[key].constructor.name is "Resource"
      collection.$page++
      collection.$remoteBusy = false

  RailsResourceArrayMixin = ->

    RailsResourceArrayMixin.extended = (Resource) ->
      Resource.intercept "response", (result, resource, context) ->
        if angular.isArray(result.data) and angular.isDefined(result.originalData.meta)
          result.data.$count = result.data.length
          result.data.$isLastPage = result.data.$count is 0
          result.data.$total = result.originalData.meta.total
          result.data.$aggregations = result.originalData.meta.aggregations
          result.data.$filterCriteria = {}
          result.data.$page = result.originalData.meta.page || 1
          result.data.$remoteBusy = false  if result.data.$remoteBusy is `undefined`
          console.log result.data, result.data.$isLastPage
          result.data.$nextPage = (opts)->
            console.log '', result.data, result.data.$isLastPage
            return if result.data.$isLastPage
            nextPage = result.data.$page + 1
            _changePage(result.data, nextPage, resource, opts)

          result.data.$changePage = (page, opts) ->
            _changePage(result.data, page, resource, opts)


        result

    RailsResourceArrayMixin