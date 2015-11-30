"user strict";

// module Hello.Global

exports.addNum = function (x, y) {
  return x + y;
};

exports.addNum2 = function (x) {
  return function (y) {
    return x + y;
  };
};
