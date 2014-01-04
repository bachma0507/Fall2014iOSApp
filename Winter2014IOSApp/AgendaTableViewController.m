//
//  AgendaTableViewController.m
//  Fall2013IOSApp
//
//  Created by Barry on 7/19/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "AgendaTableViewController.h"
#import "Fall2013IOSAppAppDelegate.h"
//#import "StackMob.h"
#import "AgendaCell.h"
#import "NotesViewController.h"


@interface AgendaTableViewController ()

@end

@implementation AgendaTableViewController
@synthesize sessionName, sessionId, location;


- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [TestFlight passCheckpoint:@"MyAgendaTable-info-viewed"];
    
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;

    
    NSUUID *id = [[UIDevice currentDevice] identifierForVendor];
    NSString *deviceID = [[NSString alloc] initWithFormat:@"%@",id];
    NSString *newDeviceID = [deviceID substringWithRange:NSMakeRange(30, [deviceID length]-30)];
    
    NSLog(@"Untruncated Device ID is: %@", deviceID);
    NSLog(@"Truncated Device ID is: %@", newDeviceID);
    
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]
                                        init];
    [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
    self.refreshControl  = refreshControl;
    
    [refreshControl beginRefreshing];
    
    
    [self refreshTable];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
    //return [dateArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.objects count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    AgendaCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[AgendaCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    NSManagedObject *object = [self.objects objectAtIndex:indexPath.row];
    cell.sessionNameLabel.text = [object valueForKey:@"sessionname"];
    cell.sessionNameLabel.textColor = [UIColor brownColor];
    cell.sessionDateLabel.text = [object valueForKey:@"sessiondate"];
    cell.sessionDateLabel.textColor = [UIColor blackColor];
    cell.sessionTimeLabel.text = [object valueForKey:@"sessiontime"];
    cell.sessionTimeLabel.textColor = [UIColor blackColor];
    
    //cell.textLabel.numberOfLines = 0;
    //cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    return cell;

}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row%2 == 0) {
//        UIColor *altCellColor = [UIColor colorWithWhite:0.7 alpha:0.1];
//        cell.backgroundColor = altCellColor;
//    }
//}


- (void)tableView: (UITableView*)tableView willDisplayCell: (UITableViewCell*)cell forRowAtIndexPath: (NSIndexPath*)indexPath
{
    
    if(indexPath.row % 2 == 0){
        UIColor *altCellColor = [UIColor colorWithRed:235/255.0 green:240/255.0 blue:233/255.0 alpha:1.0];
        cell.backgroundColor = altCellColor;
    }
    else{
        cell.backgroundColor = [UIColor whiteColor];
    }
}

- (void) refreshTable {
    NSUUID *id = [[UIDevice currentDevice] identifierForVendor];
    NSString *deviceID = [[NSString alloc] initWithFormat:@"%@",id];
    NSString *newDeviceID = [deviceID substringWithRange:NSMakeRange(30, [deviceID length]-30)];
    
    NSLog(@"Untruncated Device ID is: %@", deviceID);
    NSLog(@"Truncated Device ID is: %@", newDeviceID);
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Sessnotes" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"deviceowner == %@ && agenda == 'Yes'", newDeviceID]];
    //NSError *error = nil;
    //NSArray *array = [self executeFetchRequest:fetchRequest error:&error];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"sessiondate" ascending:YES];
    NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@"starttime" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor1, sortDescriptor2, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
     NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    if (!results || !results.count) {
        NSString *message = @"You have not added any sessions to your planner. Please click on Add to Planner when viewing Session details. If you signed up for sessions when you registered, please click on the My BICSI icon and go to My Schedule.";
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Notification"
                                                           message:message
                                                          delegate:self
                                                 cancelButtonTitle:@"Ok"
                                                 otherButtonTitles:nil,nil];
        [alertView show];
    }

    
    
        [self.refreshControl endRefreshing];
        self.objects = results;
    NSLog(@"Results = %lu", (unsigned long)results.count);
    
    
        [self.tableView reloadData];
        
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
        
        NSManagedObject *object = [self.objects objectAtIndex:indexPath.row];
        
        NSManagedObjectContext *context = [self managedObjectContext];
        
        [context deleteObject:[context objectWithID:[object objectID]]];
        
        
        NSError *error = nil;
        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
        
        NSMutableArray *array = [self.objects mutableCopy];
        [array removeObjectAtIndex:indexPath.row];
        self.objects = array;
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        //[tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation: UITableViewRowAnimationAutomatic];
        //[tableView reloadData];
    
//
       
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"agendaDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSManagedObject *object = [self.objects objectAtIndex:indexPath.row];
        self.sessionName = [object valueForKey:@"sessionname"];
        self.sessionId = [object valueForKey:@"sessionID"];
        self.location = [object valueForKey:@"location"];
        
        
        
        
        NotesViewController *destViewController = segue.destinationViewController;
        destViewController.title = self.sessionName;
        destViewController.sessionName = self.sessionName;
        destViewController.sessionId = self.sessionId;
        destViewController.location = self.location;
        
        
        
        
        NSLog(@"Session ID is %@", self.sessionId);
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
