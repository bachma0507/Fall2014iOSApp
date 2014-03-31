//
//  Fall2013IOSAppAppDelegate.h
//  Fall2013IOSApp
//
//  Created by Barry on 5/16/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <PushIOManager/PushIOManager.h>
#import <CoreData/CoreData.h>
#import "Crittercism.h"
#import "exhibitors.h"
#import "Speakers.h"
#import "Sessions.h"
#import "Sponsors.h"
#import "CSchedule.h"
#import "EHSchedule.h"
#import "Html.h"
//

@class MBProgressHUD;
@class Reachability;



@interface Fall2013IOSAppAppDelegate : UIResponder <UIApplicationDelegate>
{
    Reachability *internetReach;
    UIImageView *splashView;
    MBProgressHUD *HUD;
}

@property (nonatomic, strong) NSMutableArray * json;
@property (nonatomic, strong) NSMutableArray * exhibitorsArray;
@property (nonatomic, strong) NSMutableArray * speakersArray;
@property (nonatomic, strong) NSMutableArray * sessionsArray;
@property (nonatomic, strong) NSMutableArray * sponsorsArray;
@property (nonatomic, strong) NSMutableArray * cscheduleArray;
@property (nonatomic, strong) NSMutableArray * exhibitHallArray;
@property (nonatomic, strong) NSMutableArray * htmlArray;
@property (strong, nonatomic) NSArray *objects;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)startupAnimationDone:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
-(void)updateAllData;

@end
