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
    main: './main'

require [
  'backbone'
  'marionette'
  'underscore'
  'controller'
  'router'
  'sidebar'
  'user'
], (Backbone, Marionette, _, Controller, Router, Sidebar, UserView) ->
  {UserView, UserDataView } = UserView
  App = new Marionette.Application()

  App.addInitializer ->
    App.addRegions
      header: '#header'
      sidebar: "#sidebar"
      main: '#main'
    router = new Router
      controller: new Controller

    sidebar = new Sidebar
      collection: new Backbone.Collection [
        {name: 'masuilab'}
        {name: 'ylab'}
        {name: "are lab"}
      ]
    App.sidebar.show sidebar

    userview = new UserView()
    App.main.show userview

    userview.data.show new UserDataView()

    $("a").on "click", (e) ->
      next = $(e.currentTarget).attr 'href'
      return if !next?
      e.preventDefault()
      router.navigate next, trigger: true
    Backbone.history.start pushState: yes

  App.start()
