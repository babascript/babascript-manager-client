'use strict'

define ['app', 'backbone', 'marionette'], (App, backbone) ->
  class Controller extends Backbone.Marionette.Controller
    top: ->
      console.log "top"

    user: (name)->
      console.log App

    group: (name)->
      console.log name

  return Controller
