//
//  ExhibitorsViewController.m
//  Fall2013IOSApp
//
//  Created by Barry on 6/26/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "ExhibitorsViewController.h"
#import "ExhibitorsDetailViewController.h"
#import "MBProgressHUD.h"
#import "Fall2013IOSAppAppDelegate.h"

@interface ExhibitorsViewController ()

@end

//#define getDataURL @"http://speedyreference.com/JSON/document.json"
//#define kBgQueue dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1
//#define getDataURL [NSURL URLWithString: @"http://speedyreference.com/JSON/document.json"] //2

@implementation ExhibitorsViewController
@synthesize json, exhibitorsArray, myTableView, results, objects;

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
	// Do any additional setup after loading the view.
    
    
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;

//    HUD = [[MBProgressHUD alloc] initWithView:self.view];
//    HUD.labelText = @"Loading data...";
//    //HUD.detailsLabelText = @"Just relax";
//    HUD.mode = MBProgressHUDAnimationFade;
//    [self.view addSubview:HUD];
//    [HUD showWhileExecuting:@selector(waitForTwoSeconds) onTarget:self withObject:nil animated:YES];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]
                                        init];
    [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
    //self.refreshControl  = refreshControl;
    
    [refreshControl beginRefreshing];
    
    
    [self refreshTable];
    
    
    //[self.myTableView reloadData];
    
}

//- (void)waitForTwoSeconds {
//    sleep(1.25);
//}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)searchThroughData
{
    self.results = nil;
    
    
    NSPredicate * resultsPredicate = [NSPredicate predicateWithFormat:@"name contains [cd] %@", self.searchBar.text];
    self.results = [[self.objects filteredArrayUsingPredicate:resultsPredicate] mutableCopy];
    
    
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    [self searchThroughData];
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row%2 == 0) {
        UIColor *altCellColor = [UIColor colorWithWhite:0.7 alpha:0.1];
        cell.backgroundColor = altCellColor;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return [exhibitorsArray count];
    if (tableView == self.myTableView) {
        return self.objects.count;
        
        
    }
    else
    {
        [self searchThroughData];
        return self.results.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Cell";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    //exhibitors * myexhibitors = nil;
    
    if (tableView == self.myTableView){
    NSManagedObject *object = [self.objects objectAtIndex:indexPath.row];
    //myexhibitors = [exhibitorsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [object valueForKey:@"name"];
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:15.0];
    cell.textLabel.textColor = [UIColor brownColor];
    NSString * booth = [NSString stringWithFormat:@"Booth Number: %@", [object valueForKey:@"boothLabel"]];
    cell.detailTextLabel.text = booth;
    cell.detailTextLabel.font = [UIFont fontWithName:@"Arial" size:13.0];
    }
    else{
        
    //myexhibitors = [results objectAtIndex:indexPath.row];
    NSManagedObject *object = [results objectAtIndex:indexPath.row];
    cell.textLabel.text = [object valueForKey:@"name"];
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:15.0];
    cell.textLabel.textColor = [UIColor brownColor];
    NSString * booth = [NSString stringWithFormat:@"Booth Number: %@", [object valueForKey:@"boothLabel"]];
    cell.detailTextLabel.text = booth;
    cell.detailTextLabel.font = [UIFont fontWithName:@"Arial" size:13.0];
    }
    
    return cell;
}



-(void)refreshTable{
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Exhibitors" inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSArray *myResults = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]
                                        init];

    [refreshControl endRefreshing];
    self.objects = myResults;
    [self.myTableView reloadData];
    
}

    
    

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.searchDisplayController.isActive) {
        [self performSegueWithIdentifier:@"exhibitDetailCell" sender:self];
    }
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"exhibitDetailCell"]) {
        
        
        if (self.searchDisplayController.isActive) {
            NSIndexPath * indexPath = [[self.searchDisplayController searchResultsTableView] indexPathForSelectedRow];
        ExhibitorsDetailViewController *destViewController = segue.destinationViewController;
        destViewController.myExhibitors = [results objectAtIndex:indexPath.row];
        }
        else{
        
        NSIndexPath *indexPath = [self.myTableView indexPathForSelectedRow];
        ExhibitorsDetailViewController *destViewController = segue.destinationViewController;
        destViewController.myExhibitors = [objects objectAtIndex:indexPath.row];
        }
    }
}


@end

