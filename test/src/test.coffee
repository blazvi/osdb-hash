should = require("chai").should()
osdb = require "#{process.cwd()}/lib/osdb-hash"

describe "#compute", ->
    it "should return an OSDb hash of the video file", ->
        osdb.compute(process.cwd() + "/test/breakdance.avi").should.equal "8e245d9679d31e12"
