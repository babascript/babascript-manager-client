'use strict'


define ['controller', 'backbone', 'marionette'], (Controller, Backbone) ->
  class Router extends Backbone.Marionette.AppRouter
    appRoutes:
      '': 'top'
      'user/:name': 'user'
      'group/:name': 'group'
      'login': 'login'

  return Router
