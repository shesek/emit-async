{ EventEmtter } = require 'events'

iferr = (errfn, succfn) -> (err, a...) -> if err? then errfn err else succfn a...

async = (emitter, name, a..., cb) ->
  if num = (emitter.listeners name).length
    emitter.emit name, a..., iferr cb, -> do cb unless --num
  else cb()

async.install = (emitter=EventEmitter::) -> emitter.async = (a...) -> async this, a...

module.exports = async
