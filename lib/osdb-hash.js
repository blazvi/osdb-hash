"use strict";
var Long, OSDbHash, callbacks, fs, os, whena,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

whena = require("when");

callbacks = require('when/callbacks');

os = require("os");

fs = require("fs");

Long = require("long");

OSDbHash = (function() {
  OSDbHash.prototype.HASH_CHUNK_SIZE = 64 * 1024;

  OSDbHash.prototype.BYTESIZE = 8;

  OSDbHash.prototype.READ_FUNC = os.endianness != null ? "readUInt32" + (os.endianness()) : "readUInt32LE";

  function OSDbHash(filename) {
    this.filename = filename;
    this._getFileSize = __bind(this._getFileSize, this);
  }

  OSDbHash.prototype.compute = function(notify) {
    var chunkSize, fileSize, sum;
    if (notify == null) {
      notify = function() {};
    }
    sum = Long.fromInt(0, true);
    chunkSize = null;
    fileSize = null;
    return this._getFileSize().then((function(_this) {
      return function(size) {
        fileSize = size;
        sum = sum.add(Long.fromNumber(size, true));
        return chunkSize = Math.min(fileSize, _this.HASH_CHUNK_SIZE);
      };
    })(this)).tap(function() {
      return notify(0.25);
    }).then((function(_this) {
      return function() {
        return _this._computeValueForChunk(0, chunkSize);
      };
    })(this)).then((function(_this) {
      return function(value) {
        return sum = sum.add(value);
      };
    })(this)).tap(function() {
      return notify(0.5);
    }).then((function(_this) {
      return function() {
        return _this._computeValueForChunk(fileSize - chunkSize, fileSize);
      };
    })(this)).then((function(_this) {
      return function(value) {
        return sum = sum.add(value);
      };
    })(this)).tap(function() {
      return notify(0.75);
    }).then((function(_this) {
      return function() {
        return sum.toString(16);
      };
    })(this)).tap(function() {
      return notify(1);
    });
  };

  OSDbHash.prototype.computeAsync = function(callback, notify) {
    this.compute(notify).then((function(_this) {
      return function(value) {
        return typeof callback === "function" ? callback(null, value) : void 0;
      };
    })(this))["catch"]((function(_this) {
      return function(err) {
        return typeof callback === "function" ? callback(err) : void 0;
      };
    })(this));
  };

  OSDbHash.prototype._computeValueForChunk = function(start, end) {
    var defered, value;
    defered = whena.defer();
    value = Long.fromInt(0, true);
    fs.open(this.filename, "r", (function(_this) {
      return function(err, fd) {
        var length;
        if (err) {
          return defered.reject(err);
        } else {
          length = end - start;
          return fs.read(fd, new Buffer(length), 0, length, start, function(err, bytesRead, buffer) {
            var high, i, low, n, _i, _ref, _ref1;
            if (err) {
              return defered.reject(err);
            } else {
              for (i = _i = 0, _ref = buffer.length, _ref1 = _this.BYTESIZE; _ref1 > 0 ? _i < _ref : _i > _ref; i = _i += _ref1) {
                low = buffer[_this.READ_FUNC](i, true);
                high = buffer[_this.READ_FUNC](i + 4, true);
                n = Long.fromBits(low, high, true);
                value = value.add(n);
              }
              fs.close(fd);
              return defered.resolve(value);
            }
          });
        }
      };
    })(this));
    return defered.promise;
  };

  OSDbHash.prototype._getFileSize = function() {
    var onStat;
    onStat = (function(_this) {
      return function(result) {
        var err, stats;
        err = result[0];
        stats = result[1];
        if (err) {
          throw err;
        } else {
          return stats.size;
        }
      };
    })(this);
    return callbacks.call(fs.stat, this.filename).then(onStat);
  };

  return OSDbHash;

})();

module.exports = OSDbHash;
