OSDBb-hash
=========

A small library providing methods to calculate OSDb hash which is a protocol first introduced on the ​OpenSubtitles web site. 
The protocols main purpose is to eliminate the painful process of searching for subtitles on the web and make finding subtitles to your videos as fast and simple as possible.

## Installation

  npm install osdb-hash --save

## Usage

  var osdb = require('scapegoat'),
      file = "test/breakdance.avi";

  console.log('hash', osdb.compute(file));

## Tests
* make sure to first unrar test file test/dummy.rar 
  npm test

## Disclaimer

I made this module as a learning experience for node.js and is based on great work from various 
contributors at [http://trac.opensubtitles.org/projects/opensubtitles/wiki/HashSourceCodes](http://trac.opensubtitles.org/projects/opensubtitles/wiki/HashSourceCodes])
and [https://github.com/ka2er/node-opensubtitles-api](https://github.com/ka2er/node-opensubtitles-api)

## Contributing

In lieu of a formal style guide, take care to maintain the existing coding style.
Add unit tests for any new or changed functionality. Lint and test your code.

## Release History

* 0.1.0 Initial release
