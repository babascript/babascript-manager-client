'use strict'

define [
  'app'
  'backgrid'
  'model'
  'backbone'
  'marionette'
], (App, Backgrid, Model, Backbone, Marionette) ->

  class LoginView extends Marionette.ItemView
    template: "#login-view-template"
    id: "login-modal"
    className: "modal"
    attributes:
      "tabindex": "-1"
      "role": "dialog"
      "aria-hidden": "true"
      "aria-describedby": "login-modal"
    onShow: ->
      $("#login-modal").modal('show')
      # console.log $(@el)
      # $(@el).modal()
    ui:
      'id': "#id-input"
      'pass': "#pass-input"
      'login': "#login-button"
      'signup': "#signup-button"
    events:
      "click @ui.login": "login"
      "click @ui.signup": "signup"
    login: (e) =>
      id = @ui.id.val()
      pass = @ui.pass.val()
      $.ajax
        type: "POST"
        url: "#{App.API}/api/session/login"
        xhrFields:
          withCredentials: true
        data:
          username: id
          password: pass
      .done (res) =>
        App.login.close()
        console.log res
        App.router.navigate "", true
      .error (err) =>
        console.log err
        window.alert "ログイン失敗"
      return false
    signup: (e) =>


  return {
    LoginView: LoginView
  }
