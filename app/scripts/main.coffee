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
    underscore:
      deps: ['jquery']
      exports: '_'
    backgrid:
      deps: ['jquery', 'underscore', 'backbone']
      exports: 'Backgrid'
    linda:
      deps: ['jquery', 'underscore', 'socketio']
      exports: 'Linda'
  paths:
    jquery:     '../bower_components/jquery/dist/jquery'
    moment:     '../bower_components/moment/moment'
    backbone:   '../bower_components/backbone/backbone'
    underscore: '../bower_components/underscore/underscore'
    marionette: '../bower_components/marionette/lib/backbone.marionette'
    backgrid:   '../bower_components/backgrid/lib/backgrid'
    bootstrap:  '../bower_components/sass-bootstrap/dist/js/bootstrap'
    socketio:   '../bower_components/socket.io-client/dist/socket.io'
    linda:      './linda-socket.io'
    controller: './controller'
    router:     './router'
    sidebar:    './sidebar'
    user:       './user'
    session:    './session'
    model:      './models/model'
    app:        './app'
require [
  'router'
  'controller'
  'app'
  'backbone'
  'bootstrap'
  'moment'
], (Router, Controller, App, Backbone) ->
  App.start()
  App.router = new Router
    controller: new Controller
