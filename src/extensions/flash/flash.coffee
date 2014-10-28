#angular.module("rails.extend").factory "RailsResourceFlashMixin", (RailsResourceInjector, $q, growl, $rootScope, $railsExtendFlash) ->
#
#  _nodeName = $railsExtendFlash.nodeName
#  _messageName = $railsExtendFlash.messageName
#
#  _render_messages_array = (messages) ->
#    str = ""
#    str += "<ul>"
#    for key of messages
#      str += "<li>" + messages[key] + "</li>"
#    str += "</ul>"
#    str
#
#  RailsResourceFlashMixin = ->
#    return
#
#  RailsResourceFlashMixin.extended = (Resource) ->
#    Resource.intercept "response", (result) ->
#      metaData = result.originalData[_nodeName]
#
#      if result.originalData and angular.isDefined(metaData)
#        growl_str = ""
#        if metaData[_messageName] is "warning"
#          growl_str = metaData[_messageName].warning
#          $rootScope.$broadcast "flash:warning", growl_str
#        if metaData[_messageName] is "info"
#          growl_str = metaData[_messageName].info
#          $rootScope.$broadcast "flash:info", growl_str
#        if metaData[_messageName] is "notice"
#          growl_str = metaData[_messageName].notice
#          $rootScope.$broadcast "flash:notice", growl_str
#      result
#
#    Resource.intercept "responseError", (rejection) ->
#      if rejection.data and rejection.data.meta
#        growl_str = ""
#        if rejection.data.meta.error and rejection.data.meta.error.messages
#          growl_str += _render_messages_array(rejection.data.meta.error.messages)  if rejection.data.meta.error.messages
#          $rootScope.$broadcast "flash:error", growl_str
#      $q.reject rejection
#
#    return
#
#  RailsResourceFlashMixin
