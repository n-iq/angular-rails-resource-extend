angular.module("rails.extend.extensions.permission")
.factory "RailsResourcePermissionMixin", (RailsResourceInjector, $railsExtendPermission) ->

  _permissionNode = $railsExtendPermission.getPermissionNode()

  RailsResourcePermissionMixin = ->

  $can = (action)->
    permissions = @[_permissionNode]
    (permissions? and permissions[action]) or false

  RailsResourcePermissionMixin.extended = (Resource) ->
    Resource.include
      $can: $can

  RailsResourcePermissionMixin
