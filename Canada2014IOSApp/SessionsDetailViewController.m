//
//  SessionsDetailViewController.m
//  Fall2013IOSApp
//
//  Created by Barry on 7/12/13.
//  Copyright (c) 2013 BICSI. All rights reserved.


#import "SessionsDetailViewController.h"
#import "SVWebViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <MessageUI/MessageUI.h>
#import "Fall2013IOSAppAppDelegate.h"

@interface SessionsDetailViewController () <MFMessageComposeViewControllerDelegate>

@end

@implementation SessionsDetailViewController
@synthesize sessionDateLabel, sessionDescTextField, sessionIdLabel, sessionNameLabel, sessionTimeLabel, speaker1NameLabel,speaker2NameLabel, speaker3NameLabel, speaker4NameLabel, speaker5NameLabel, speaker6NameLabel, mySessions, sessionId, sessionName, agendaButton, locationLabel, location, endTime, startTimeStr, sessionDay, pollButton;

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

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
	    
    NSUUID *id = [[UIDevice currentDevice] identifierForVendor];
    NSString *deviceID = [[NSString alloc] initWithFormat:@"%@",id];
    NSString *newDeviceID = [deviceID substringWithRange:NSMakeRange(30, [deviceID length]-30)];
    
    NSLog(@"Untruncated Device ID is: %@", deviceID);
    NSLog(@"Truncated Device ID is: %@", newDeviceID);
    
    
    
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    self.title = mySessions.sessionName;
    
    sessionNameLabel.text = mySessions.sessionName;
    sessionIdLabel.text = mySessions.sessionID;
    sessionDateLabel.text = mySessions.sessionDate;
    sessionTimeLabel.text = mySessions.sessionTime;
    sessionDescTextField.text = mySessions.sessionDesc;
    speaker1NameLabel.text = mySessions.sessionSpeaker1;
    speaker2NameLabel.text = mySessions.sessionSpeaker2;
    speaker3NameLabel.text = mySessions.sessionSpeaker3;
    speaker4NameLabel.text = mySessions.sessionSpeaker4;
    speaker5NameLabel.text = mySessions.sessionSpeaker5;
    speaker6NameLabel.text = mySessions.sessionSpeaker6;
    locationLabel.text = mySessions.location;
    
    startTimeStr = mySessions.startTimeStr;
    endTime = mySessions.endTime;
    location = mySessions.location;
    sessionDay = mySessions.sessionDay;
    

    
    NSLog(@"Session Id 1 is: %@", mySessions.sessionID);
    NSLog(@"Session startTime is: %@", mySessions.startTimeStr);
    NSLog(@"Session day is: %@", mySessions.sessionDay);
    
    
    [[sessionDescTextField layer] setBorderColor:[[UIColor colorWithRed:48/256.0 green:134/256.0 blue:174/256.0 alpha:1.0] CGColor]];
    [[sessionDescTextField layer] setBorderWidth:2.3];
    [[sessionDescTextField layer] setCornerRadius:10];
    [sessionDescTextField setClipsToBounds: YES];
    
    
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
//        [self.pollButton setHidden:YES];
//    }
    
    if ([mySessions.sessionDay  isEqual: @""]) {
        [self.pollButton setHidden:YES];
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Sessnotes" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    //[fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"title != 'Todo with Image'"]];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"sessionID == %@ && deviceowner == %@ && agenda == 'Yes'",mySessions.sessionID,newDeviceID]];
     NSLog(@"MY SESSION ID 1 IS: %@",mySessions.sessionID);
    
     NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    //[self.managedObjectContext executeFetchRequest:fetchRequest onSuccess:^(NSArray *results) {
        //[self.refreshControl endRefreshing];
        self.objects = results;
        NSLog(@"Results Count is: %lu", (unsigned long)results.count);
        if (!results || !results.count){
            [self.agendaButton setTitle:@"Add to Planner" forState:normal];
            
        }
        else{
            [self.agendaButton setTitle:@"Remove from Planner" forState:normal];
        }
        
//    } onFailure:^(NSError *error) {
//        
//        //[self.refreshControl endRefreshing];
//        NSLog(@"An error %@, %@", error, [error userInfo]);
//    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"notesDetail"]) {
        self.sessionName = sessionNameLabel.text;
        self.sessionId = mySessions.sessionID;
        NotesViewController *destViewController = segue.destinationViewController;
        destViewController.title = sessionNameLabel.text;
        destViewController.sessionName = self.sessionName;
        destViewController.sessionId = self.sessionId;
        
        NSLog(@"Session ID 1 is %@", self.sessionId);
    }
}

- (IBAction)agendaButtonPressed:(id)sender {
    
    NSUUID *id = [[UIDevice currentDevice] identifierForVendor];
    NSString *deviceID = [[NSString alloc] initWithFormat:@"%@",id];
    NSString *newDeviceID = [deviceID substringWithRange:NSMakeRange(30, [deviceID length]-30)];
    
    NSLog(@"Untruncated Device ID is: %@", deviceID);
    NSLog(@"Truncated Device ID is: %@", newDeviceID);
    
    NSLog(@"MY SESSION ID 1 IS: %@",mySessions.sessionID);
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if ([self.agendaButton.currentTitle isEqual:@"Add to Planner"]) {
        NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Sessnotes" inManagedObjectContext:context];
        
        [newManagedObject setValue:self.mySessions.sessionID forKey:@"sessionID"];
        [newManagedObject setValue:self.sessionNameLabel.text forKey:@"sessionname"];
        [newManagedObject setValue:self.sessionDateLabel.text forKey:@"sessiondate"];
        [newManagedObject setValue:self.sessionTimeLabel.text forKey:@"sessiontime"];
        [newManagedObject setValue:self.locationLabel.text forKey:@"location"];
        //[newManagedObject setValue:self.mySessions.startTime forKey:@"starttime"];
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"hh:mm a"];
        NSDate *sessTime = [df dateFromString: mySessions.startTimeStr];
        [newManagedObject setValue:sessTime forKey:@"starttime"];
        [newManagedObject setValue:newDeviceID forKey:@"deviceowner"];
        [newManagedObject setValue:@"Yes" forKey:@"agenda"];
        
        NSError *error = nil;
        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
        
                    NSLog(@"You created a new object!");
            //[agendaButton setTitle:@"Remove from Planner" forState:normal];
        [agendaButton setTitle:@"Remove from Planner" forState:normal];


    }
    else{//start else block
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        // Edit the entity name as appropriate.
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Sessnotes" inManagedObjectContext:context];
        [fetchRequest setEntity:entity];
        //[fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"title != 'Todo with Image'"]];
        [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"sessionID == %@ && deviceowner == %@ && agenda == 'Yes'",mySessions.sessionID,newDeviceID]];
        NSLog(@"MY SESSION ID 1 IS: %@",mySessions.sessionID);
        
         NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
        
        
            self.objects = results;
            NSLog(@"Results Count is: %lu", (unsigned long)results.count);
            if (!results || !results.count){//start nested if block
                [self.agendaButton setTitle:@"Add to Planner" forState:normal];}
                else{
                    NSManagedObject *object = [results objectAtIndex:0];
                    [object setValue:NULL forKey:@"agenda"];
                    
                    NSError *error = nil;
                    // Save the object to persistent store
                    if (![context save:&error]) {
                        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                    }
                    
                        NSLog(@"You updated an object");
                        [self.agendaButton setTitle:@"Add to Planner" forState:normal];
                }
                
        
    }//end nested if block
            
}//end else block



- (IBAction)takeSurvey:(id)sender {
    NSString * sessIDStr = [[NSString alloc]initWithFormat:@"%@",self.mySessions.sessionID];
    
    if ([sessIDStr hasPrefix:@"BODM"]) {
        NSString *message = @"Survey not applicable for this meeting.";
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Notification"
                                                           message:message
                                                          delegate:self
                                                 cancelButtonTitle:@"Ok"
                                                 otherButtonTitles:nil,nil];
        [alertView show];
    }
    
    else{
    
    NSString * myURL = [NSString stringWithFormat:@"https://www.research.net/s/%@", mySessions.sessionID];
    //    NSURL *url = [NSURL URLWithString:myURL];
    //	[[UIApplication sharedApplication] openURL:url];
    NSURL *URL = [NSURL URLWithString:myURL];
	SVWebViewController *webViewController = [[SVWebViewController alloc] initWithURL:URL];
	[self.navigationController pushViewController:webViewController animated:YES];
    }
}

- (IBAction)AddEvent:(id)sender {
    
    //Create the Event Store
    EKEventStore *eventStore = [[EKEventStore alloc]init];
    
    //Check if iOS6 or later is installed on user's device *******************
    if([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)]) {
        
        //Request the access to the Calendar
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted,NSError* error){
            
            //Access not granted-------------
            if(!granted){
                NSString *message = @"This application cannot access your Calendar... please enable in your privacy settings.";
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Warning"
                                                                   message:message
                                                                  delegate:self
                                                         cancelButtonTitle:@"Ok"
                                                         otherButtonTitles:nil,nil];
                //Show an alert message!
                //UIKit needs every change to be done in the main queue
                dispatch_async(dispatch_get_main_queue(), ^{
                    [alertView show];
                }
                               );
                
                //Access granted------------------
            }else{
                
                
                //Event created
                if([self createEvent:eventStore]){
                    //labelText = @"Event added!";
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Success"
                                                                       message:@"Event added to your mobile device's calendar."
                                                                      delegate:self
                                                             cancelButtonTitle:@"Ok"
                                                             otherButtonTitles:nil,nil];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [alertView show];
                    }
                                   );
                    
                    //Error occured
                }else{
                    //labelText = @"Something goes wrong";
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Failure"
                                                                       message:@"There was a problem. Event not added to your calendar."
                                                                      delegate:self
                                                             cancelButtonTitle:@"Ok"
                                                             otherButtonTitles:nil,nil];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [alertView show];
                    }
                                   );
                    
                }
                
            }
        }];
    }
    
    //Device prior to iOS 6.0  *********************************************
    else{
        
        [self createEvent:eventStore];
        
    }
    
}



//Event creation
-(BOOL)createEvent:(EKEventStore*)eventStore{
    
    NSString *myDateStr = [[NSString alloc]initWithFormat:@"%@",mySessions.sessionDate];
    NSString *myStartTimeStr = [[NSString alloc]initWithFormat:@"%@",mySessions.startTimeStr];
    NSString *myEndTimeStr = [[NSString alloc]initWithFormat:@"%@",mySessions.endTime];
    NSLog(@"myDateStr is: %@", myDateStr);
    NSLog(@"myStartTimeStr is: %@", myStartTimeStr);
    NSLog(@"myEndTimeStr is: %@", myEndTimeStr);
    
    NSString *sessDateStr = [[NSString alloc]initWithFormat:@"%@ %@",myDateStr,myStartTimeStr];
    NSString *sessEndDateStr = [[NSString alloc]initWithFormat:@"%@ %@",myDateStr, myEndTimeStr];
    NSString *sessNameStr = [[NSString alloc]initWithFormat:@"%@", mySessions.sessionName];
    NSString *sessLocationStr = [[NSString alloc]initWithFormat:@"%@", mySessions.location];
    
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MMM dd yyyy hh:mm a"];
    NSDate *sessDate = [df dateFromString: sessDateStr];
    NSLog(@"sessDate is: %@", sessDate);
    
    NSDateFormatter *dfEnd = [[NSDateFormatter alloc] init];
    [dfEnd setDateFormat:@"MMM dd yyyy hh:mm a"];
    NSDate *sessEndDate = [df dateFromString: sessEndDateStr];
    NSLog(@"sessEndDate is: %@", sessEndDate);
    
    
    EKEvent *event = [EKEvent eventWithEventStore:eventStore];
    event.title = sessNameStr;
    event.startDate = sessDate;
    //event.endDate = [event.startDate dateByAddingTimeInterval:3600];
    event.endDate = sessEndDate;
    event.location = sessLocationStr;
    event.calendar = [eventStore defaultCalendarForNewEvents];
    
    
    
    NSError *error;
    [eventStore saveEvent:event span:EKSpanThisEvent error:&error];
    
    if (error) {
        NSLog(@"Event Store Error: %@",[error localizedDescription]);
        return NO;
    }else{
        return YES;
    }
    
    //[self createReminder];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
            
        case MessageComposeResultFailed:
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
            break;
        }
            
        case MessageComposeResultSent:
            break;
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showSMS
{
    
    if(![MFMessageComposeViewController canSendText]) {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [warningAlert show];
        return;
    }
    
    NSArray *recipents = @[@"22333"];
    //NSString *message = [NSString stringWithFormat:@"Just sent the %@ file to your email. Please check!", file];
    
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    [messageController setRecipients:recipents];
    //[messageController setBody:message];
    
    // Present message view controller on screen
    [self presentViewController:messageController animated:YES completion:nil];
}

- (IBAction)takePoll:(id)sender {
//    NSString * sessDayStr = [[NSString alloc]initWithFormat:@"%@",self.mySessions.sessionDay];
//    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
    
        [self showSMS];
    }
    else{
        NSString * myURL = [NSString stringWithFormat:@"http://pollev.com"];
        NSURL *URL = [NSURL URLWithString:myURL];
        SVWebViewController *webViewController = [[SVWebViewController alloc] initWithURL:URL];
        [self.navigationController pushViewController:webViewController animated:YES];
    }
    
}



@end
