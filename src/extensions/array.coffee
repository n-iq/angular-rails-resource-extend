angular.module('rails.extend').factory 'RailsResourceArrayMixin', (RailsResourceInjector) ->

  RailsResourceArrayMixin = ->

  RailsResourceArrayMixin.extended = (Resource) ->
    Resource.intercept 'response', (result, resource, context) ->
      if angular.isArray(result.data) and angular.isDefined(result.originalData.meta)
        result.data.$count = result.originalData.meta.count
        result.data.$total = result.originalData.meta.total
        result.data.$page = result.originalData.meta.page
        result.data.$originalParams = result.config.params
        if result.data.$remoteBusy == undefined
          result.data.$remoteBusy = false

        result.data.$nextPage = ->
          if result.data.$remoteBusy
            return
          result.data.$remoteBusy = true
          nextPage = result.data.$page + 1
          resource.query(page: nextPage).then (data) ->
            for key of data
              if data[key] != undefined and data[key].constructor.name == 'Resource'
                result.data.push data[key]
            result.data.$page++
            result.data.$remoteBusy = false
            return
          return

        result.data.$goToPage = (currentPage) ->
          if result.data.$remoteBusy
            return
          result.data.$remoteBusy = true
          params = jQuery.extend(result.data.$originalParams, page: currentPage)
          resource.query(params).then (data) ->
            delete_idxs = []
            for key of result.data
              if result.data[key] != undefined and result.data[key].constructor.name == 'Resource'
                delete_idxs.push key
            for key of delete_idxs
              result.data.splice 0, 1
            for key of data
              if data[key] != undefined and data[key].constructor.name == 'Resource'
                result.data.push data[key]
            result.data.$remoteBusy = false

      result

  RailsResourceArrayMixin
