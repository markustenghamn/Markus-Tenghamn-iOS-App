//
//  ContactMeViewController.h
//  Markus Tenghamn
//
//  Created by Markus Tenghamn on 12/03/15.
//  Copyright (c) 2015 Markus Tenghamn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"

@interface ContactMeViewController : UIViewController <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UILabel *thankyouMessage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
- (IBAction)menuPress:(id)sender;
- (IBAction)sendPress:(id)sender;
- (IBAction)nameEditBegin:(id)sender;
- (IBAction)nameEditEnd:(id)sender;
- (IBAction)emailEditBegin:(id)sender;
- (IBAction)emailEditEnd:(id)sender;


@end
