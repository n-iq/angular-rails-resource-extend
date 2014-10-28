angular.module("rails.extend.extensions.attribute")
.factory "RailsResourceAttributeMixin", ->
  RailsResourceAttributeMixin = ->
    return

  ###*
  update the attributes only with given keys
  ###
  updateOnly = ->
    return if arguments.length < 1
    @constructor.$put(@$url(), extractedValue(this, arguments))

  ###*
  extracted the values into a new hash
  ###
  extractedValue = (obj, argArr)->
    hash = {}
    hash[arg] = obj[arg] for arg in argArr
    hash

  RailsResourceAttributeMixin.extended = (Resource) ->
    Resource.include
      updateOnly: updateOnly
      extractedValue: extractedValue

  RailsResourceAttributeMixin
