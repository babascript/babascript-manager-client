'use strict'

define [
  'router'
  'sidebar'
  'controller'
  'backbone'
  'marionette'
], (Router, Sidebar, Controller, Backbone) ->

  App = new Backbone.Marionette.Application()

  App.addRegions
    header: '#header'
    sidebar: "#sidebar"
    main: '#main'

  App.addInitializer ->

    sidebar = new Sidebar.Sidebar()
    App.sidebar.show sidebar

    groupList = new Sidebar.GroupList
      collection: new Backbone.Collection [
        {name: 'masuilab'}
        {name: 'ylab'}
        {name: "are lab"}
      ]
    userList = new Sidebar.UserList
      collection: new Backbone.Collection [
        {name: 'baba'}
        {name: 'yamada'}
        {name: "tanaka"}
      ]
    sidebar.group.show groupList
    sidebar.user.show userList

    $("a").on "click", (e) ->
      next = $(e.currentTarget).attr 'href'
      return if !next?
      e.preventDefault()
      App.router.navigate next, trigger: true

  return window.App = App
