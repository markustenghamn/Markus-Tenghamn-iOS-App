//
//  MainViewController.h
//  Markus Tenghamn
//
//  Created by Markus Tenghamn on 13/02/15.
//  Copyright (c) 2015 Markus Tenghamn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "SBJson.h"
#import "MainViewTableViewCell.h"
#import "DetailedViewController.h"
#import "Post.h"
#import "AFNetworking/AFNetworking.h"
#import "AFXMLRequestOperation/AFXMLRequestOperation.h"
#import "AFURLResponseSerialization.h"
#import "TFHpple.h"
#import "CBAutoScrollLabel.h"

@interface MainViewController : UIViewController <NSXMLParserDelegate,ADBannerViewDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (strong, atomic) NSMutableString *tmpInnerTagText;
@property (weak, nonatomic) IBOutlet ADBannerView *adBanner;
@property (weak, nonatomic) IBOutlet UILabel *firstPostTitle;
@property (weak, nonatomic) IBOutlet UIView *firstPostTitleView;
@property (weak, nonatomic) IBOutlet UIImageView *firstPostImageView;
@property (weak, nonatomic) IBOutlet UITextView *firstPostDescription;
@property (weak, nonatomic) IBOutlet UIView *firstPostDescriptionView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, atomic) NSMutableArray *maData;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, atomic) NSCache *imageCache;
@property (strong, atomic) NSString *firstPostContent;
@property (strong, atomic) NSString *firstPostUrl;
@property (strong, atomic) NSString *firstPostImgUrl;
- (IBAction)menuButtonClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *sidebarbutton;

@end
