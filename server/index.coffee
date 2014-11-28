express = require 'express'
shortId = require 'shortId'
app = express()

BinaryServer = require('binaryjs').BinaryServer
fs = require 'fs'

server = BinaryServer port: 9000
server.on 'connection', (client) ->
  id = shortId.generate()
  file = fs.createWriteStream "#{__dirname}/tmp/#{id}.mp4"

  client.on 'strean', (stream, meta) ->
    # client initialized a stream
    stream.pipe file

  client.on 'close', ->
    # client closed the connection
