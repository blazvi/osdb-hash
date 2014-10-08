"use strict"

whena = require "when"
callbacks = require('when/callbacks');
os = require "os"
fs = require "fs"
Long = require "long"

class OSDbHash
    HASH_CHUNK_SIZE: 64 * 1024
    BYTESIZE: 8
    READ_FUNC: if os.endianness? then "readUInt32#{os.endianness()}" else "readUInt32LE"


    constructor: (@filename) ->


    compute: (notify = ->) ->
        sum = Long.fromInt 0, true
        chunkSize = null
        fileSize = null

        @_getFileSize()
        .then((size)=>
            fileSize = size
            sum = sum.add Long.fromNumber(size, true)
            chunkSize = Math.min fileSize, @HASH_CHUNK_SIZE
        )
        .tap(->
            notify 0.25
        )
        .then(=>
            @_computeValueForChunk 0, chunkSize
        )
        .then((value)=>
            sum = sum.add value
        )
        .tap(->
            notify 0.5
        )
        .then(=>
            @_computeValueForChunk fileSize - chunkSize, fileSize
        )
        .then((value)=>
            sum = sum.add value
        )
        .tap(->
            notify 0.75
        )
        .then(=>
            sum.toString(16)
        )
        .tap(->
            notify 1
        )

    computeAsync: (callback, notify) ->
        @compute(notify)
        .then((value)=>
            callback? null, value
        )
        .catch((err)=>
            callback? err
        )
        return

    _computeValueForChunk: (start, end) ->
        defered = whena.defer()
        value   = Long.fromInt 0, true

        fs.open @filename, "r", (err, fd)=>
            if err
                defered.reject err
            else
                length = end - start
                fs.read fd, (new Buffer(length)), 0, length, start, (err, bytesRead, buffer)=>
                    if err
                        defered.reject err
                    else
                        for i in [0...buffer.length] by @BYTESIZE
                            low  = buffer[@READ_FUNC] i,   true
                            high = buffer[@READ_FUNC] i+4, true
                            n = Long.fromBits low, high, true
                            value = value.add n

                        fs.close fd
                        defered.resolve value

        defered.promise


    _getFileSize: =>

        onStat = (result) =>
            err = result[0]
            stats = result[1]

            if err
                throw err
            else
                return stats.size

        callbacks.call(fs.stat, @filename).then(onStat)


module.exports = OSDbHash
