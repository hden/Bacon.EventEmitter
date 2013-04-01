Bacon.EventEmitter
==================

Light weight Baconized EventEmitter

This document is written in Literate CoffeeScript

    'use strict'

## Dependency

It depends on

* EventEmitter
* Bacon

    events = require 'events'
    Bacon = require 'baconjs'
    EE = events.EventEmitter

Gracefully exit when requirements are not met.

    return unless EE and Bacon

## Initial setup

Save a reference to the global object (window in the browser, exports on the server).

    root = @

## Common methods

    common = {

Provide a cached event stream based on the given event

      asEventStream: (event) ->
        cache = @asEventStream
        cache[event] = Bacon.fromEventTarget(@, event) unless cache[event]?
        return cache[event]

Alias for `asEventStream`

      es: (event) ->
        @asEventStream(event)

Provide a event relay mechanism based on a internal Bus

      plug: (eventStream) ->
        {bus} = @plug
        unless bus?
          @plug.bus = new Bacon.Bus()
          {bus} = @plug
          bus.onValue (value) -> @emit 'value', value
          bus.onError (error) -> @emit 'error', error
        return bus.plug eventStream
    }

## Class definition

    class EventEmitter extends EE
      asEventStream: common.asEventStream
      es: common.es
      @wrap: (obj) ->
        obj.asEventStream = common.asEventStream
        obj.es = common.es

## Export

The top-level namespace. All public classes and modules will be attached to this.
Exported for both the browser and the server.

    if module?
      module.exports = EventEmitter
    else
      root.EventEmitter = EventEmitter

Current version of the library. Keep in sync with package.json

    EventEmitter.version = '0.0.1'
