//
//  ListViewController.m
//  Fall2013IOSApp
//
//  Created by Barry on 5/30/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "ListViewController.h"
#import "Fall2013IOSAppAppDelegate.h"
#import "StackMob.h"

extern int iNotificationCounter;

@interface ListViewController ()

@end

@implementation ListViewController

@synthesize client = _client;
@synthesize coreDataStore = _coreDataStore;
@synthesize managedObjectContext = _managedObjectContext;

//- (NSManagedObjectContext *)managedObjectContext {
//    NSManagedObjectContext *context = nil;
//    id delegate = [[UIApplication sharedApplication] delegate];
//    if ([delegate performSelector:@selector(managedObjectContext)]) {
//        context = [delegate managedObjectContext];
//    }
//    return context;
//}

//- (Fall2013IOSAppAppDelegate *)appDelegate {
    //return (Fall2013IOSAppAppDelegate *)[[UIApplication sharedApplication] delegate];
//}

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.managedObjectContext = [[self coreDataStore] contextForCurrentThread];
    
    self.client = [[SMClient alloc] initWithAPIVersion:@"1" publicKey:@"144a82ba-d4b7-42c6-8674-c492fdc8c403"];
    self.coreDataStore = [self.client coreDataStoreWithManagedObjectModel:self.managedObjectModel];
    
    //----------------------------------------------//
    //For reseting the tabbar badge value
    //Added by Maaj
    UITabBarController *tBar = (UITabBarController*)[[[UIApplication sharedApplication] keyWindow] rootViewController];
    UITabBarItem *item=[[[tBar tabBar] items] objectAtIndex:2];
    [item setBadgeValue:nil];
    iNotificationCounter = 0;
    //----------------------------------------------//
    
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]
                                        init];
    [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
    self.refreshControl  = refreshControl;
    
    [refreshControl beginRefreshing];
    
    printf("View Did Load is called ");//maaj code 062313
    
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
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    printf("No of sections \n");//maaj code 062313
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    printf("object count \n");//maaj code 062313
    return [self.objects count];
}

//- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//
//{
//    UIImage *myImage = [UIImage imageNamed:@"cellheader.png"];
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:myImage];
//    imageView.frame = CGRectMake(10, 10, 300, 75);
//    return imageView;
//    
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSManagedObject *object = [self.objects objectAtIndex:indexPath.row];
    cell.textLabel.text = [object valueForKey:@"post"];
    cell.detailTextLabel.text = [object valueForKey:@"date"];
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:10.0];
    cell.textLabel.numberOfLines = 4;

    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row%2 == 0) {
        UIColor *altCellColor = [UIColor colorWithWhite:0.7 alpha:0.1];
        cell.backgroundColor = altCellColor;
    }
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"appalert" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}


- (void) refreshTable {
    
    self.managedObjectContext = [[self coreDataStore] contextForCurrentThread];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Alerts" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"post != 'Approved'"]];
    //NSError *error = nil;
    //NSArray *array = [self executeFetchRequest:fetchRequest error:&error];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
     //NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    [self.managedObjectContext executeFetchRequest:fetchRequest onSuccess:^(NSArray *results) {
        [self.refreshControl endRefreshing];
        self.objects = results;
        [self.tableView reloadData];
        
    } onFailure:^(NSError *error) {
        
        [self.refreshControl endRefreshing];
        NSLog(@"An error %@, %@", error, [error userInfo]);
    }];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

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

- (IBAction)buttonPressed:(id)sender {
    
    [self refreshTable];
}
@end
