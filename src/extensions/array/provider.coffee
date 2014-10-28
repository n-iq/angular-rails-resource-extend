#'use strict'
#
#angular.module 'rails.extend.array'
#.provider '$railsExtendArray', ->
#  # ----------------------------------------
#  # providers
#  # ----------------------------------------
#  $injector = null
#
#
#  # ----------------------------------------
#  # properties
#  # ----------------------------------------
#  @nodeName = 'meta'
#  @countName = 'count'
#  @totalName = 'total'
#  @pageName = 'page'
#
#
#  # ----------------------------------------
#  # private functions
#  # ----------------------------------------
#  @setupProviders = (injector) ->
#    $injector = injector
#
#  # ----------------------------------------
#  # $get
#  # ----------------------------------------
#  @get = ($injector) ->
#    @setupProviders $injector
#
#    # properties
#    nodeName = @nodeName
#    countName = @countName
#    totalName = @totalName
#    pageName = @pageName
#
#  @get.$inject = ['$injector']
#  @$get = @get
#  return