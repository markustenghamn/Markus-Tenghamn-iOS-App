//
//  postObject.h
//  Markus Tenghamn
//
//  Created by Markus Tenghamn on 15/02/15.
//  Copyright (c) 2015 Markus Tenghamn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Post : NSObject

@property (strong, atomic) NSMutableString *title;
@property (strong, atomic) NSMutableString *descriptionString;
@property (strong, atomic) NSMutableString *theContent;
@property (strong, atomic) NSString *imageUrl;
@property (strong, atomic) NSString *theUrl;
@property (strong, atomic) UIImage *theImage;

@end
