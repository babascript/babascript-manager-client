'use strict'


define ['backbone', 'marionette'], (backbone) ->
  class Router extends Backbone.Marionette.AppRouter
    appRoutes:
      '': 'hoge'
      'hoge': 'hoge'
      'fuga': 'fuga'

  return Router
