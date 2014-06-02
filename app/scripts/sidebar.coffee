'use strict'

define ['backbone', 'marionette'], (Backbone, Marionette) ->

  class SidebarGroupElement extends Marionette.ItemView
    template: "#sidebar-group-element-template"
    tagName: 'li'

  class Sidebar extends Marionette.CompositeView
    template: "#sidebar-template"
    itemView: SidebarGroupElement
    itemViewContainer: "ul.sidebar-group-list"

  return Sidebar
