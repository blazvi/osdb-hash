var should = require('chai').should(),
osdb = require('../index');

describe('#compute', function() {
    it('should return an OSDb hash of the video file', function() {
        osdb.compute(process.cwd()+'/test/breakdance.avi').should.equal('8e245d9679d31e12');
    });
});

