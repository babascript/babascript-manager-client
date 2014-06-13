'use strict'
api = "http://localhost:3030/api"

define ['backbone', 'marionette'], (Backbone, Marionette) ->

  class User extends Backbone.Model
    urlRoot: "#{api}/user/"

  class Users extends Backbone.Collection

  class UserAttribute extends Backbone.Model

  class UserAttributes extends Backbone.Collection
    model: UserAttribute
    url: api
    initialize: (@name) ->
      @url += "/user/#{@name}/attributes"

  class Group extends Backbone.Model
    urlRoot: "#{api}/group/"

  class Groups extends Backbone.Collection

  class Member extends Backbone.Model

  class Members extends Backbone.Collection
    model: Member
    url: api
    initialize: (name) ->
      @url += "/group/#{name}/member"

  class Task extends Backbone.Model

  class Tasks extends Backbone.Collection
    url: api

    initialize: (attr)->
      id = attr.id
      type = attr.type
      @url += "/#{type}/#{id}/tasks"

  return {
    User: User
    Users: Users
    UserAttribute: UserAttribute
    UserAttributes: UserAttributes
    Member: Member
    Members: Members
    Group: Group
    Groups: Groups
    Task: Task
    Tasks: Tasks
  }
