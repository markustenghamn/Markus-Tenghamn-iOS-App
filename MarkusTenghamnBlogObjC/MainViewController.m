//
//  MainViewController.m
//  Markus Tenghamn
//
//  Created by Markus Tenghamn on 13/02/15.
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

#import "MainViewController.h"
#import "DetailedViewController.h"
#import "FLEXManager.h"
#import "SWRevealViewController.h"
#import "MenuViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }

    self.view.frame = CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_MAX_LENGTH);
    // Do any additional setup after loading the view.
    
    self.adBanner.delegate = self;
    self.adBanner.hidden = NO;

    self.firstPostTitle.adjustsFontSizeToFitWidth = YES;

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.allowsSelection = YES;


    [self.scrollView setFrame:CGRectMake(0.0f, 20.0f, SCREEN_WIDTH, SCREEN_HEIGHT-20.0f)];
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT + 246.0f); //246 340
    self.scrollView.delegate = self;

    //Change sizes
//
//    CGRect tmpAdFrame = self.adBanner.frame;
//    tmpAdFrame.size = CGSizeMake(SCREEN_WIDTH, tmpAdFrame.size.height);
//    [self.adBanner setFrame:tmpAdFrame];
//
//    CGRect tmpFirstImageFrame = self.firstPostImageView.frame;
//    tmpFirstImageFrame.size = CGSizeMake(SCREEN_WIDTH, tmpFirstImageFrame.size.height);
//    [self.firstPostImageView setFrame:tmpFirstImageFrame];

    //End Change sizes


    self.maData = [[NSMutableArray alloc] init];

    NSLog(@"Frame: %f,%f %f,%f", self.adBanner.frame.origin.x, self.adBanner.frame.origin.y, self.adBanner.frame.size.width, self.adBanner.frame.size.height);

    NSLog(@"Frame: %f,%f %f,%f", self.firstPostImageView.frame.origin.x, self.firstPostImageView.frame.origin.y, self.firstPostImageView.frame.size.width, self.firstPostImageView.frame.size.height);

    NSLog(@"Frame: %f,%f %f,%f", self.scrollView.frame.origin.x, self.scrollView.frame.origin.y, self.scrollView.frame.size.width, self.scrollView.frame.size.height);

    self.imageCache = [[NSCache alloc] init];

    if (IS_IPHONE_5) {
        _tableView.scrollEnabled = TRUE;
    } else {
        _tableView.scrollEnabled = TRUE;
    }

    //NSLog(@"Making request");
    [self makeRequest];
    
}

-(void)viewWillAppear:(BOOL)animated {

    NSLog(@"Frame: %f,%f %f,%f", self.adBanner.frame.origin.x, self.adBanner.frame.origin.y, self.adBanner.frame.size.width, self.adBanner.frame.size.height);

    NSLog(@"Frame: %f,%f %f,%f", self.firstPostImageView.frame.origin.x, self.firstPostImageView.frame.origin.y, self.firstPostImageView.frame.size.width, self.firstPostImageView.frame.size.height);
    
    NSLog(@"Frame: %f,%f %f,%f", self.scrollView.frame.origin.x, self.scrollView.frame.origin.y, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
}

-(void)scrollViewDidScroll: (UIScrollView*)scrollView
{
    float scrollViewHeight = scrollView.frame.size.height;
    float scrollContentSizeHeight = scrollView.contentSize.height;
    float scrollOffset = scrollView.contentOffset.y;

    if (scrollOffset == 0)
    {
        
    }
    else if ((scrollOffset + scrollViewHeight) >= (scrollContentSizeHeight-50))
    {
        _tableView.scrollEnabled = TRUE;
        NSLog(@"Scroll enabled");
    } else {
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(void)bannerViewDidLoadAd:(ADBannerView *)abanner {
    NSLog(@"Ad did load");
    if (self.adBanner.hidden) {
        NSLog(@"banner show");
        self.adBanner.hidden = NO;
        [UIView beginAnimations:@"animatedAdBannerOn" context:NULL];
        _adBanner.frame = CGRectOffset(_adBanner.frame, 0.0, 50.0);
        _tableView.frame = CGRectMake(_tableView.frame.origin.x, _tableView.frame.origin.y+50.0f, _tableView.frame.size.width, _tableView.frame.size.height-50.0f);
        [UIView commitAnimations];
    }
}

-(void)bannerView:(ADBannerView *)aBanner didFailToReceiveAdWithError:(NSError *)error {
    NSLog(@"Ad did not load");
    if (!self.adBanner.hidden) {
        NSLog(@"banner hide");
        [UIView beginAnimations:@"animatedAdBannerOn" context:NULL];
        _adBanner.frame = CGRectOffset(_adBanner.frame, 0.0, -50.0f);
        _tableView.frame = CGRectMake(_tableView.frame.origin.x, _tableView.frame.origin.y-50.0f, _tableView.frame.size.width, _tableView.frame.size.height+50.0f);
        [UIView commitAnimations];
        self.adBanner.hidden = YES;
    }
}

- (void) makeRequest
{
    //NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://markustenghamn.com/feed/json"]];
    __block NSString *string = nil;
    //UIImage *image2 = [UIImageJPEGRepresentation(image, 1.0) ];
    //CGDataProviderRef provider = CGImageGetDataProvider(image.CGImage);
    //NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *params;
    params = @{@"json" : @1};
    [manager POST:@"http://markustenghamn.com/feed/json" parameters:params constructingBodyWithBlock:^(id <AFMultipartFormData> formData) {

    }     success:^(AFHTTPRequestOperation *operation, id responseObject) {
        string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        //NSLog(@"Success: %@", string);
        SBJsonParser *jsonParser = [SBJsonParser new];
        NSDictionary *jsonData = (NSDictionary *) [jsonParser objectWithString:string error:nil];
        //NSLog(@"%@", jsonData);
        [self processRequest:jsonData];
    }     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);

    }];


}

-(NSString *) stringByStrippingHTML:(NSString *)s {
    NSRange r;
    while ((r = [s rangeOfString:@"\\[[^\\]]+\\]" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}

- (void) processRequest:(NSDictionary *)jsonData {

    bool first = true;
    for (NSDictionary *json in jsonData) {
        if (first) {
            first = false;
            _firstPostTitle.text = [self replaceHTMLCodes:json[@"title"]];
            _firstPostImgUrl = json[@"thumbnail"];
            NSLog(@"URL: %@", json[@"permalink"]);
            _firstPostUrl = json[@"permalink"];
            
            CGRect tmpFrame = _firstPostTitle.frame;
            NSString *tmpString = _firstPostTitle.text;
            
            CBAutoScrollLabel *newLabel = [[CBAutoScrollLabel alloc] init];
            newLabel.frame = tmpFrame;
            newLabel.text = tmpString;
            newLabel.textColor = [UIColor blackColor];
            newLabel.backgroundColor = [UIColor whiteColor];
            [_firstPostTitleView addSubview:newLabel];
            
            [_firstPostTitle removeFromSuperview];
            
            _firstPostDescription.text = [self replaceHTMLCodes:json[@"excerpt"]];
            UIImage *image = [_imageCache objectForKey:@"firstPost"];
            if (image == nil) {
                image = [self imageWithImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:json[@"thumbnail"]]]] scaledToSize:_firstPostImageView.frame.size];
                if (image != nil) {
                    [_imageCache setObject:image forKey:@"firstPost"];
                }
            }
            _firstPostImageView.image = image;
            _firstPostContent = [self stringByStrippingHTML:[self replaceHTMLCodes:json[@"content"]]];

            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(firstTapped:)];
            [_firstPostDescriptionView addGestureRecognizer:tap];
            UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(firstTapped:)];
            [_firstPostTitleView addGestureRecognizer:tap2];
            UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(firstTapped:)];
            _firstPostImageView.userInteractionEnabled = YES;
            [_firstPostImageView addGestureRecognizer:tap3];

        } else {
            Post *post = [[Post alloc] init];
            post.title = [[self stringByStrippingHTML:[self replaceHTMLCodes:json[@"title"]]] mutableCopy];
            post.theContent = [[self stringByStrippingHTML:[self replaceHTMLCodes:json[@"content"]]] mutableCopy];
            post.descriptionString = [[self replaceHTMLCodes:json[@"excerpt"]] mutableCopy];
            post.imageUrl = json[@"thumbnail"];
            post.theUrl = json[@"permalink"];
            post.theImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:post.imageUrl]]];
            [self.maData addObject:post];
        }
        NSLog(@"Post added");
    }
    [self.activityIndicator stopAnimating];
    [self.tableView reloadData];
}

- (void)parseData {
    NSLog(@"Data: %@", self.tmpInnerTagText);
}

//Tableview methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"cell count: %d", [self.maData count]);
    return [self.maData count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 190;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView registerNib:[UINib nibWithNibName:@"MainViewTableViewCell" bundle:nil] forCellReuseIdentifier:@"MainViewTableViewCell"];
    MainViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainViewTableViewCell"];
    if (!cell) {
        CGRect tmpFrame = cell.titleLabel.frame;
        cell = [[MainViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MainViewTableViewCell"];
        
            cell.scrollLabel = [[CBAutoScrollLabel alloc] init];
        
        cell.scrollLabel.frame = tmpFrame;
            cell.scrollLabel.textColor = [UIColor blackColor];
            cell.scrollLabel.backgroundColor = [UIColor whiteColor];
            [cell.contentView addSubview:cell.scrollLabel];
            
            [cell.titleLabel removeFromSuperview];
        
    }

    Post *post = self.maData[indexPath.row];
    
    NSLog(@"Title: %@", post.title);
    cell.titleLabel.text = post.title;
    cell.scrollLabel.text = post.title;
    
    cell.descriptionTextView.text = post.descriptionString;
    cell.theContent = post.theContent;
    cell.url = post.theUrl;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellTapped:)];
    [cell addGestureRecognizer:tap];

    UIImage *image = [_imageCache objectForKey:[@(indexPath.row) stringValue]];
    if (image == nil) {
        image = [self imageWithImage:post.theImage scaledToSize:cell.imageView.frame.size];
        [_imageCache setObject:image forKey:[@(indexPath.row) stringValue]];
    }
    cell.imageView.image = image;


    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

// Called before the user changes the selection. Return a new indexPath, or nil, to change the proposed selection.
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MainViewTableViewCell *cell = (MainViewTableViewCell *) [tableView cellForRowAtIndexPath:indexPath];
    if (cell.selectionStyle == UITableViewCellSelectionStyleNone) {
        return nil;
    }
    return indexPath;
}

-(NSString *) replaceHTMLCodes:(NSString *)text{
    if (text){
        NSString *tmpString=[NSString stringWithString:text];
        tmpString = [text copy];
        NSString *tmpText = @"";
        int locAmp = [tmpString rangeOfString:@"&"].location;
        NSString * Code = @"";
        int locComa;
        while (locAmp!=NSNotFound && locAmp!=-1) {
            tmpText = [tmpText stringByAppendingString:[tmpString substringToIndex:locAmp]];
            tmpString = [tmpString stringByReplacingCharactersInRange:NSMakeRange(0, locAmp) withString:@""];
            locComa = [tmpString rangeOfString:@";"].location;
            Code = [NSString stringWithString:[tmpString substringWithRange:NSMakeRange(0, locComa)]];
            Code = [Code stringByReplacingOccurrencesOfString:@"&" withString:@""];
            if ([Code characterAtIndex:0]=='#') {
                Code = [Code stringByReplacingOccurrencesOfString:@"#" withString:@""];
                tmpText = [tmpText stringByAppendingFormat:@"%C", [Code intValue]];
            } else {
                if ([Code compare:@"amp"]==NSOrderedSame) {
                    tmpText = [tmpText stringByAppendingString:@"&"];
                } else if ([Code compare:@"quot"]==NSOrderedSame) {
                    tmpText = [tmpText stringByAppendingString:@"\""];
                } else if ([Code compare:@"gt"]==NSOrderedSame) {
                    tmpText = [tmpText stringByAppendingString:@">"];
                } else if ([Code compare:@"lt"]==NSOrderedSame) {
                    tmpText = [tmpText stringByAppendingString:@"<"];
                } else if ([Code compare:@"laquo"]==NSOrderedSame) {
                    tmpText = [tmpText stringByAppendingString:@"«"];
                } else if ([Code compare:@"raquo"]==NSOrderedSame) {
                    tmpText = [tmpText stringByAppendingString:@"»"];
                } else if ([Code compare:@"8211"]==NSOrderedSame) {
                    tmpText = [tmpText stringByAppendingString:@"-"];
                }
            }
            tmpString = [tmpString stringByReplacingCharactersInRange:NSMakeRange(0, locComa+1) withString:@""];
            locAmp = [tmpString rangeOfString:@"&"].location;
        }
        tmpText = [tmpText  stringByAppendingString:tmpString];
        return tmpText;
    }
    else
        return text;
}

- (void) cellTapped:(UIGestureRecognizer*)recognizer {
    MainViewTableViewCell *cell = (MainViewTableViewCell*)recognizer.view;
    NSLog(@"cell tapped: %@", cell.titleLabel.text);
    //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Row Clicked!" message:@"You clicked on a row!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    //[alert show];
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    DetailedViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"DetailedViewController"];
    vc.titleString = cell.titleLabel.text;
    vc.url = cell.url;
    [self presentViewController:vc animated:YES completion:nil];
    vc.imageView.image = [self imageWithImage:cell.imageView.image scaledToSize:vc.imageView.frame.size];
    [vc.textView loadHTMLString:cell.theContent baseURL:[NSURL URLWithString:@"http://markustenghamn.com"]];
}

- (void) firstTapped:(UIGestureRecognizer*)recognizer {
    NSLog(@"First post tapped");
    //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Row Clicked!" message:@"You clicked on a row!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    //[alert show];
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    DetailedViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"DetailedViewController"];
    NSLog(@"URL: %@",_firstPostUrl);
    Post *tmpPost = _maData[0];
    vc.titleString = tmpPost.title;
    vc.url = _firstPostUrl;
    vc.imgUrl = _firstPostImgUrl;
    [self presentViewController:vc animated:YES completion:nil];
    vc.imageView.image = [self imageWithImage:_firstPostImageView.image scaledToSize:vc.imageView.frame.size];
    [vc.textView loadHTMLString:_firstPostContent baseURL:[NSURL URLWithString:@"http://markustenghamn.com"]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)menuButtonClick:(id)sender {
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.revealViewController revealToggle:self];
    }
}
@end
