/**
 * @providesModule react-native-socialkit
 */

var ReactNativeSocialKit = require('react-native').NativeModules.ReactNativeSocialKit;
var RNSocialKit = require('react-native').NativeModules.RNSocialKit;
console.log(" require('react-native').NativeModules: ",RNSocialKit);
module.exports = {
  TwitterDialog: function(params, callback) {
    if (!(params['link'] || params['text'])) {
      callback("missing_link_or_text");
    } else {
      return ReactNativeSocialKit.tweet(params, callback);
    }
  },
  RedditDialog: function(params, callback) {
    // if (!(params['link'] || params['text'])) {
    //   callback("missing_link_or_text");
    // } else {
      return ReactNativeSocialKit.RedditDialog(params, callback);
    // }
  },
  Module:function(params, callback) {
     return [RNSocialKit,ReactNativeSocialKit]
   },
  FacebookDialog: function(params, callback) {
    if (!(params['link'] || params['text'])) {
      callback("missing_link_or_text");
    } else {
      return ReactNativeSocialKit.FacebookDialog(params, callback);
    }
  }
};
