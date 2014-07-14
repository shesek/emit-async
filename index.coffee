{ EventEmtter } = require 'events'

iferr = (fail, succ) -> (err) -> if err? then fail err else do succ

emitAsync = (emitter, name, a..., cb) ->
  if num = (emitter.listeners name).length
    emitter.emit name, a..., iferr cb, -> do cb unless --num
  else cb()

emitAsync.install = (emitter=EventEmitter::) ->
  emitter.emitAsync = (a...) -> emitAsync this, a...

module.exports = emitAsync
