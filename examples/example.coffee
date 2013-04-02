EventEmitter = require '../'
Bacon = require 'baconjs'
serverio = require('socket.io').listen(8000)

serverio.sockets.on 'connection', (socket) ->
  socket = EventEmitter.mixin socket
  socket.emit 'news', {hello: 'world'}
  socket.es('my other event').onValue (d) -> console.log 'server', d

clientsocket = require('socket.io-client').connect('http://localhost:8000')
clientsocket = EventEmitter.mixin clientsocket
clientsocket.es('news').onValue (d) ->
  console.log 'client', d
  clientsocket.emit 'my other event', { my: 'data' }

  bus = new Bacon.Bus()
  clientsocket.plug bus, {onValue: 'my other event'}
  bus.push {foo: 'bar'}
