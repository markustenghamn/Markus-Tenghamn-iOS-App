//
//  AboutMeViewController.m
//  Markus Tenghamn
//
//  Created by Markus Tenghamn on 12/03/15.
//  Copyright (c) 2015 Markus Tenghamn. All rights reserved.
//

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#import "AboutMeViewController.h"

@interface AboutMeViewController ()

@end

@implementation AboutMeViewController

- (void)viewDidLoad {
    //[[FLEXManager sharedManager] showExplorer];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(facebookButtonPress)];
    [self.facebookButton addGestureRecognizer:tap];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(twitterButtonPress)];
    [self.twitterButton addGestureRecognizer:tap2];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(linkedinButtonPress)];
    [self.linkedinButton addGestureRecognizer:tap3];
}

- (void)viewDidAppear:(BOOL)animated {
    
    if (IS_IPHONE_4_OR_LESS) {
        CGSize tmpSize = self.scrollView.contentSize;
        tmpSize = CGSizeMake(tmpSize.width, tmpSize.height+500);
        self.scrollView.contentSize = tmpSize;
    } else {
        CGSize tmpSize = self.scrollView.contentSize;
        tmpSize = CGSizeMake(tmpSize.width, tmpSize.height+500);
        self.scrollView.contentSize = tmpSize;
    }
    self.scrollView.scrollEnabled = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) facebookButtonPress {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://www.facebook.com/MarkusTenghamn"]];
}

- (void) twitterButtonPress {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://twitter.com/MarkusTenghamn"]];
}

- (void) linkedinButtonPress {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://www.linkedin.com/in/markustenghamn"]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)menuPress:(id)sender {
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.revealViewController revealToggle:self];
    }
}
@end
