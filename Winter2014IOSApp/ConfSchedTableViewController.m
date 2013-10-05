//
//  ConfSchedTableViewController.m
//  Fall2013IOSApp
//
//  Created by Barry on 8/30/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "ConfSchedTableViewController.h"
#import "ConfSchedDetailTableViewController.h"

@interface ConfSchedTableViewController ()

@end

@implementation ConfSchedTableViewController
@synthesize json;
@synthesize confSchedArray;

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
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;

    [self retrieveData];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [confSchedArray count];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row%2 == 0) {
        UIColor *altCellColor = [UIColor colorWithWhite:0.7 alpha:0.1];
        cell.backgroundColor = altCellColor;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    ConfSched * confsched = nil;
    
    confsched = [confSchedArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = confsched.day;
    cell.detailTextLabel.text = confsched.date;
    
    cell.textLabel.font = [UIFont fontWithName:@"Arial-Bold" size:15.0];
    cell.textLabel.textColor = [UIColor brownColor];
    
    cell.detailTextLabel.font = [UIFont fontWithName:@"Arial" size:13.0];
    
    
    // Configure the cell...
    
    return cell;
}

-(void) retrieveData
{
    NSURL * url = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"confschedule.json" ofType:nil]];
    NSData * data = [NSData dataWithContentsOfURL:url];
    
    json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    //Set up our confsched array
    confSchedArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < json.count; i++) {
        //create confSched object
        NSString * cID = [[json objectAtIndex:i] objectForKey:@"id"];
        NSString * cDay = [[json objectAtIndex:i] objectForKey:@"Day"];
        NSString * cDate = [[json objectAtIndex:i] objectForKey:@"Date"];
        
        
        ConfSched   * myConfSched = [[ConfSched alloc] initWithID: cID andDay: cDay andDate: cDate];
        
        //Add our sessions object to our exhibitHallArray
        [confSchedArray addObject:myConfSched];
        
        
        
    }
    
    [self.tableView reloadData];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"confSchedDetailCell"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ConfSchedDetailTableViewController *destViewController = segue.destinationViewController;
        destViewController.confsched = [confSchedArray objectAtIndex:indexPath.row];
        
        // Hide bottom tab bar in the detail view
        //destViewController.hidesBottomBarWhenPushed = YES;
        
    }
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

@end
