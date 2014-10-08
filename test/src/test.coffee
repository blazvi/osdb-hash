chaiAsPromised = require "chai-as-promised"
should = require("chai").use(chaiAsPromised).should()

OSDbHash = require "#{process.cwd()}/lib/osdb-hash"


describe "#file size", ->
    it "should get file size", ->
        file = process.cwd() + "/test/breakdance.avi"
        osdb = new OSDbHash file
        osdb._getFileSize().should.eventually.equal 12909756


describe "#compute video file", ->
    it "should eventually return an OSDb hash of the video file", ->
        file = process.cwd() + "/test/breakdance.avi"
        osdb = new OSDbHash file
        osdb.compute().should.eventually.equal "8e245d9679d31e12"


describe "#compute binary file", ->
    it "should eventually return an OSDb hash of the binary file", ->
        file = process.cwd() + "/test/dummy.bin"
        osdb = new OSDbHash file
        osdb.compute().should.eventually.equal "61f7751fc2a72bfb"


describe "#computeAsync video file async", ->
    it "should asynchronously return an OSDb hash of the video file", (done)->
        file = process.cwd() + "/test/breakdance.avi"
        osdb = new OSDbHash file

        onCompute = (err, hash) ->
            if err
                done err
            else
                hash.should.equal "8e245d9679d31e12"
                done()

        osdb.computeAsync onCompute


describe "#notify", ->
    it "should notify about hashing progress", (done)->
        file = process.cwd() + "/test/breakdance.avi"
        osdb = new OSDbHash file

        messages = []

        onNotify = (message)->
            if message
                messages.push message

        osdb.compute(onNotify)
        .then(()->
            messages.length.should.equal 4
            done()
        )
        .catch((err)->
            done err
        )


