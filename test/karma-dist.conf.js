// Karma configuration
// http://karma-runner.github.io/0.12/config/configuration-file.html
// Generated on 2014-06-10 using
// generator-karma 0.8.2

module.exports = function (config) {
    config.set({
        // enable / disable watching file and executing tests whenever any file changes
        autoWatch: true,

        // base path, that will be used to resolve files and exclude
        basePath: '../',

        // testing framework to use (jasmine/mocha/qunit/...)
        frameworks: ['jasmine'],

        // list of files / patterns to load in the browser
        files: [
            'bower_components/angular/angular.js',
            'bower_components/angular-mocks/angular-mocks.js',
            'bower_components/checklist-model/checklist-model.js',
            'bower_components/angular-ui-select/dist/select.js',
            'bower_components/textAngular/dist/textAngular.min.js',
            'bower_components/angular-sanitize/angular-sanitize.js',
            'bower_components/angular-elastic/elastic.js',
            'bower_components/angular-bootstrap/ui-bootstrap-tpls.js',
            'dist/angular-easy-form.min.js',
            'test/unit/**/*.coffee'
        ],

        // list of files / patterns to exclude
//        exclude: ['test/unit/lib/easy-form/**/*.coffee'],

        // web server port
        port: 8080,

        // Start these browsers, currently available:
        // - Chrome
        // - ChromeCanary
        // - Firefox
        // - Opera
        // - Safari (only Mac)
        // - PhantomJS
        // - IE (only Windows)
        browsers: [
            'PhantomJS'
        ],

        // Which plugins to enable
        plugins: [
            'karma-phantomjs-launcher',
            'karma-jasmine',
            'karma-coverage',
            'karma-ng-json2js-preprocessor',
            'karma-ng-html2js-preprocessor',
            'karma-ng-jade2js-preprocessor',
            'karma-coffee-preprocessor'
        ],

        // Continuous Integration mode
        // if true, it capture browsers, run tests and exit
        singleRun: true,

        colors: true,

        // level of logging
        // possible values: LOG_DISABLE || LOG_ERROR || LOG_WARN || LOG_INFO || LOG_DEBUG
        logLevel: config.LOG_INFO,

        // coverage reporter generates the coverage
        reporters: ['progress', 'coverage'],

        preprocessors: {
            // source files, that you wanna generate coverage for
            // do not include tests or libraries
            // (these files will be instrumented by Istanbul)
//            'app/scripts/**/*.coffee': ['coverage'],
            'api_mocks/**/*.json': ['json2js'],
            '**/**/*.coffee': ['coffee'],
            'app/views/**/*.jade': ['ng-jade2js']
        },

        // optionally, configure the reporter
        coverageReporter: {
            type: 'html',
            dir: 'coverage/'
        },

        ngHtml2JsPreprocessor: {
            stripPrefix: 'app/'
        },

        ngJson2JsPreprocessor: {
            // strip this from the file path
            stripPrefix: 'api_mocks/',
            // prepend this to the
            prependPrefix: 'mocked/'

        },

        coffeePreprocessor: {
            // options passed to the coffee compiler
            options: {
                bare: true,
                sourceMap: false
            },
            // transforming the filenames
            transformPath: function(path) {
                return path.replace(/\.coffee$/, '.js');
            }
        },


        ngJade2JsPreprocessor: {
            // strip this from the file path
            stripPrefix: 'app/',

            // or define a custom transform function
//            cacheIdFromPath: function(filepath) {
//                return cacheId;
//            },

            // By default, Jade files are added to template cache with '.html' extension.
            // Set this option to change it.
            templateExtension: 'html'

            // setting this option will create only a single module that contains templates
            // from all the files, so you can load them all with module('foo')
//            moduleName: 'foo'
        }

// Uncomment the following lines if you are using grunt's server to run the tests
        // proxies: {
        //   '/': 'http://localhost:9000/'
        // },
        // URL root prevent conflicts with the site root
        // urlRoot: '_karma_'
    });
};
