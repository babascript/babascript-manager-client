express = require 'express'
port = process.env.PORT || 4000
app = express()
connect = require 'connect'

app.use(connect.static(require('path').resolve('.tmp')))
app.use(express.static(__dirname + '/app'))
app.listen(port)
