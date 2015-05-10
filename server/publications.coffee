Meteor.publish "pages", (query={})-> Pages.find(query)

Meteor.methods
   'editPage': (page)->
      result = Pages.upsert page._id, page
      return result.insertedId or page._id
