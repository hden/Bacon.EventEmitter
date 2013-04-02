Bacon.EventEmitter
==================

Light-weight Baconized EventEmitter

This document is written in Literate CoffeeScript

    'use strict'

## Install

You can download the latest [generated javascript](https://raw.github.com/hden/Bacon.EventEmitter/master/lib/EventEmitter.bundle.js).

..or you can use script tags to include this file directly from Github:

```
<script src="https://raw.github.com/hden/Bacon.EventEmitter/master/lib/EventEmitter.bundle.js"></script>
```

If you're using node.js, you can

```
npm install https://github.com/hden/Bacon.EventEmitter
```

## Dependency

It depends on

* EventEmitter
* Bacon

    EE = require('events').EventEmitter
    Bacon = require('baconjs')

Gracefully exit when requirements are not met.

    return unless EE and Bacon

## Initial setup

Save a reference to the global object (window in the browser, exports on the server).

    root = @

## Class definition

    class EventEmitter extends EE

Provide a cached event stream based on the given event

      asEventStream: (event) ->
        cached = @asEventStream
        cached[event] = Bacon.fromEventTarget(@, event) unless cached[event]?
        return cached[event]

Alias for `asEventStream`

      es: (event) ->
        @asEventStream(event)

Provide a event relay mechanism based on a internal Bus. Use the second parameter to map events.
Returns a function that can be used to unplug the same stream.

      plug: (eventStream, options = {onValue: 'value', onError: 'error', onEnd: false}) ->
        {bus} = @plug
        unless bus?
          @plug.bus = new Bacon.Bus()
          {bus} = @plug
          if options.onValue then bus.onValue (value) => @emit options.onValue, value
          if options.onError then bus.onError (error) => @emit options.onError, error
          if options.onEnd then bus.onEnd (end) => @emit options.onEnd, end
        return bus.plug eventStream

Baconize an existing EventEmitter instance

      @mixin: (obj) ->
        for key of EventEmitter::
          obj[key] = EventEmitter::[key] unless obj[key]?
        return obj

## Export

The top-level namespace. All public classes and modules will be attached to this.
Exported for both the browser and the server.

    if module?
      module.exports = EventEmitter
    else
      root.EventEmitter = EventEmitter

Current version of the library. Keep in sync with package.json

    EventEmitter.version = '0.0.2'

## Licence

    ###
    Bacon.EventEmitter: Light-weight Baconized EventEmitter
    Copyright(c) 2013 Hao-kang Den <haokang.den@gmail.com>
    MIT Licenced
    ###
