'use strict'

define ['main', 'backbone', 'marionette'], (Main, backbone, Marionette) ->
  class Controller extends Marionette.Controller
    hoge: ->
      console.log "hogehogeeee"

    fuga: ->
      console.log "fugaaaaaaaa"
  return Controller
