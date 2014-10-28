'use strict'

angular.module 'rails.extend.extensions.permission'
.provider '$railsExtendPermission', ->
  # ----------------------------------------
  # providers
  # ----------------------------------------
  $injector = null

  # ----------------------------------------
  # properties
  # ----------------------------------------
  _permissionNode = 'permission'


  # ----------------------------------------
  # private functions
  # ----------------------------------------
  @setupProviders = (injector) ->
    $injector = injector

  # ----------------------------------------
  # public functions
  # ----------------------------------------
  @getPermissionNode = ->
    angular.copy(_permissionNode)

  @setPermissionNode = (node)->
    @permissionNode = node

  # ----------------------------------------
  # $get
  # ----------------------------------------
  @get = ($injector) ->
    @setupProviders $injector

    # public functions
    getPermissionNode: @getPermissionNode
    setPermissionNode: @setPermissionNode

  @get.$inject = ['$injector']
  @$get = @get
  return