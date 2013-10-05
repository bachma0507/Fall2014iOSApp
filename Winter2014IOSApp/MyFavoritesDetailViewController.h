//
//  MyFavoritesDetailViewController.h
//  Fall2013IOSApp
//
//  Created by Barry on 7/27/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExhibitorNotesViewController.h"
#import <CoreData/CoreData.h>

@interface MyFavoritesDetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *exhibitorNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *boothNumberLabel;

@property (nonatomic, strong) NSString * exhibitorName;
@property (nonatomic, strong) NSString * boothNumber;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSArray *objects;

@end
