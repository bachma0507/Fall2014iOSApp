//
//  AgendaDetailViewController.m
//  Fall2013IOSApp
//
//  Created by Barry on 7/23/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "AgendaDetailViewController.h"
#import "SVWebViewController.h"
#import <QuartzCore/QuartzCore.h>
//#import "StackMob.h"
#import "Fall2013IOSAppAppDelegate.h"


@interface AgendaDetailViewController ()

@end

@implementation AgendaDetailViewController
@synthesize sessionId, sessionName, sessionNameLabel, sessionIdLabel, location, locationLabel;

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


//- (Fall2013IOSAppAppDelegate *)appDelegate {
//    return (Fall2013IOSAppAppDelegate *)[[UIApplication sharedApplication] delegate];
//}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
//    
    NSUUID *id = [[UIDevice currentDevice] identifierForVendor];
    NSString *deviceID = [[NSString alloc] initWithFormat:@"%@",id];
    NSString *newDeviceID = [deviceID substringWithRange:NSMakeRange(30, [deviceID length]-30)];
    
    NSLog(@"Untruncated Device ID is: %@", deviceID);
    NSLog(@"Truncated Device ID is: %@", newDeviceID);
    
    
    //self.managedObjectContext = [[self.appDelegate coreDataStore] contextForCurrentThread];
    
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    
    sessionNameLabel.text = self.sessionName;
    sessionIdLabel.text = self.sessionId;
    locationLabel.text = self.location;
    
    [[sessionNameLabel layer] setBorderColor:[[UIColor colorWithRed:48/256.0 green:134/256.0 blue:174/256.0 alpha:1.0] CGColor]];
    [[sessionNameLabel layer] setBorderWidth:1.0];
    [[sessionNameLabel layer] setCornerRadius:10];
    //[sessionNameLabel setClipsToBounds: YES];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)takeSurvey:(id)sender{
    
    NSString * myURL = [NSString stringWithFormat:@"https://www.research.net/s/%@", self.sessionId];
    //    NSURL *url = [NSURL URLWithString:myURL];
    //	[[UIApplication sharedApplication] openURL:url];
    NSURL *URL = [NSURL URLWithString:myURL];
	SVWebViewController *webViewController = [[SVWebViewController alloc] initWithURL:URL];
	[self.navigationController pushViewController:webViewController animated:YES];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"notesDetail"]) {
        self.sessionName = sessionNameLabel.text;
        self.sessionId = sessionIdLabel.text;
        
        NotesViewController *destViewController = segue.destinationViewController;
        destViewController.title = sessionNameLabel.text;
        destViewController.sessionName = self.sessionName;
        destViewController.sessionId = self.sessionId;
        
        NSLog(@"Session ID is %@", self.sessionId);
    }
}

@end
