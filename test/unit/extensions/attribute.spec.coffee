describe 'rails.extend', ->
  describe 'extensions', ->
    describe 'attribute', ->
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
          extensions: ["attribute"]
        )

        book = new Book {
          id: 1, $key: '1234', name: 'The Winds of Winter', author: 'William Petra'
        }

      afterEach ->
        $httpBackend.verifyNoOutstandingExpectation()
        $httpBackend.verifyNoOutstandingRequest()

      describe 'updateOnly()', ->
        it "should update a attribute only given key", ->
          $httpBackend.expectPUT('/books/1', {book: {name: "The Winds of Winter"}}).respond(200)
          book.updateOnly('name')
          $httpBackend.flush()

        it "should update attributes with given keys", ->
          $httpBackend.expectPUT('/books/1', {book: {name: "The Winds of Winter", author: 'William Petra'}}).respond(200)
          book.updateOnly('name', 'author')
          $httpBackend.flush()

      describe '_extractedValue(arguments)', ->
        it 'should extracted with single key', ->
          expect(book.extractedValue(book, ['name'])).toEqual({ name: 'The Winds of Winter' })

        it 'should extracted with multiple key', ->
          expect(book.extractedValue(book, ['name',
                                      'author'])).toEqual({ name: 'The Winds of Winter', author: 'William Petra' })