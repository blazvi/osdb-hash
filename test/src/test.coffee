chaiAsPromised = require "chai-as-promised"
should = require("chai").use(chaiAsPromised).should()

OSDbHash = require "#{process.cwd()}/lib/osdb-hash"

describe "#compute", ->
    it "should eventually return an OSDb hash of the video file", ->
        file = process.cwd() + "/test/breakdance.avi"
        osdb = new OSDbHash file
        osdb.compute().should.eventually.equal "8e245d9679d31e12"
