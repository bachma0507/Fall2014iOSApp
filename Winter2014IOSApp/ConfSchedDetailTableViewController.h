//
//  ConfSchedDetailTableViewController.h
//  Fall2013IOSApp
//
//  Created by Barry on 8/30/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfSched.h"
#import "confSchedDetailViewCell.h"

@interface ConfSchedDetailTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *objects;

//@property (nonatomic, strong) NSMutableArray * results;

@property (nonatomic, strong) ConfSched * confsched;

@end
