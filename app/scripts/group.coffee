'use strict'

define [
  'app'
  'backgrid'
  'model'
  'backbone'
  'marionette'
], (App, Backgrid, Model, Backbone, Marionette) ->

  class GroupLayout extends Marionette.Layout
    initialize: ->
    template: "#main-group-template"
    regions:
      'member': '#group-member-layout'
      'task': '#group-task-layout'
    ui:
      "groupname": "#group-name"
      "groupdelete": "#group-delete-button"
    events:
      "click @ui.groupdelete": "delete"
    setName: (@name)->
    onShow: ->
      @ui.groupname.html @name
    delete: ->
      console.log "delete"
      $.ajax
        type: "DELETE"
        url: "#{App.API}/api/group/#{@name}/"
      .done (res) ->
        require("app").router.navigate "/", true
      .error (error) ->
        window.alert "group delete fail"

  class Member extends Marionette.ItemView
    template: '#group-member-template'
    tagName: 'tr'

  class MemberListView extends Marionette.CompositeView
    template: '#group-member-list-template'
    className: 'panel panel-default'
    itemView: Member
    itemViewContainer: '.group-member-rows'
    collectionEvents:
      'add': 'modelChanged'
    modelChanged: (model) ->
      App.main.currentView.member.show @

  class MemberListLayout extends Marionette.Layout
    template: '#group-member-list-layout-template'
    className: 'panel panel-primary'
    connection: {}
    regions:
      'table': '#group-member-table'
    ui:
      'addbutton': 'button.add-button'
      'adduser': 'input.add-user'
    events:
      'click @ui.addbutton': 'addRow'
    collectionEvents:
      'add': 'addMember'
      'reset': 'reset'
    addRow: ->
      model = new Model.Member()
      username = @ui.adduser.val()
      model.set 'username', username
      @table.currentView.collection.add model
      @ui.adduser.val ""
    addMember: (model)->
      model.save({}, {
        wait: true
        error: ->
          model.destroy()
        })
    reset: (collection)->
      if @connection.length > 0
        for key, value of @connection
          App.linda.tuplespace(key).cancel value
      collection.each (model) =>
        key = model?.get('members')
        t = {type: 'userdata', key: 'status'}
        connectionId = App.linda.tuplespace(key).read t, (err, result) =>
          return if err
          @onUserStatus err, result
          key = result.data.tuplespace
          @connection[key] = App.linda.tuplespace(key).watch t, @onUserStatus
        @connection[key] = connectionId

    onUserStatus: (err, result) =>
      return if err
      {key, value, tuplespace} = result.data
      for i in [0..@collection.length-1]
        model = @collection.at(i)
        username = model.get('username')
        if tuplespace is username
          model.set key, value

    onClose: ->
      for key, value of @connection
        App.linda.tuplespace(key).cancel value
      @connection = {}


  class RemoveCell extends Backgrid.Cell
    template: _.template($("#data-table-remove-template").html())
    events:
      'click span': 'deleteRow'
    deleteRow: ->
      console.log @model
      key = @model.get 'username'
      @model.set 'id', key
      @model.destroy()
    render: ->
      key = @model.get 'key'
      if key is 'username' or key is 'group'
        @$el.html ''
      else
        @$el.html this.template()
        @delegateEvents()
      @

  class CustomUriCell extends Backgrid.Cell
    initialize: (options) ->
      super options
      # @column.set 'name', options.title
      # @title = "/user/#{options.title}"


  class MemberListTable extends Backgrid.Grid
    columns: [
      {name: 'remove', label: ' ', cell: RemoveCell}
      {name: 'username', label: 'username', cell: CustomUriCell, editable: false}
      {name: 'status', label: 'status', cell: 'string', editable: false}
    ]
    initialize: (args) ->
      super
        columns: @columns
        collection: args.collection



  class Task extends Marionette.ItemView
    template: '#user-task-template'
    tagName: 'tr'

  class TaskListView extends Marionette.CompositeView
    itemView: Task
    className: 'panel panel-default'
    template: '#user-task-list-template'
    itemView: Task
    itemViewContainer: '.group-task-lists'
    collectionEvents:
      'add': 'modelChanged'
    modelChanged: (model) ->
      App.main.currentView.task.show @


  return {
    MemberListView: MemberListView
    Member: Member
    MemberListLayout: MemberListLayout
    MemberListTable: MemberListTable
    TaskListView: TaskListView
    Task: Task
    GroupLayout: GroupLayout
  }
