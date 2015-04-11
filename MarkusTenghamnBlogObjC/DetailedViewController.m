//
//  DetailedViewController.m
//  Markus Tenghamn
//
//  Created by Markus Tenghamn on 17/02/15.
//  Copyright (c) 2015 Markus Tenghamn. All rights reserved.
//

#import "DetailedViewController.h"

@interface DetailedViewController ()

@end

@implementation DetailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if (inType == UIWebViewNavigationTypeLinkClicked) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }

    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sharePost:(id)sender {

    // Do any additional setup after loading the view.
    AAShareBubbles *shareBubbles = [[AAShareBubbles alloc] initWithPoint:CGPointMake(160, 250)
                                                                  radius:150
                                                                  inView:self.view];
    shareBubbles.delegate = self;
    shareBubbles.bubbleRadius = 40; // Default is 40
    shareBubbles.showFacebookBubble = YES;
    shareBubbles.showTwitterBubble = YES;
    shareBubbles.showMailBubble = YES;
    shareBubbles.showGooglePlusBubble = NO;
    shareBubbles.showTumblrBubble = NO;
    shareBubbles.showInstagramBubble = NO;
    shareBubbles.showLinkedInBubble = NO;
    shareBubbles.showRedditBubble = NO;
    shareBubbles.showWhatsappBubble = NO;


    [shareBubbles show];
}

- (void)aaShareBubbles:(AAShareBubbles *)shareBubbles tappedBubbleWithType:(AAShareBubbleType)bubbleType {
    switch (bubbleType) {
        case AAShareBubbleTypeFacebook: {
            NSLog(@"Facebook");
            if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
                SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
                NSLog(@"Title:%@ URL:%@", _titleString, _url);

                [controller setInitialText:[NSString stringWithFormat:@"%@ - Shared via the Markus Tenghamn App", _titleString]];
                [controller addURL:[NSURL URLWithString:_url]];
                [controller addImage:self.imageView.image];
                [self presentViewController:controller animated:YES completion:Nil];
            }
            break;
        }
        case AAShareBubbleTypeTwitter: {
            NSLog(@"Twitter");
            if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
                SLComposeViewController *tweetSheet = [SLComposeViewController
                        composeViewControllerForServiceType:SLServiceTypeTwitter];
                [tweetSheet setInitialText:_titleString];
                [tweetSheet addURL:[NSURL URLWithString:_url]];
                [tweetSheet addImage:self.imageView.image];
                [self presentViewController:tweetSheet animated:YES completion:nil];
            }
            break;
        }
        case AAShareBubbleTypeMail: {
            NSLog(@"Email");
            // Email Subject
            NSString *emailTitle = self.titleString;
            // Email Content
            NSString *messageBody = [NSString stringWithFormat:@"<p>I found an interesting blog post on the Markus Tenghamn App, check it out!</p>"
                                                                       "<br/><br/>"
                                                                       "<p><a href='%@'>%@</a></p>", self.url, self.titleString];

            MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
            mc.mailComposeDelegate = self;
            [mc setSubject:emailTitle];
            [mc setMessageBody:messageBody isHTML:YES];
            [mc addAttachmentData:UIImagePNGRepresentation(self.imageView.image) mimeType:@"image/png" fileName:@"mtblogpost.png"];

            // Present mail view controller on screen
            [self presentViewController:mc animated:YES completion:NULL];


            break;
        }
        case AAShareBubbleTypeGooglePlus: {
            GPPSignIn *signIn = [GPPSignIn sharedInstance];
            signIn.shouldFetchGooglePlusUser = YES;
            signIn.clientID = @"";
            signIn.scopes = @[ kGTLAuthScopePlusLogin ];
            signIn.delegate = self;
            [signIn authenticate];
            NSLog(@"Google+");
            NSURL *urlToShare = [NSURL URLWithString:_url];
            id <GPPShareBuilder> shareBuilder = [[GPPShare sharedInstance] nativeShareDialog];
            [shareBuilder setURLToShare:urlToShare];
            [shareBuilder setPrefillText:_titleString];
            //[shareBuilder addImage:self.imageView.image];
            [shareBuilder open];
            break;
        }
        case AAShareBubbleTypeTumblr: {
            NSLog(@"Tumblr");
            break;
        }
        case AAShareBubbleTypeLinkedIn: {
            NSLog(@"Linkedin");
//            if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
//                SLComposeViewController *linkedinSheet = [SLComposeViewController
//                        composeViewControllerForServiceType:SLServiceTypeLinkedIn];
//                [linkedinSheet setInitialText:_titleString];
//                [linkedinSheet addURL:[NSURL URLWithString:_url]];
//                [linkedinSheet addImage:self.imageView.image];
//                [self presentViewController:linkedinSheet animated:YES completion:nil];
//            }
            break;
        }
        case AAShareBubbleTypeInstagram: {
            NSLog(@"Instagram");
            break;
        }
        case AAShareBubbleTypeReddit: {
            NSLog(@"Reddit");
            break;
        }
        default: {
            break;
        }
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }

    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)aaShareBubblesDidHide:(AAShareBubbles *)bubbles {
    NSLog(@"All Bubbles hidden");
}

@end
