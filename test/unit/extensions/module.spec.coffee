describe "rails.extend", ->
  describe 'extensions', ->
    describe "module", ->
      module = undefined

      beforeEach ->
        module = angular.module('rails.extend.extensions')

      it "should be registered", ->
        expect(module).toBeDefined()

      describe "Dependencies:", ->
        deps = undefined

        hasModule = (m)->
          deps.indexOf(m) >= 0

        beforeEach ->
          deps = module.value('appName').requires

        it "should have rails.extend.extensions.array as a dependency", ->
          expect(hasModule('rails.extend.extensions.array')).toBeTruthy()

        it "should have rails.extend.extensions.attribute as a dependency", ->
          expect(hasModule('rails.extend.extensions.attribute')).toBeTruthy()

        it "should have rails.extend.extensions.flash as a dependency", ->
          expect(hasModule('rails.extend.extensions.flash')).toBeTruthy()

        it "should have rails.extend.extensions.permission as a dependency", ->
          expect(hasModule('rails.extend.extensions.permission')).toBeTruthy()