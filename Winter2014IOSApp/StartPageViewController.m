//
//  StartPageViewController.m
//  Fall2013IOSApp
//
//  Created by Barry on 6/13/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "StartPageViewController.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "Fall2013IOSAppAppDelegate.h"

@interface StartPageViewController ()

@end

@implementation StartPageViewController

@synthesize managedObjectModel = _managedObjectModel;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize json, exhibitorsArray, speakersArray, sessionsArray, updateLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [TestFlight passCheckpoint:@"StartPage-viewed"];
    
//    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"didDisplayHelpScreen"]) {
//        UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
//        
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:window.bounds];
//        imageView.image = [UIImage imageNamed:@"app_instructions"];
//        imageView.backgroundColor = [UIColor whiteColor];
//        imageView.alpha = 0.6;
//        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissHelpView:)];
//        [imageView addGestureRecognizer:tapGesture];
//        imageView.userInteractionEnabled = YES;
//        [window addSubview:imageView];
//    }
    
    
	// Do any additional setup after loading the view.
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    HUD.labelText = @"Updating data...";
    //HUD.detailsLabelText = @"Just relax";
    HUD.mode = MBProgressHUDAnimationFade;
    [self.view addSubview:HUD];
    [HUD showWhileExecuting:@selector(waitForTwoSeconds) onTarget:self withObject:nil animated:YES];
    
    NSDate *updatetime = [NSDate date];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Timeinterval" inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    
    NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    self.objects = results;
    if (!results || !results.count)
    {//if block begin
        NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Timeinterval" inManagedObjectContext:context];
        
        [newManagedObject setValue:updatetime forKey:@"updatetime"];
        
        NSError *error = nil;
        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
        NSLog(@"You created a new updatetime object!");
    
    }
    
    else{//else block begin
        
        NSManagedObject *object = [results objectAtIndex:0];
        [object setValue:updatetime forKey:@"updatetime"];
        
        NSError *error = nil;
        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
        
        
        NSLog(@"You updated the updatetime object from an APP RESTART!");
        
        
        
    }//else block ends

}


//- (void)dismissHelpView:(UITapGestureRecognizer *)sender {
//    UIView *helpImageView = sender.view;
//    [helpImageView removeFromSuperview];
//    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"didDisplayHelpScreen"];
//}

- (void)waitForTwoSeconds {
    sleep(6);
    NSString *MyString;
	NSDate *now = [NSDate date];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	//[dateFormatter setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
    [dateFormatter setDateFormat:@"MMM dd yyyy hh:mm a"];
	MyString = [dateFormatter stringFromDate:now];
    NSLog(@"Last updated: %@", MyString);
    NSString * updated = [NSString stringWithFormat:@"Data last updated: %@", MyString];
    updateLabel.text = updated;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateAllData{
    Fall2013IOSAppAppDelegate *update = [[Fall2013IOSAppAppDelegate alloc] init];
    
    [update updateAllData];
    
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


- (IBAction)buttonPressed:(id)sender {
    
    [TestFlight passCheckpoint:@"updateData-button-pressed"];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    HUD.labelText = @"Updating data...";
    //HUD.detailsLabelText = @"Just relax";
    HUD.mode = MBProgressHUDAnimationFade;
    [self.view addSubview:HUD];
    [HUD showWhileExecuting:@selector(updateAllData) onTarget:self withObject:nil animated:YES];
    
    NSString *MyString;
	NSDate *now = [NSDate date];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	//[dateFormatter setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
    [dateFormatter setDateFormat:@"MMM dd yyyy hh:mm a"];
	MyString = [dateFormatter stringFromDate:now];
    NSLog(@"Last updated: %@", MyString);
    NSString * updated = [NSString stringWithFormat:@"Data last updated: %@", MyString];
    updateLabel.text = updated;
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Timeinterval" inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    
    NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    self.objects = results;
    
    NSManagedObject *object = [results objectAtIndex:0];
    [object setValue:now forKey:@"updatetime"];
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    
    NSLog(@"You updated the updatetime object from the UPDATE DATA button!");
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    //NSDate *timeNow = [NSDate date];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Timeinterval" inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    
    NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    self.objects = results;
    
    if (!results || !results.count){
        NSLog(@"No results");
    }
    else{//else block begin
        
        NSManagedObject *object = [results objectAtIndex:0];
        
        NSDate *updatetime = [object valueForKey:@"updatetime"];
        
        NSString *MyString;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMM dd yyyy hh:mm a"];
        MyString = [dateFormatter stringFromDate:updatetime];
        NSLog(@"******Value of updatetime converted to string: %@", MyString);
        
        
        NSTimeInterval elapsedTime = [updatetime timeIntervalSinceNow];
        
        NSString *timeDiff = [NSString stringWithFormat:@"%f", -elapsedTime];
        
        NSLog(@"Elapsed time: %@", timeDiff);
        
        if (-elapsedTime > 86400) {
            NSLog(@"Elapsed time is greater than 24 hours.");
            
            NSString *message = @"Data has not been updated in over 24 hours. Click OK to update the data, or Cancel to cancel the update.";
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Data Update Alert"
                                                               message:message
                                                              delegate:self
                                                     cancelButtonTitle:@"Cancel"
                                                     otherButtonTitles:@"OK",nil];
            [alertView show];
        }
        
    }
    
    
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    //u need to change 0 to other value(,1,2,3) if u have more buttons.then u can check which button was pressed.

    if (buttonIndex == 1) {

        //[self updateAllData];
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        HUD.labelText = @"Updating data...";
        //HUD.detailsLabelText = @"Just relax";
        HUD.mode = MBProgressHUDAnimationFade;
        [self.view addSubview:HUD];
        [HUD showWhileExecuting:@selector(updateAllData) onTarget:self withObject:nil animated:YES];
        
        NSString *MyString;
        NSDate *now = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //[dateFormatter setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
        [dateFormatter setDateFormat:@"MMM dd yyyy hh:mm a"];
        MyString = [dateFormatter stringFromDate:now];
        NSLog(@"Last updated: %@", MyString);
        NSString * updated = [NSString stringWithFormat:@"Data last updated: %@", MyString];
        updateLabel.text = updated;
        
        NSManagedObjectContext *context = [self managedObjectContext];
        
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Timeinterval" inManagedObjectContext:context];
        
        [fetchRequest setEntity:entity];
        
        NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
        
        self.objects = results;
        
        NSManagedObject *object = [results objectAtIndex:0];
        [object setValue:now forKey:@"updatetime"];
        
        NSError *error = nil;
        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
        
        
        NSLog(@"You updated the updatetime object from the DATA UPDATE ALERT!");


    }



}




@end
