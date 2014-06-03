'use strict'

define ['backbone', 'marionette'], (Backbone, Marionette) ->

  class UserView extends Marionette.Layout
    template: '#main-user-template'
    regions:
      'data': "#user-data"
      'task': '#user-task'

  class UserDataView extends Marionette.ItemView
    template: '#main-user-data-template'
    model: new Backbone.Model
      objectId: "123679"
      name: 'takumibaba'
      hoge: 'fuga'
      are: 'kore'

    # behaviors:
    #   stickit:
    #     bidings:

  return {
    UserView: UserView
    UserDataView: UserDataView
  }
