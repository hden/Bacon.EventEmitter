{spawn, exec} = require 'child_process'

task 'build', 'build the js file for node', (options) ->
  exec 'node_modules/.bin/coffee --compile --output lib/ src/', (err, stdout, stderr) ->
    console.log 'generated lib/EventEmitter.js' unless err?

task 'build:readme', 'build the README.md file from source', (options) ->
  exec 'cp src/EventEmitter.litcoffee ./README.md', (err, stdout, stderr) ->
    console.log 'generated README.md' unless err?

task 'build:browserify', 'build the js file for browser', (options) ->
  exec 'node_modules/.bin/browserify lib/EventEmitter.js > lib/EventEmitter.bundle.js', (err, stdout, stderr) ->
    console.log 'generated lib/EventEmitter.bundle.js' unless err?
    console.log err if err?
