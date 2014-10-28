describe 'rails.extend', ->
  describe 'extensions', ->
    describe 'permission', ->
      Book = undefined
      book = undefined
      $httpBackend = undefined
      railsResourceFactory = undefined
      railsSerializer = undefined

      beforeEach module(
        'rails'
        'rails.extend'
      )

      beforeEach inject (_$httpBackend_, _railsResourceFactory_, _railsSerializer_) ->
        $httpBackend = _$httpBackend_
        railsResourceFactory = _railsResourceFactory_
        railsSerializer = _railsSerializer_
        Book = railsResourceFactory(
          url: "/books"
          name: "book"
          extensions: ["permission"]
        )

      afterEach ->
        $httpBackend.verifyNoOutstandingExpectation()
        $httpBackend.verifyNoOutstandingRequest()

      describe 'instance permissions', ->
        it 'should parsing permission', ->
          $httpBackend.expectGET('/books/1').respond(200, {
            book:
              id: 1
              permission:
                update: true
                destroy: false
            })
          Book.get(1).then (response) ->
            book = response
          $httpBackend.flush()
          expect(book.$can 'update').toBe true
          expect(book.$can 'destroy').toBe false
          expect(book.$can 'assign').toBe false

      describe 'collection permissions', ->
        it 'should parsing permissions', ->
          $httpBackend.expectGET('/books').respond(200, {
            books: [
              {
                id: 1
                permission:
                  update: true
                  destroy: false
              },
              {
                id: 2
                permission:
                  update: true
                  destroy: false
              }
            ]
          })
          Book.query().then (response) ->
            books = response
            book = books[0]

          $httpBackend.flush()

          expect(book.$can 'update').toBe true
          expect(book.$can 'destroy').toBe false
          expect(book.$can 'assign').toBe false

      describe 'batch permissions', ->
