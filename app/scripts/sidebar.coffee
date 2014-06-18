'use strict'

define ['app', 'backbone', 'marionette'], (App, Backbone, Marionette) ->

  class GroupElement extends Marionette.ItemView
    template: "#sidebar-group-element-template"
    tagName: 'li'

  class ListElement extends Marionette.ItemView
    template: "#sidebar-user-element-template"
    tagName: 'li'
    ui:
      "link": 'a'
    events:
      'click @ui.link': "link"
    link: (e) ->
      # e.stopPropagation()
      # e.preventDefault()

  class GroupList extends Marionette.CompositeView
    template: "#sidebar-group-list-template"
    itemView: GroupElement
    itemViewContainer: "ul.sidebar-group-list"
    ui:
      "newgroup": "button#newgroup"
      "newgroupname": "input#newgroupname"
    events:
      "click @ui.newgroup": 'newgroup'
    newgroup: ->
      App = require('app')
      name = @ui.newgroupname.val()
      console.log name
      console.log App
      $.ajax
        type: "POST"
        url: "#{App.API}/api/group/new"
        data:
          name: name
      .done (res) =>
        console.log res
        @ui.newgroupname.val ""
        App.router.navigate "group/#{res.groupname}", true
      .error (error) ->
        console.log error

  class UserList extends Marionette.CompositeView
    template: "#sidebar-user-list-template"
    itemView: ListElement
    itemViewContainer: "ul.sidebar-user-list"

  class Sidebar extends Marionette.Layout
    template: "#sidebar-template"
    regions:
      'group': '#sidebar-group-list-layout'
      'user': '#sidebar-user-list-layout'

  return {
      GroupElement: GroupElement
      ListElement: ListElement
      GroupList: GroupList
      UserList: UserList
      Sidebar: Sidebar
  }
