Meteor.startup ->
   if Pages.find().count() is 0
      console.log "Pages is empty, loading default data"
      pages = EJSON.parse Assets.getText 'pages.json'
      _.each pages, (page)->
         Pages.insert page
