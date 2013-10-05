//
//  ListViewController.h
//  Fall2013IOSApp
//
//  Created by Barry on 5/30/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class SMClient;
@class SMCoreDataStore;

@interface ListViewController : UITableViewController



@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSArray *objects;


@property (strong, nonatomic) SMCoreDataStore *coreDataStore;
@property (strong, nonatomic) SMClient *client;


- (IBAction)buttonPressed:(id)sender;

@end
