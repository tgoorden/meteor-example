debugThis = true

MochaWeb?.testOnly ->
   describe "Pages", ->
      describe "create", ->
         it "should enter data and see it in the collection", (done)->
            try
               Router.go "editPage"
            catch err
               done err
            Template.editPage.rendered = ->
               try
                  Template.page.rendered = ->
                     try
                        chai.expect($('#main').text()).to.contain rnd, "Has to contain #{rnd}"
                        done()
                     catch err
                        done err
                  rnd = Random.hexString 10
                  $('#title').val rnd
                  $('#text').val rnd
                  $('#save').click()
               catch err
                  done err
