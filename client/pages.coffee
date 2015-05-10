Router.route '/',
   template: 'home'
   waitOn: -> Meteor.subscribe "pages"
   data: ->
      pages: Pages.find()

Router.route '/page/:_id',
   name: 'page'
   template: 'page'
   waitOn: -> Meteor.subscribe "pages", {_id:this.params._id}
   data: -> Pages.findOne this.params._id

Router.route '/edit/page/:_id?',
   name: 'editPage'
   template: 'editPage'
   onStop: -> Session.set "preview", undefined
   waitOn: ->
      if this.params._id
         Meteor.subscribe "pages", {_id:this.params._id}
   data: -> Pages.findOne this.params._id

Template.editPage.events
   'click #save': (event,template)->
      page =
         _id: this._id
         title: $('#title').val()
         text: $('#text').val()
      Meteor.call 'editPage', page, (error,_id)->
         Router.go "page", {_id:_id} unless error
         console.log error if error
   'keyup #text': ->
      Session.set "preview", $('#text').val()

Template.preview.helpers
   'preview': -> Session.get "preview"
