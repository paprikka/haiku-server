player = (req, res)->
  res.render 'index'

setup = (app)->
  app.get '/', player

module.exports = setup