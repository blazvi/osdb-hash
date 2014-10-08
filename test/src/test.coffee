chaiAsPromised = require "chai-as-promised"
should = require("chai").use(chaiAsPromised).should()

OSDbHash = require "#{process.cwd()}/lib/osdb-hash"

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
