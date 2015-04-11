//
//  AboutMeViewController.h
//  Markus Tenghamn
//
//  Created by Markus Tenghamn on 12/03/15.
//  Copyright (c) 2015 Markus Tenghamn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "FLEXManager.h"

@interface AboutMeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *twitterButton;
@property (weak, nonatomic) IBOutlet UIImageView *linkedinButton;
@property (weak, nonatomic) IBOutlet UIImageView *facebookButton;
- (IBAction)menuPress:(id)sender;

@end
