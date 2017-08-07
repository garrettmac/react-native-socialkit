/**
 * @providesModule react-native-socialkit
 */

var ReactNativeSocialKit = require('react-native').NativeModules.ReactNativeSocialKit;
console.log(" require('react-native').NativeModules: ",require('react-native').NativeModules);
module.exports = {
  TwitterDialog: function(params, callback) {
    if (!(params['link'] || params['text'])) {
      callback("missing_link_or_text");
    } else {
      return ReactNativeSocialKit.tweet(params, callback);
    }
  },
  FacebookDialog: function(params, callback) {
    if (!(params['link'] || params['text'])) {
      callback("missing_link_or_text");
    } else {
      return ReactNativeSocialKit.FacebookDialog(params, callback);
    }
  }
};
