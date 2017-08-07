//
//  RNSocialKitBridge.m
//  ReactNativeRedditExample
//
//  Created by vyga on 8/6/17.
//  Copyright © 2017 Facebook. All rights reserved.
//


// RNSocialKitBridge.m
#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(RNSocialKit, NSObject)

RCT_EXTERN_METHOD(addEvent:(NSString *)name location:(NSString *)location date:(nonnull NSNumber *)date)

@end
