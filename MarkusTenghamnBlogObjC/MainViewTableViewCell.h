//
//  MainViewTableViewCell.h
//  Markus Tenghamn
//
//  Created by Markus Tenghamn on 14/02/15.
//  Copyright (c) 2015 Markus Tenghamn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBAutoScrollLabel.h"

@interface MainViewTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (strong, atomic) NSString *theContent;
@property (strong, atomic) NSString *url;
@property (strong, atomic) NSString *imgUrl;
@property (strong, atomic) CBAutoScrollLabel *scrollLabel;

@end
