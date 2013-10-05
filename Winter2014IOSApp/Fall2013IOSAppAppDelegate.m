//
//  Fall2013IOSAppAppDelegate.m
//  Fall2013IOSApp
//
//  Created by Barry on 5/16/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "Fall2013IOSAppAppDelegate.h"
#import "Reachability.h"
#import "RNCachingURLProtocol.h"
#import "Fall2013IOSAppViewController.h"
#import <NewRelicAgent/NewRelicAgent.h>


@implementation Fall2013IOSAppAppDelegate

@synthesize managedObjectModel = _managedObjectModel;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize window;
@synthesize json, exhibitorsArray, speakersArray, sessionsArray;


NSMutableArray *clName;
int iNotificationCounter=0;

- (void)startupAnimationDone:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    [splashView removeFromSuperview];
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    
   
    [Crittercism enableWithAppID: @"521d4c964002055509000001"];
    
    
    //[NewRelicAgent startWithApplicationToken:@"AA3bb6bc7d36e6ee9f51258d954f6fb995f8eac2ce"];
    
    [NSURLProtocol registerClass:[RNCachingURLProtocol class]];
    
    clName = [[NSMutableArray alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];
    
    // Override point for customization after application launch.
    // Initial setup
    [[PushIOManager sharedInstance] setDelegate:self];
    [[PushIOManager sharedInstance] didFinishLaunchingWithOptions:launchOptions];
    
    // Requests a device token from Apple
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert     | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound];
    
   //[[UINavigationBar appearance]setShadowImage:[[UIImage alloc] init]];
    
    UIImage *navBackgroundImage = [UIImage imageNamed:@"navbarflatgrey.png"];
    [[UINavigationBar appearance] setBackgroundImage:navBackgroundImage forBarMetrics:UIBarMetricsDefault];

//    // Change the appearance of back button
//    UIImage *backButtonImage = [[UIImage imageNamed:@"backbutton.png"]
//                                resizableImageWithCapInsets:UIEdgeInsetsMake(0, 13, 0, 6)];
//    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    
//    
    UIImage* tabBarBackground = [UIImage imageNamed:@"tabbarflatgrey.png"];
    [[UITabBar appearance] setBackgroundImage:tabBarBackground];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor whiteColor], UITextAttributeTextColor,
                                                       nil] forState:UIControlStateNormal];
    UIColor *titleHighlightedColor = [UIColor /*whiteColor*/colorWithRed:247/255.0 green:185/255.0 blue:15/255.0 alpha:1.0];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       titleHighlightedColor, UITextAttributeTextColor,
                                                       nil] forState:UIControlStateHighlighted];
    
    
    
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithRed:247/255.0 green:185/255.0 blue:15/255.0 alpha:1.0], UITextAttributeTextColor,
                                                           [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8],UITextAttributeTextShadowColor,
                                                           [NSValue valueWithUIOffset:UIOffsetMake(0, 0)],UITextAttributeTextShadowOffset,
                                                           //[UIFont fontWithName:@"HelveticaNeue-CondensedBlack"
                                                           [UIFont fontWithName:@"Arial"size:21.0], UITextAttributeFont, nil]];
    
    
    // Assign tab bar item with titles
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UITabBar *tabBar = tabBarController.tabBar;
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
    UITabBarItem *tabBarItem4 = [tabBar.items objectAtIndex:3];
    //UITabBarItem *tabBarItem5 = [tabBar.items objectAtIndex:4];
    
    
//    tabBarItem1.title = @"Home";
//    tabBarItem2.title = @"News & Alerts";
//    tabBarItem3.title = @"Social";
//    tabBarItem4.title = @"My BICSI";
    //tabBarItem5.title = @"More";
    
    
    tabBarItem1.selectedImage = [[UIImage imageNamed:@"home_tab_icon_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem1.image = [[UIImage imageNamed:@"home_tab_icon_unselected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem1.title = @"Home";
    
    tabBarItem2.selectedImage = [[UIImage imageNamed:@"news_tab_icon_selected.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem2.image = [[UIImage imageNamed:@"news_tab_icon_unselected.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem2.title = @"News & Alerts";
    
    tabBarItem3.selectedImage = [[UIImage imageNamed:@"social_tab_icon_selected.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem3.image = [[UIImage imageNamed:@"social_tab_icon_unselected.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem3.title = @"Social";
    
    tabBarItem4.selectedImage = [[UIImage imageNamed:@"mybicsi_tab_icon_selected.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem4.image = [[UIImage imageNamed:@"mybicsi_tab_icon_unselected.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem4.title = @"My BICSI";
    
//    [tabBarItem1 setFinishedSelectedImage:[UIImage imageNamed:@"home_tab_icon_selected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"home_tab_icon_unselected.png"]];
//    [tabBarItem4 setFinishedSelectedImage:[UIImage imageNamed:@"mybicsi_tab_icon_selected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"mybicsi_tab_icon_unselected.png"]];
//    [tabBarItem2 setFinishedSelectedImage:[UIImage imageNamed:@"news_tab_icon_selected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"news_tab_icon_unselected.png"]];
//    [tabBarItem3 setFinishedSelectedImage:[UIImage imageNamed:@"social_tab_icon_selected.png"]withFinishedUnselectedImage:[UIImage imageNamed:@"social_tab_icon_unselected.png"]];
    //[tabBarItem5 setFinishedSelectedImage:[UIImage imageNamed:@"more_selected.png"]withFinishedUnselectedImage:[UIImage imageNamed:@"more_unselected.png"]];
    //maaj code 062313
    //NSTimer *time = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(refreshTable) userInfo:nil repeats:NO];

    //[window addSubview:viewController.view];
    [window makeKeyAndVisible];
    
    splashView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,window.frame.size.width,window.frame.size.height)];
    splashView.image = [UIImage imageNamed:@"Default"];
    [window addSubview:splashView];
    [window bringSubviewToFront:splashView];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:window cache:YES];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(startupAnimationDone:finished:context:)];
    splashView.alpha = 0.0;
    //splashView.frame = CGRectMake(-60, -85, 440, 635);
    [UIView commitAnimations];
    
    //CHECK TO SEE IF INTERNET CONNECTION IS AVAILABLE
    internetReach = [Reachability reachabilityForInternetConnection];
    [internetReach startNotifier];
    
    NetworkStatus netStatus = [internetReach currentReachabilityStatus];
    
    //If internet connection not available then do not delete objects
    if (netStatus == NotReachable) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"No internet connection. Data cannot be updated until a connection is made." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else{//START REACHABILITY ELSE
    //FETCH AND DELETE EXHIBITOR OBJECTS
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Exhibitors" inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    
    NSArray *myResults = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    self.objects = myResults;
    if (!myResults || !myResults.count){
        NSLog(@"No Exhibitor objects found to be deleted!");
    }
    else{
    for (NSManagedObject *managedObject in myResults) {
        [context deleteObject:managedObject];
        
        NSError *error = nil;
        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
        NSLog(@"Exhibitor object deleted!");
        
    }
    }
    //FETCH AND DELETE SPEAKER OBJECTS
        NSManagedObjectContext *contextSpeakers = [self managedObjectContext];
        
        NSFetchRequest *fetchRequestSpeakers = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entitySpeakers = [NSEntityDescription entityForName:@"Speakers" inManagedObjectContext:contextSpeakers];
        
        [fetchRequestSpeakers setEntity:entitySpeakers];
        
        NSArray *myResultsSpeakers = [self.managedObjectContext executeFetchRequest:fetchRequestSpeakers error:nil];
        self.objects = myResultsSpeakers;
        if (!myResultsSpeakers || !myResultsSpeakers.count){
            NSLog(@"No Speaker objects found to be deleted!");
        }
        else{
            for (NSManagedObject *managedObject in myResultsSpeakers) {
                [contextSpeakers deleteObject:managedObject];
                
                NSError *error = nil;
                // Save the object to persistent store
                if (![contextSpeakers save:&error]) {
                    NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                }
                NSLog(@"Speaker object deleted!");
                
            }
        }

    
    //---------------------------------
    
    //FETCH AND DELETE SESSION OBJECTS
        NSManagedObjectContext *contextSessions = [self managedObjectContext];
        
        NSFetchRequest *fetchRequestSessions = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entitySessions = [NSEntityDescription entityForName:@"Sessions" inManagedObjectContext:contextSessions];
        
        [fetchRequestSessions setEntity:entitySessions];
        
        NSArray *myResultsSessions = [self.managedObjectContext executeFetchRequest:fetchRequestSessions error:nil];
        self.objects = myResultsSessions;
        if (!myResultsSessions || !myResultsSessions.count){
            NSLog(@"No Session objects found to be deleted!");
        }
        else{
            for (NSManagedObject *managedObject in myResultsSessions) {
                [contextSessions deleteObject:managedObject];
                
                NSError *error = nil;
                // Save the object to persistent store
                if (![contextSessions save:&error]) {
                    NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                }
                NSLog(@"Session object deleted!");
                
            }
        }

    
    //---------------------------------
    
    //CREATE EXHIBITOR OBJECTS
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        
        NSURL *url = [NSURL URLWithString:@"http://speedyreference.com/exhibitorsW14.php"];
        NSData * data = [NSData dataWithContentsOfURL:url];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            
            //Set up our exhibitors array
            exhibitorsArray = [[NSMutableArray alloc] init];
            
            for (int i = 0; i < json.count; i++) {
                //create exhibitors object
                NSString * blabel = [[json objectAtIndex:i] objectForKey:@"BoothLabel"];
                NSString * bName = [[json objectAtIndex:i] objectForKey:@"Name"];
                NSString * bURL = [[json objectAtIndex:i] objectForKey:@"HyperLnkFldVal"];
                NSString * bboothId = [[json objectAtIndex:i] objectForKey:@"BoothID"];
                NSString * bmapId = [[json objectAtIndex:i] objectForKey:@"MapID"];
                NSString * bcoId = [[json objectAtIndex:i] objectForKey:@"CoID"];
                NSString * beventId = [[json objectAtIndex:i] objectForKey:@"EventID"];
                
                
                exhibitors * myExhibitors = [[exhibitors alloc] initWithBoothName: bName andboothLabel: blabel andBoothURL: bURL andMapId: bmapId andCoId:bcoId andEventId: beventId andBoothId: bboothId];
                
                
                //Add our exhibitors object to our exhibitorsArray
                [exhibitorsArray addObject:myExhibitors];
                
                NSManagedObjectContext *context = [self managedObjectContext];
                
                NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
                
                NSEntityDescription *entity = [NSEntityDescription entityForName:@"Exhibitors" inManagedObjectContext:context];
                
                [fetchRequest setEntity:entity];
                
                [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"name == %@ && boothLabel == %@",myExhibitors.name, myExhibitors.boothLabel]];
                
                NSArray *myResults = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
                
                self.objects = myResults;
                if (!myResults || !myResults.count){
                    
                    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Exhibitors" inManagedObjectContext:context];
                    
                    [newManagedObject setValue:myExhibitors.name forKey:@"name"];
                    
                    [newManagedObject setValue:myExhibitors.boothLabel forKey:@"boothLabel"];
                    NSString * myCoId = [[NSString alloc] initWithFormat:@"%@",myExhibitors.coId];
                    [newManagedObject setValue:myCoId forKey:@"coId"];
                    NSString * myMapId = [[NSString alloc] initWithFormat:@"%@",myExhibitors.mapId];
                    [newManagedObject setValue:myMapId forKey:@"mapId"];
                    NSString * myBoothId = [[NSString alloc] initWithFormat:@"%@",myExhibitors.boothId];
                    [newManagedObject setValue:myBoothId forKey:@"boothId"];
                    NSString * myEventId = [[NSString alloc] initWithFormat:@"%@",myExhibitors.eventId];
                    [newManagedObject setValue:myEventId forKey:@"eventId"];
                    
                    
                    
                    NSError *error = nil;
                    // Save the object to persistent store
                    if (![context save:&error]) {
                        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                    }
                    NSLog(@"You created a new Exhibitor object!");
                }
                
                
            }
            
            
            
        });
    });
    

    //CREATE SPEAKER OBJECTS
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
            
            NSURL *url = [NSURL URLWithString:@"http://speedyreference.com/speakersW14.php"];
            NSData * data = [NSData dataWithContentsOfURL:url];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                //Set up our speakers array
                speakersArray = [[NSMutableArray alloc] init];
                
                for (int i = 0; i < json.count; i++) {
                    //create speakers object
                    NSString * sID = [[json objectAtIndex:i] objectForKey:@"id"];
                    NSString * sCompany = [[json objectAtIndex:i] objectForKey:@"speakercompany"];
                    NSString * sName = [[json objectAtIndex:i] objectForKey:@"speakername"];
                    NSString * sCity = [[json objectAtIndex:i] objectForKey:@"speakercity"];
                    NSString * sState = [[json objectAtIndex:i] objectForKey:@"speakerstate"];
                    NSString * sCountry = [[json objectAtIndex:i] objectForKey:@"country"];
                    NSString * sBio = [[json objectAtIndex:i] objectForKey:@"speakerbio"];
                    NSString * sWebsite = [[json objectAtIndex:i] objectForKey:@"website"];
                    NSString * sPic = [[json objectAtIndex:i] objectForKey:@"speakerPic"];
                    NSString * sSession1 = [[json objectAtIndex:i] objectForKey:@"session1"];
                    NSString * sSession1Date = [[json objectAtIndex:i] objectForKey:@"session1Date"];
                    NSString * sSession1Time = [[json objectAtIndex:i] objectForKey:@"session1Time"];
                    NSString * sSession1Desc = [[json objectAtIndex:i] objectForKey:@"session1Desc"];
                    NSString * sSession2 = [[json objectAtIndex:i] objectForKey:@"session2"];
                    NSString * sSession2Date = [[json objectAtIndex:i] objectForKey:@"session2Date"];
                    NSString * sSession2Time = [[json objectAtIndex:i] objectForKey:@"session2Time"];
                    NSString * sSession2Desc = [[json objectAtIndex:i] objectForKey:@"session2Desc"];
                    NSString * sSessionID = [[json objectAtIndex:i] objectForKey:@"sessionID"];
                    NSString * sSessionID2 = [[json objectAtIndex:i] objectForKey:@"sessionID2"];
                    NSString * sStartTime = [[json objectAtIndex:i] objectForKey:@"startTime"];
                    NSString * sEndTime = [[json objectAtIndex:i] objectForKey:@"endTime"];
                    NSString * sLocation = [[json objectAtIndex:i] objectForKey:@"location"];
                    NSString * sSess2StartTime = [[json objectAtIndex:i] objectForKey:@"sess2StartTime"];
                    NSString * sSess2EndTime = [[json objectAtIndex:i] objectForKey:@"sess2EndTime"];
                    NSString * sLocation2 = [[json objectAtIndex:i] objectForKey:@"location2"];
                    
                    
                    Speakers * mySpeakers = [[Speakers alloc] initWithSpeakerID:sID andSpeakerName:sName andSpeakerCompany:sCompany andSpeakerCity:sCity andSpeakerState:sState andSpeakerCountry:sCountry andSpeakerBio:sBio andSpeakerWebsite: sWebsite andSpeakerPic:sPic andSession1:sSession1 andSession1Date:sSession1Date andSession1Time:sSession1Time andSession1Desc:sSession1Desc andSession2:sSession2 andSession2Date:sSession2Date andSession2Time:sSession2Time andSession2Desc:sSession2Desc andSessionID:sSessionID andSessionID2:sSessionID2 andStartTime: sStartTime andEndTime: sEndTime andLocation: sLocation andSess2StartTime: sSess2StartTime andSess2EndTime: sSess2EndTime andLocation2: sLocation2];
                    
                    //Add our speakers object to our speakersArray
                    [speakersArray addObject:mySpeakers];
                    
                    NSManagedObjectContext *context = [self managedObjectContext];
                    
                    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
                    
                    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Speakers" inManagedObjectContext:context];
                    
                    [fetchRequest setEntity:entity];
                    
                    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"speakerName == %@",mySpeakers.speakerName]];
                    
                    NSArray *myResults = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
                    
                    self.objects = myResults;
                    if (!myResults || !myResults.count){
                        
                        NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Speakers" inManagedObjectContext:context];
                        
                        [newManagedObject setValue:mySpeakers.speakerName forKey:@"speakerName"];
                        [newManagedObject setValue:mySpeakers.speakerID forKey:@"speakerID"];
                        [newManagedObject setValue:mySpeakers.speakerCompany forKey:@"speakerCompany"];
                        [newManagedObject setValue:mySpeakers.speakerCity forKey:@"speakerCity"];
                        [newManagedObject setValue:mySpeakers.speakerState forKey:@"speakerState"];
                        [newManagedObject setValue:mySpeakers.speakerCountry forKey:@"speakerCountry"];
                        [newManagedObject setValue:mySpeakers.speakerBio forKey:@"speakerBio"];
                        [newManagedObject setValue:mySpeakers.session1 forKey:@"session1"];
                        [newManagedObject setValue:mySpeakers.session1Date forKey:@"session1Date"];
                        [newManagedObject setValue:mySpeakers.session1Time forKey:@"session1Time"];
                        [newManagedObject setValue:mySpeakers.session1Desc forKey:@"session1Desc"];
                        [newManagedObject setValue:mySpeakers.session2 forKey:@"session2"];
                        [newManagedObject setValue:mySpeakers.session2Date forKey:@"session2Date"];
                        [newManagedObject setValue:mySpeakers.session2Time forKey:@"session2Time"];
                        [newManagedObject setValue:mySpeakers.session2Desc forKey:@"session2Desc"];
                        [newManagedObject setValue:mySpeakers.startTime forKey:@"startTime"];
                        [newManagedObject setValue:mySpeakers.endTime forKey:@"endTime"];
                         NSString * myLocation = [[NSString alloc] initWithFormat:@"%@",mySpeakers.location];
                        [newManagedObject setValue:myLocation forKey:@"location"];
                        NSString * mySess2StartTime = [[NSString alloc] initWithFormat:@"%@",mySpeakers.sess2StartTime];
                        [newManagedObject setValue:mySess2StartTime forKey:@"sess2StartTime"];
                        NSString * mySess2EndTime = [[NSString alloc] initWithFormat:@"%@",mySpeakers.sess2EndTime];
                        [newManagedObject setValue:mySess2EndTime forKey:@"sess2EndTime"];
                        NSString * myLocation2 = [[NSString alloc] initWithFormat:@"%@",mySpeakers.location2];
                        [newManagedObject setValue:myLocation2 forKey:@"location2"];
                        [newManagedObject setValue:mySpeakers.sessionID forKey:@"sessionID"];
                         NSString * mySessionID2 = [[NSString alloc] initWithFormat:@"%@",mySpeakers.sessionID2];
                        [newManagedObject setValue:mySessionID2 forKey:@"sessionID2"];
                        
                        
                        
                        NSError *error = nil;
                        // Save the object to persistent store
                        if (![context save:&error]) {
                            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                        }
                        NSLog(@"You created a new Speaker object!");
                    }

                
                    
                }
                
            });
        });

    
    
    
    //-------------------------
    
    //CREATE SESSION OBJECTS
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
            
            NSURL *url = [NSURL URLWithString:@"http://speedyreference.com/sessionsW14.php"];
            NSData * data = [NSData dataWithContentsOfURL:url];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                //Set up our sessions array
                sessionsArray = [[NSMutableArray alloc] init];
                
                for (int i = 0; i < json.count; i++) {
                    //create sessions object
                    NSString * sID = [[json objectAtIndex:i] objectForKey:@"id"];
                    NSString * sStatus = [[json objectAtIndex:i] objectForKey:@"sessionStatus"];
                    NSString * sDay = [[json objectAtIndex:i] objectForKey:@"sessionDay"];
                    NSString * sDate = [[json objectAtIndex:i] objectForKey:@"sessionDate"];
                    NSString * sTime = [[json objectAtIndex:i] objectForKey:@"sessionTime"];
                    NSString * sName = [[json objectAtIndex:i] objectForKey:@"sessionName"];
                    NSString * sSpeaker1 = [[json objectAtIndex:i] objectForKey:@"sessionSpeaker1"];
                    NSString * sSpeaker1Company = [[json objectAtIndex:i] objectForKey:@"speaker1Company"];
                    NSString * sSpeaker2 = [[json objectAtIndex:i] objectForKey:@"sessionSpeaker2"];
                    NSString * sSpeaker2Company = [[json objectAtIndex:i] objectForKey:@"speaker2Company"];
                    NSString * sSpeaker3 = [[json objectAtIndex:i] objectForKey:@"sessionSpeaker3"];
                    NSString * sSpeaker3Company = [[json objectAtIndex:i] objectForKey:@"speaker3Company"];
                    NSString * sSpeaker4 = [[json objectAtIndex:i] objectForKey:@"sessionSpeaker4"];
                    NSString * sSpeaker4Company = [[json objectAtIndex:i] objectForKey:@"speaker4Company"];
                    NSString * sSpeaker5 = [[json objectAtIndex:i] objectForKey:@"sessionSpeaker5"];
                    NSString * sSpeaker5Company = [[json objectAtIndex:i] objectForKey:@"speaker5Company"];
                    NSString * sSpeaker6 = [[json objectAtIndex:i] objectForKey:@"sessionSpeaker6"];
                    NSString * sSpeaker6Company = [[json objectAtIndex:i] objectForKey:@"speaker6Company"];
                    NSString * sDesc = [[json objectAtIndex:i] objectForKey:@"sessionDesc"];
                    NSString * sITSCECS = [[json objectAtIndex:i] objectForKey:@"ITSCECS"];
                    NSString * sSessionID = [[json objectAtIndex:i] objectForKey:@"sessionID"];
                    NSString * sStartTime = [[json objectAtIndex:i] objectForKey:@"startTime"];
                    NSString * sEndTime = [[json objectAtIndex:i] objectForKey:@"endTime"];
                    NSString * sLocation = [[json objectAtIndex:i] objectForKey:@"location"];
                    NSString * sStartTimeStr = [[json objectAtIndex:i] objectForKey:@"startTimeStr"];
                    
                    Sessions * mySessions = [[Sessions alloc] initWithID:sID andSessionStatus:sStatus andSessionDay:sDay andSessionDate:sDate andSessionTime:sTime andSessionName:sName andSessionSpeaker1:sSpeaker1 andSpeaker1Company:sSpeaker1Company andSessionSpeaker2:sSpeaker2 andSpeaker2Company:sSpeaker2Company andSessionSpeaker3:sSpeaker3 andSpeaker3Company:sSpeaker3Company andSessionSpeaker4:sSpeaker4 andSpeaker4Company:sSpeaker4Company andSessionSpeaker5:sSpeaker5 andSpeaker5Company:sSpeaker5Company andSessionSpeaker6:sSpeaker6 andSpeaker6Company:sSpeaker6Company andSessionDesc:sDesc andITSCECS:sITSCECS andSessionID:sSessionID andStartTime:sStartTime andEndTime:sEndTime andLocation:sLocation andStartTimeStr:sStartTimeStr];
                    
                    //Add our sessions object to our sessionsArray
                    [sessionsArray addObject:mySessions];
                    
                    NSManagedObjectContext *context = [self managedObjectContext];
                    
                    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
                    
                    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Sessions" inManagedObjectContext:context];
                    
                    [fetchRequest setEntity:entity];
                    
                    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"sessionID == %@",mySessions.sessionID]];
                    
                    NSArray *myResults = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
                    
                    self.objects = myResults;
                    if (!myResults || !myResults.count){
                        
                        NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Sessions" inManagedObjectContext:context];
                        
                        [newManagedObject setValue:mySessions.sessionName forKey:@"sessionName"];
                        [newManagedObject setValue:mySessions.sessionStatus forKey:@"sessionStatus"];
                        [newManagedObject setValue:mySessions.sessionDay forKey:@"sessionDay"];
                        [newManagedObject setValue:mySessions.sessionDate forKey:@"sessionDate"];
                        [newManagedObject setValue:mySessions.sessionTime forKey:@"sessionTime"];
                        [newManagedObject setValue:mySessions.sessionSpeaker1 forKey:@"sessionSpeaker1"];
                        [newManagedObject setValue:mySessions.sessionSpeaker2 forKey:@"sessionSpeaker2"];
                        [newManagedObject setValue:mySessions.sessionSpeaker3 forKey:@"sessionSpeaker3"];
                        [newManagedObject setValue:mySessions.sessionSpeaker4 forKey:@"sessionSpeaker4"];
                        [newManagedObject setValue:mySessions.sessionSpeaker5 forKey:@"sessionSpeaker5"];
                        [newManagedObject setValue:mySessions.sessionSpeaker6 forKey:@"sessionSpeaker6"];
                        [newManagedObject setValue:mySessions.speaker1Company forKey:@"speaker1Company"];
                        [newManagedObject setValue:mySessions.speaker2Company forKey:@"speaker2Company"];
                        [newManagedObject setValue:mySessions.speaker3Company forKey:@"speaker3Company"];
                        [newManagedObject setValue:mySessions.speaker4Company forKey:@"speaker4Company"];
                        [newManagedObject setValue:mySessions.speaker5Company forKey:@"speaker5Company"];
                        [newManagedObject setValue:mySessions.speaker6Company forKey:@"speaker6Company"];
                        [newManagedObject setValue:mySessions.ITSCECS forKey:@"itscecs"];
                        [newManagedObject setValue:mySessions.sessionDesc forKey:@"sessionDesc"];
                        [newManagedObject setValue:mySessions.sessionID forKey:@"sessionID"];
                        //[newManagedObject setValue:mySessions.startTime forKey:@"startTime"];
                        NSDateFormatter *df = [[NSDateFormatter alloc] init];
                        [df setDateFormat:@"hh:mm a"];
                        NSDate *sessTime = [df dateFromString: mySessions.startTime];
                        [newManagedObject setValue:sessTime forKey:@"startTime"];
                        [newManagedObject setValue:mySessions.endTime forKey:@"endTime"];
                        NSString * myLocation3 = [[NSString alloc] initWithFormat:@"%@",mySessions.location];
                        [newManagedObject setValue:myLocation3 forKey:@"location"];
                        [newManagedObject setValue:mySessions.startTimeStr forKey:@"startTimeStr"];

                        
                        
                        
                        
                        NSError *error = nil;
                        // Save the object to persistent store
                        if (![context save:&error]) {
                            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                        }
                        NSLog(@"You created a new Session object!");
                    }

                    
                    
                    
                }
                
                
            });
        });

    
    //-------------------------
    
    }//END REACHABILITY ELSE
    
    
    
    return YES;
    
    
}



- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

//maaj code 062313
- (void) refreshTable {
    
    printf("\n Refresh is called \n");
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    //NSManagedObjectContext *managedObjectContext = [self.coreDataStore contextForCurrentThread];
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Todo" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    [managedObjectContext executeFetchRequest:fetchRequest error:nil];
}

-(NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"bicsi" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"bicsi.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}



- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    internetReach = [Reachability reachabilityForInternetConnection];
    [internetReach startNotifier];
    
    NetworkStatus netStatus = [internetReach currentReachabilityStatus];
    
    switch (netStatus)
    {
        case ReachableViaWWAN:
        {
            break;
        }
        case ReachableViaWiFi:
        {
            break;
        }
        case NotReachable:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"We are unable to make an internet connection at this time. Some functionality will be limited until a connection is made." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            //[alert release];
            break;
        }
            
    }

    
    application.applicationIconBadgeNumber = 0;
    
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:
(NSData *)deviceToken
{
    [[PushIOManager sharedInstance] didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    [[PushIOManager sharedInstance] didFailToRegisterForRemoteNotificationsWithError:error];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [[PushIOManager sharedInstance] didReceiveRemoteNotification:userInfo];
    
    NSDictionary *payload = [userInfo objectForKey:@"aps"];
    
    NSString *alertMessage = [payload objectForKey:@"alert"];
    
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:alertMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alertView show];
    
    
    //Save to plist
    
    //NSDate *now = [NSDate date];
    
    if([clName count] == 5)
        [clName removeObjectAtIndex:0];
    [clName addObject:alertMessage];
    //[clName addObject:now];
    
    
	// get paths from root direcory
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    // get documents path
    NSString *documentsPath = [paths objectAtIndex:0];
    // get the path to our Data/plist file
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"Data.plist"];
	
	// This writes the array to a plist file. If this file does not already exist, it creates a new one.
	[clName writeToFile:plistPath atomically: TRUE];
    
    //-------------------------------------//
    //For showing tabbar badge value
    //Added by Maaj
    //iNotificationCounter++;
    //UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    
    //UITabBarItem *tabBarItem2 = [[[tabBarController tabBar] items] objectAtIndex:2];
    //tabBarItem2.badgeValue = [NSString stringWithFormat:@"%d",iNotificationCounter];
    //-------------------------------------//
    
    
}

- (void)readyForRegistration
{
    // If this method is called back, PushIOManager has a proper device token
    // so now you are ready to register.
}

- (void)registrationSucceeded
{
    // Push IO registration was successful
}

- (void)registrationFailedWithError:(NSError *)error statusCode:(int)statusCode
{
    // Push IO registration failed
}

//Called by Reachability whenever status changes.
- (void) reachabilityChanged: (NSNotification* )note
{
    printf("Reachability"); //maaj code 062313
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    switch (netStatus)
    {
        case ReachableViaWWAN:
        {
            break;
        }
        case ReachableViaWiFi:
        {
            break;
        }
        case NotReachable:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"We are unable to make an internet connection at this time. Some functionality will be limited until a connection is made." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            //[alert release];
            break;
        }
    }

}

@end
