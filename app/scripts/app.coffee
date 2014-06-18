'use strict'

define [
  'sidebar'
  'model'
  'socketio'
  'linda'
  'backbone'
  'marionette'
], (Sidebar, Model, SocketIO, Linda, Backbone) ->
  App = new Backbone.Marionette.Application()

  App.addRegions
    header: '#header'
    sidebar: "#sidebar"
    main: '#main'
    login: '#login'

  # App.API = "http://localhost:9080"
  # App.API = "http://153.121.44.172:9080"
  App.API = "http://manager-api.babascript.org"

  App.addInitializer ->
    path = ""
    $.ajax
      type: "GET"
      url: "#{App.API}/api/session"
      xhrFields:
        withCredentials: true
    .done (res) =>
      console.log res
      username = res.username
      token = res.token
      sidebar = new Sidebar.Sidebar()
      App.sidebar.show sidebar

      groups = new Model.Groups()
      groups.url = "#{App.API}/api/groups/all"
      groupList = new Sidebar.GroupList
        collection: groups
      groups.fetch()

      users = new Model.Users()
      users.url = "#{App.API}/api/users/all"

      userList = new Sidebar.UserList
        collection: users
      users.fetch()
      sidebar.group.show groupList
      sidebar.user.show userList

      address = App.API + "/?token=#{token}"
      App.linda = new Linda().connect SocketIO.connect address
      App.linda.io.on 'connect', ->
        console.log "connect?"


      link = (e) ->
        next = $(e.currentTarget).attr 'href'
        return if !next?
        e.preventDefault()
        App.router.navigate next, trigger: true
        return false
      $("a").on "click", link
      $("li").on "click", link
    .error (error) =>
      console.log 'error'
      console.log error
      path = "login"
    .always =>
      console.log path
      Backbone.history.start()
      App.router.navigate path, trigger: true if path isnt ""

  return App
