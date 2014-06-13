'use strict'

define [
  'app'
  'model'
  'backgrid'
  'backbone'
  'marionette'
], (App, Model, Backgrid, Backbone, Marionette) ->
  class UserLayout extends Marionette.Layout
    template: '#main-user-template'
    regions:
      'data': "#user-data"
      'testdata': "#user-test-data"
      'task': '#user-task'

  # class DataRow extends Marionette.ItemView
  #   template: '#user-data-l-template'
  #   className: 'panel panel-default'
  #   modelEvents:
  #     "change": "modelChanged"
  #   ui:
  #     'addButton': 'button.add-property'
  #   events:
  #     'click @ui.addButton': 'addRow'
  #   addRow: ->
  #     console.log 'add row!'
  #   modelChanged: (user) =>
  #     App.main.currentView.data.show @
  #   render: ->
  #     @triggerMethod "before:render", @
  #     @triggerMethod "item:before:render", @
  #     data = @model.get "data"
  #     table =
  #       username: data.username
  #       groups: []
  #       attributes: {}
  #     for group in data.groups
  #       table.groups.push group.name
  #     for key, value of data.attribute
  #       table.attributes[key] = value
  #     template = @getTemplate()
  #     html = Marionette.Renderer.render template, table
  #     @.$el.html html
  #     @bindUIElements()
  #     @triggerMethod "render", @
  #     @triggerMethod "item:rendered", @
  #     return @

  class Task extends Marionette.ItemView
    template: '#user-task-template'
    className: ''
    tagName: 'tr'
    onBeforeRender: ->
      status = @model.get "status"
      if status is 'inprocess'
        @$el.addClass 'active'
      else if status is 'stock'
        @$el.addClass 'success'
      else if status is 'cancel'
        @$el.addClass 'danger'

  class TaskListView extends Marionette.CompositeView
    className: 'panel panel-default'
    template: '#user-task-list-template'
    itemView: Task
    itemViewContainer: '.task-lists'
    collectionEvents:
      'add': 'modelChanged'
      'reset': 'reset'
    reset: ->
      App.main.currentView.task.show @
    modelChanged: (model) ->

  class DataTableLayout extends Marionette.Layout
    template: '#user-table-panel-template'
    connection: {}
    regions:
      'table': '#user-test-data-table'
    ui:
      'addbutton': 'button.add-button'
      'addkey': 'input.add-key'
    events:
      'click @ui.addbutton': 'addRow'
    collectionEvents:
      'reset': 'reset'
      'backgrid:edited': 'edited'
    addRow: ->
      console.log 'add'
      key = @ui.addkey.val()
      return if key is ""
      model = new Model.UserAttribute()
      model.set 'key', key
      @table.currentView.collection.add model
      @ui.addkey.val ""
    reset: (collection)->
      if @connection.length > 0
        for key, value of @connection
          App.linda.tuplespace(key).cancel value
      username = collection.name
      t = {type: 'userdata'}
      connectionId = App.linda.tuplespace(username).watch t, @changeUserAttribute
      @connection[username] = connectionId
    changeUserAttribute: (err, result) =>
      return if err
      {key, value, username} = result.data
      flag = false
      @collection.each (model) =>
        k = model?.get 'key'
        if key is k
          flag = true
          return model.set 'value', value
      return if flag
      model = new Model.UserAttribute
        key: key
        value: value
      @collection.add model
    onClose: ->
      for key, value of @connection
        App.linda.tuplespace(key).cancel value
      @connection = {}
    modelChanged: (model) ->
      console.log model
    edited: (model) ->
      if model.hasChanged('value')
        key = model.get 'key'
        model.set 'id', key
        model.save()

  class RemoveCell extends Backgrid.Cell
    template: _.template($("#data-table-remove-template").html())
    events:
      'click span': 'deleteRow'
    deleteRow: ->
      key = @model.get 'key'
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

  class DataTable extends Backgrid.Grid
    columns: [
      {name: "remove", label: ' ', cell: RemoveCell}
      {name: "key", label: "key", cell: "", editable: false}
      {name: "value", label: "value", cell: ""}
    ]
    initialize: (args)->
      super
        columns: @columns
        collection: args.collection

  return {
    UserLayout: UserLayout
    # DataRow: DataRow
    Task: Task
    TaskListView: TaskListView
    DataTableLayout: DataTableLayout
    DataTable: DataTable
  }
