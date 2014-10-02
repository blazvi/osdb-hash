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

  npm test

## Contributing

In lieu of a formal styleguide, take care to maintain the existing coding style.
Add unit tests for any new or changed functionality. Lint and test your code.

## Release History

* 0.1.0 Initial release
