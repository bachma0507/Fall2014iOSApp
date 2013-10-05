//
//  Fall2013IOSAppAppDelegate.h
//  Fall2013IOSApp
//
//  Created by Barry on 5/16/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PushIOManager/PushIOManager.h>
#import <CoreData/CoreData.h>
#import "Crittercism.h"

//CODE FROM EXHIBITORS VIEW CONTROLLER
#import "exhibitors.h"
#import "Speakers.h"
#import "Sessions.h"
//

@class Reachability;



@interface Fall2013IOSAppAppDelegate : UIResponder <UIApplicationDelegate, PushIOManagerDelegate>
{
    Reachability *internetReach;
    UIImageView *splashView;
}
//CODE FROM EXHIBITORSVIEWCONTROLLER
@property (nonatomic, strong) NSMutableArray * json;
@property (nonatomic, strong) NSMutableArray * exhibitorsArray;
@property (nonatomic, strong) NSMutableArray * speakersArray;
@property (nonatomic, strong) NSMutableArray * sessionsArray;
@property (strong, nonatomic) NSArray *objects;
//

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;



- (void)startupAnimationDone:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
