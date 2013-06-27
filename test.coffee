{ EventEmitter } = require 'events'
async = require './index.coffee'

{ equal: eq } = require 'assert'

describe 'emit-async', ->
  it 'waits for all callbacks to finish', (done) ->
    emitter = new EventEmitter
    emitter.on 'foo', (o, cb) -> o.count++; cb()
    emitter.on 'foo', (o, cb) -> process.nextTick -> o.count++; cb()
    async emitter, 'foo', (obj = count: 0), ->
      eq ++obj.count, 3
      done()
  it 'passes errors immediatly', (done) ->
    emitter = new EventEmitter
    emitter.on 'foo', (cb) -> cb 'error!'
    emitter.on 'foo', -> done new Error 'this should be called after the callback' unless called

    called = false
    async emitter, 'foo', (err) ->
      eq err, 'error!'
      called = true
      done()
