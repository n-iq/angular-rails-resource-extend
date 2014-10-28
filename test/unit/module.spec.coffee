describe "rails.extend", ->
  describe "module", ->
    module = undefined

    beforeEach ->
      module = angular.module('rails.extend')

    it "should be registered", ->
      expect(module).toBeDefined()

    describe "Dependencies:", ->
      deps = undefined

      hasModule = (m)->
        deps.indexOf(m) >= 0

      beforeEach ->
        deps = module.value('appName').requires

      it "should have rails.extend.extensions as a dependency", ->
        expect(hasModule('rails.extend.extensions')).toBeTruthy()