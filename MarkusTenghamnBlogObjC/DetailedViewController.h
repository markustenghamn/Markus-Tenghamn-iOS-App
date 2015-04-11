//
//  DetailedViewController.h
//  Markus Tenghamn
//
//  Created by Markus Tenghamn on 17/02/15.
//  Copyright (c) 2015 Markus Tenghamn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>
#import <GooglePlus/GooglePlus.h>
#import <GoogleOpenSource/GoogleOpenSource.h>
#import "AAShareBubbles.h"

@interface DetailedViewController : UIViewController <UIWebViewDelegate,AAShareBubblesDelegate,MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate,GPPSignInDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *titleString;
@property (strong, nonatomic) NSString *imgUrl;
- (IBAction)backButtonPressed:(id)sender;
- (IBAction)sharePost:(id)sender;

@end
