testPAge = (req, res)->
  res.render 'test'

setup = (app)->
  app.get '/test', testPAge

module.exports = setup