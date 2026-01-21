var express = require('express')
var app = express()

const PORT = process.env.PORT || 3000

app.use(express.static(__dirname + '/public'))

app.get('/', function(request, response) {
  response.send('Hello World!')
})

app.listen(PORT, '0.0.0.0', function() {
  console.log(`Node app is running at 0.0.0.0:${PORT}`)
})
