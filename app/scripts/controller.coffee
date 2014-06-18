'use strict'

define ['require', 'app', 'user', 'session', 'model', 'group', 'backbone', 'marionette'], (require, app, User, Session, Model, Group, Backbone) ->
  App = require 'app'
  class Controller extends Backbone.Marionette.Controller
    top: ->
      App.main.close()
      topview = new User.TopView()
      App.main.show topview

    user: (name)->

      App.main.close()
      userView = new User.UserLayout()
      App.main.show userView

      attributes = new Model.UserAttributes name
      tableLayout = new User.DataTableLayout
        collection: attributes
      userView.testdata.show tableLayout
      tableLayout.table.show new User.DataTable
        collection: attributes

      attributes.fetch({reset: true})

      tasks = new Model.Tasks
        id: name
        type: 'user'
      taskListView = new User.TaskListView
        collection: tasks
      # userView.task.show taskListView

      tasks.fetch({reset: true})

    group: (name)->
      App.main.close()
      groupView = new Group.GroupLayout()
      groupView.setName name
      App.main.show groupView

      members = new Model.Members name
      memberListLayout = new Group.MemberListLayout
        collection: members
      groupView.member.show memberListLayout
      memberListLayout.table.show new Group.MemberListTable
        collection: members
      members.fetch({reset: true})

      tasks = new Model.Tasks
        id: name
        type: 'group'
      taskListView = new User.TaskListView
        collection: tasks
      tasks.fetch({reset: true})

    login: ->
      App.main.close()
      loginView = new Session.LoginView()
      App.login.show loginView

  return Controller
