testPAge = (req, res)->
  res.render 'test'



webSocketsConsole = (req, res) ->
  res.render 'console'
  # ...



setup = (app)->
  app.get '/test', testPAge
  app.get '/console', webSocketsConsole

module.exports = setup