//
//  AgendaTableViewController.h
//  Fall2013IOSApp
//
//  Created by Barry on 7/19/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AgendaCell.h"

@interface AgendaTableViewController : UITableViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) NSArray *objects;

@property (nonatomic, strong) NSString * sessionName;
@property (nonatomic, strong) NSString * sessionId;
@property (nonatomic, strong) NSString * location;


@end
