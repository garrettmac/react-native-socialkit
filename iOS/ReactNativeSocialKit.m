//
//  ReactNativeSocialKit.m
//  ReactNativeSocialKit
//
//  Created by Kim Døfler Sand Laursen on 25-04-15.
//  Copyright (c) 2015 Facebook. All rights reserved.
//

#import "ReactNativeSocialKit.h"
#import <React/RCTConvert.h>
#import <Social/Social.h>

@implementation ReactNativeSocialKit

// Expose this module to the React Native bridge
RCT_EXPORT_MODULE()

- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}
SLComposeViewController *composeCtl = [SLComposeViewController composeViewControllerForServiceType:serviceType];

- (BOOL)isContentValid {
    // Do validation of contentText and/or NSExtensionContext attachments here
    return YES;
}

- (void)didSelectPost {
    // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.

    // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
    [self.extensionContext completeRequestReturningItems:@[] completionHandler:nil];
}

- (NSArray *)configurationItems {
    // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
    return @[];
}
-(void)share:(NSString *)serviceType
     options:(NSDictionary *)options
    callback:(RCTResponseSenderBlock)callback
{
  if (![SLComposeViewController isAvailableForServiceType:serviceType]) {
    callback(@[@"not_available"]);
    return;
  }

  SLComposeViewController *composeCtl = [SLComposeViewController composeViewControllerForServiceType:serviceType];

  if ([options objectForKey:@"link"] && [options objectForKey:@"link"] != [NSNull null]) {
    NSString *link = [RCTConvert NSString:options[@"link"]];
    [composeCtl addURL:[NSURL URLWithString:link]];
  }

  if ([options objectForKey:@"image"] && [options objectForKey:@"image"] != [NSNull null]) {
    [composeCtl addImage: [UIImage imageNamed: options[@"image"]]];
  } else if ([options objectForKey:@"imagelink"] && [options objectForKey:@"imagelink"] != [NSNull null]) {
    NSString *imagelink = [RCTConvert NSString:options[@"imagelink"]];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imagelink]]];
    [composeCtl addImage:image];
  }

  if ([options objectForKey:@"text"] && [options objectForKey:@"text"] != [NSNull null]) {
    NSString *text = [RCTConvert NSString:options[@"text"]];
    [composeCtl setInitialText:text];
  }

  [composeCtl setCompletionHandler:^(SLComposeViewControllerResult result) {
    if (result == SLComposeViewControllerResultDone) {
      // Sent
      callback(@[@"success"]);
    }
    else if (result == SLComposeViewControllerResultCancelled){
      // Cancelled
      callback(@[@"cancelled"]);
    }
  }];

  UIViewController *ctrl = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
  [ctrl presentViewController:composeCtl animated:YES completion: nil];
}

RCT_EXPORT_METHOD(FacebookDialog:(NSDictionary *)options
                  callback: (RCTResponseSenderBlock)callback)
{
  [self share:SLServiceTypeFacebook options:options callback: callback];
}

RCT_EXPORT_METHOD(tweet:(NSDictionary *)options
                  callback: (RCTResponseSenderBlock)callback)
{
  [self share:SLServiceTypeTwitter options:options callback: callback];
}
RCT_EXPORT_METHOD(RedditDialog:(NSDictionary *)didSelectPost
                  callback: (RCTResponseSenderBlock)callback)
{
  [self share:SLServiceTypeTwitter didSelectPost:didSelectPost callback: callback];
}


@end
