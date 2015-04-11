//
//  MenuViewController.h
//  Markus Tenghamn
//
//  Created by Markus Tenghamn on 06/03/15.
//  Copyright (c) 2015 Markus Tenghamn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"

@interface MenuViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *menuItems;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
