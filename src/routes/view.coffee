
# handles rendering other views
module.exports = ( request, response ) ->
  response.render request.params?.id ? 'missing'
