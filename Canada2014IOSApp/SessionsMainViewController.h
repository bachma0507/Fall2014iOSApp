//  Created by Barry on 7/12/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sessions.h"
#import "SessionsViewController.h"
@class MBProgressHUD;

@interface SessionsMainViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>
{
    MBProgressHUD *HUD;
    
}

@property (nonatomic, strong) NSMutableArray * results;

@property (strong, nonatomic) NSArray *objects;

@property (strong, nonatomic) NSArray *dateArray;
@property (strong, nonatomic) NSMutableDictionary *tempDict;

@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

//-(void) retrieveData;

@end

