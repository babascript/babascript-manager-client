'use strict'

define ['backbone', 'marionette'], (Backbone, Marionette) ->

  class MemberList extends Marionette.CompositeView
    itemView: Member

  class Member extends Marionettt.ItemView

  class TaskList extends Marionette.CompositeView
    itemView: Task

  class Task extends Marionette.ItemView

  class GroupView extends Marionette.Layout
    template: "#groupview-template"
    regions:
      'members': '#main-group-member-layout'
      'tasks': '#main-group-task-layout'
