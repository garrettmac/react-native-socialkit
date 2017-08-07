/**
 * @providesModule react-native-socialkit
 */

var ReactNativeSocialKit = require('react-native').NativeModules.ReactNativeSocialKit;

module.exports = {
  shareOnTwitter: function(params, callback) {
    if (!(params['link'] || params['text'])) {
      callback("missing_link_or_text");
    } else {
      return ReactNativeSocialKit.tweet(params, callback);
    }
  },
  shareOnFacebook: function(params, callback) {
    if (!(params['link'] || params['text'])) {
      callback("missing_link_or_text");
    } else {
      return ReactNativeSocialKit.shareOnFacebook(params, callback);
    }
  }
};
