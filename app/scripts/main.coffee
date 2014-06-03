#/*global require*/
'use strict'

require.config
  shim:
    bootstrap:
      deps: ['jquery'],
      exports: 'jquery'
    marionette:
      deps: ['jquery', 'underscore', 'backbone']
      exports: 'Marionette'
  paths:
    jquery: '../bower_components/jquery/dist/jquery'
    backbone: '../bower_components/backbone/backbone'
    marionette: '../bower_components/marionette/lib/backbone.marionette'
    underscore: '../bower_components/underscore/underscore'
    bootstrap: '../bower_components/sass-bootstrap/dist/js/bootstrap'
    controller: './controller'
    router: './router'
    sidebar: './sidebar'
    user: './user'
    app: './app'

require [
  'app'
  'backbone'
  'router'
  'controller'
], (App, Backbone, Router, Controller) ->

  App.start()

  router = new Router
    controller: new Controller
  App.router = router

  Backbone.history.start()
