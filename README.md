osdb-hash
=========

A small library providing methods to calculate OSDb hash which is a protocol first introduced on the ​OpenSubtitles web site. 
The protocols main purpose is to eliminate the painful process of searching for subtitles on the web and make finding subtitles to your videos as fast and simple as possible.

## Installation

```shell
npm install osdb-hash --save
```

## Testing

For running tests this two files have to be downloaded into test folder

```shell
cd test
wget http://www.opensubtitles.org/addons/avi/breakdance.avi
wget http://www.opensubtitles.org/addons/avi/dummy.rar
unrar e dummy.bin
cd ..
grunt test
```

## Usage

```javascript
var OSDbHash = require("osdb-hash"),
	file = "breakdance.avi",
  	osdb = new OSDbHash(file),
  	onNotify,
  	onCompute,
  	onComputeAsync,
  	onError;

onNotify = function (message) {
  	console.log(message);
};
  
onCompute = function (hash) {
  	console.log(hash);
};

onComputeAsync = function (err, hash) {
  	if (err) {
  		console.log(err);
  	} else {
  		console.log(hash);
  	}
};
  
onError = function(err) {
  	console.log(err);
};

// compute can be called using Promises/A+ 
osdb.compute(onNotify).then(onCompute).catch(onError);

// or asynchronously 
osdb.computeAsync(onComputeAsync, onNotify);
```
  

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
