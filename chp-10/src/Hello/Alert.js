"use strict";

// module Hello.Alert

exports.alert = function (msg) {
  return function () {
    window.alert(msg);
    return {};
  };
};
