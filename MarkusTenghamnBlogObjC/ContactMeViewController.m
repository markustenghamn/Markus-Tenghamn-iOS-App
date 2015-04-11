//
//  ContactMeViewController.m
//  Markus Tenghamn
//
//  Created by Markus Tenghamn on 12/03/15.
//  Copyright (c) 2015 Markus Tenghamn. All rights reserved.
//

#import "ContactMeViewController.h"

@interface ContactMeViewController ()

@end

@implementation ContactMeViewController

- (void)viewDidLoad {

    _textView.delegate = self;

    //set notification for when keyboard shows/hides
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

    //set notification for when a key is pressed.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector: @selector(keyPressed:)
                                                 name: UITextViewTextDidChangeNotification
                                               object: nil];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
            initWithTarget:self
                    action:@selector(dismissKeyboard)];

    [self.view addGestureRecognizer:tap];

    //turn off scrolling and set the font details.
    _textView.scrollEnabled = NO;
    _textView.font = [UIFont fontWithName:@"Helvetica" size:14];

    //To make the border look very close to a UITextField
    [_textView.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.2] CGColor]];
    [_textView.layer setBorderWidth:1.0];

//The rounded corner part, where you specify your view's corner radius:
    _textView.layer.cornerRadius = 5;
    _textView.clipsToBounds = YES;
    // Do any additional setup after loading the view.
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }

    [super viewDidLoad];
}

-(void) keyboardWillShow:(NSNotification *)note{
//    // get keyboard size and loction
//    CGRect keyboardBounds;
//    [[note.userInfo valueForKey:UIKeyboardBoundsUserInfoKey] getValue: &keyboardBounds];
//    
//    // get the height since this is the main value that we need.
//    NSInteger kbSizeH = keyboardBounds.size.height;
//    
//    // get a rect for the table/main frame
//    CGRect tableFrame = viewTable.frame;
//    tableFrame.size.height -= kbSizeH;
//    
//    // get a rect for the form frame
//    CGRect formFrame = viewForm.frame;
//    formFrame.origin.y -= kbSizeH;
//    
//    // animations settings
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationBeginsFromCurrentState:YES];
//    [UIView setAnimationDuration:0.3f];
//    
//    // set views with new info
//    viewTable.frame = tableFrame;
//    viewForm.frame = formFrame;
//    
//    // commit animations
//    [UIView commitAnimations];
}

-(void) keyboardWillHide:(NSNotification *)note{
//    // get keyboard size and loction
//
//    CGRect keyboardBounds;
//    [[note.userInfo valueForKey:UIKeyboardBoundsUserInfoKey] getValue: &keyboardBounds];
//
//    // get the height since this is the main value that we need.
//    NSInteger kbSizeH = keyboardBounds.size.height;
//
//    // get a rect for the table/main frame
//    CGRect tableFrame = viewTable.frame;
//    tableFrame.size.height += kbSizeH;
//
//    // get a rect for the form frame
//    CGRect formFrame = viewForm.frame;
//    formFrame.origin.y += kbSizeH;
//
//    // animations settings
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationBeginsFromCurrentState:YES];
//    [UIView setAnimationDuration:0.3f];
//
//    // set views with new info
//    viewTable.frame = tableFrame;
//    viewForm.frame = formFrame;
//
//    // commit animations
//    [UIView commitAnimations];
}

- (void)keyPressed:(id)sender {
    //Do nothing
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textViewDidBeginEditing:(UITextView *)textView {
    CGRect tmpFrame = self.view.frame;
    tmpFrame.origin = CGPointMake(tmpFrame.origin.x, tmpFrame.origin.y-200);
    self.view.frame = tmpFrame;
}

-(void)textViewDidEndEditing:(UITextView *)textView {
    CGRect tmpFrame = self.view.frame;
    tmpFrame.origin = CGPointMake(tmpFrame.origin.x, tmpFrame.origin.y+200);
    self.view.frame = tmpFrame;
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

- (IBAction)sendPress:(id)sender {
    bool errors = false;
    if (_nameField.text.length <= 2) {
        errors = true;
    }
    if (_emailField.text.length <= 2) {
        errors = true;
    }
    if (_textView.text.length <= 2) {
        errors = true;
    }

    if (!errors) {
        NSString *post = [NSString stringWithFormat:@"_wpcf7=324&_wpcf7_version=4.1&_wpcf7_locale=&_wpcf7_unit_tag=wpcf7-f324-p325-o1&_wpnonce=27cb07b6b8&your-name=%@&your-email=%@&your-message=%@&_wpcf7_is_ajax_call=1", _nameField.text, _emailField.text, _textView.text];
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:@"http://markustenghamn.com/contact"]];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        if (conn) {
            NSLog(@"Connection Successful");
        } else {
            NSLog(@"Connection could not be made");
        }
        _thankyouMessage.hidden = NO;
        _textView.hidden = YES;
        _nameField.hidden = YES;
        _emailField.hidden = YES;
        _nameLabel.hidden = YES;
        _emailLabel.hidden = YES;
        _messageLabel.hidden = YES;
        _sendButton.hidden = YES;
        [_emailField resignFirstResponder];
        [_nameField resignFirstResponder];
        [_textView resignFirstResponder];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not send"
                                                        message:@"Please make sure you include a name, email and a message."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)nameEditBegin:(id)sender {
    CGRect tmpFrame = self.view.frame;
    tmpFrame.origin = CGPointMake(tmpFrame.origin.x, tmpFrame.origin.y-50);
    self.view.frame = tmpFrame;
}

- (IBAction)nameEditEnd:(id)sender {
    CGRect tmpFrame = self.view.frame;
    tmpFrame.origin = CGPointMake(tmpFrame.origin.x, tmpFrame.origin.y+50);
    self.view.frame = tmpFrame;
}

- (IBAction)emailEditBegin:(id)sender {
    CGRect tmpFrame = self.view.frame;
    tmpFrame.origin = CGPointMake(tmpFrame.origin.x, tmpFrame.origin.y-100);
    self.view.frame = tmpFrame;
}

- (IBAction)emailEditEnd:(id)sender {
    CGRect tmpFrame = self.view.frame;
    tmpFrame.origin = CGPointMake(tmpFrame.origin.x, tmpFrame.origin.y+100);
    self.view.frame = tmpFrame;
}

-(void)dismissKeyboard {
    [_emailField resignFirstResponder];
    [_nameField resignFirstResponder];
    [_textView resignFirstResponder];
}

@end
