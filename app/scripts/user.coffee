'use strict'

define ['backbone', 'marionette'], (Backbone, Marionette) ->

  class UserView extends Marionette.Layout
    template: '#main-user-template'
    regions:
      'data': "#user-data"
      'task': '#user-task'

  class UserDataView extends Marionette.ItemView
    template: '#main-user-data-template'

  return {
    UserView: UserView
    UserDataView: UserDataView
  }
