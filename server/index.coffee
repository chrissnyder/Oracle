express = require 'express'
fs = require 'fs'
shortId = require 'shortId'
app = express()

{BinaryServer} = require 'binaryjs'
fs = require 'fs'

decodeBase64Image = (dataString) ->
  matches = dataString.match /^data:([A-Za-z-+\/]+);base64,(.+)$/
  response = {}

  if matches.length != 3 then return new Error('Invalid input string')

  response.type = matches[1];
  response.data = new Buffer(matches[2], 'base64');

  return response

server = BinaryServer port: 9000
server.on 'connection', (client) ->
  console.log 'client initiated a connection'

  setInterval ->
    console.log Object.keys(client.streams).length
  , 2000

  client.on 'stream', (stream, meta) ->
    console.log 'client initated a stream'

    id = shortId.generate()
    file = fs.createWriteStream "#{__dirname}/tmp/#{id}.png"

    stream.on 'error', (error) ->
      console.log error

    stream.on 'drain', ->
      console.log 'stream draining'
      file.end()

    stream.on 'close', ->
      console.log 'stream closed'

    stream.on 'end', ->
      console.log 'stream ended'

    stream.on 'resume', ->
      console.log 'stream resumed'

    stream.on 'pause', ->
      console.log 'stream paused'

    stream.on 'data', (data) ->
      console.log 'client sent data... saving'
      binaryData = decodeBase64Image data
      file.write binaryData.data

  client.on 'close', ->
    console.log 'connection closed'
