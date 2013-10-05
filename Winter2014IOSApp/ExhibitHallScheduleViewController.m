//
//  ExhibitHallScheduleViewController.m
//  Fall2013IOSApp
//
//  Created by Barry on 6/19/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "ExhibitHallScheduleViewController.h"
#import "ExhibitHallScheduleCell.h"
#import "EHSchedule.h"

@interface ExhibitHallScheduleViewController ()

@end

//#define getDataURL @"http://speedyreference.com/ehschedule.php"
//#define kBgQueue dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1
//#define getDataURL [NSURL URLWithString: @"http://speedyreference.com/ehschedule.php"] //2

@implementation ExhibitHallScheduleViewController

@synthesize json;
@synthesize exhibitHallArray;

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
    
//    dispatch_async(kBgQueue, ^{
//        NSData* data = [NSData dataWithContentsOfURL:
//                        getDataURL];
//        [self performSelectorOnMainThread:@selector(fetchedData:)
//                               withObject:data waitUntilDone:YES];
//    });
    
    
    [self retrieveData];
    
    
}

//#pragma mark - Methods
//- (void)fetchedData:(NSData *)responseData
- (void)retrieveData
{
    
    
    NSURL * url = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"ehschedule-json.json" ofType:nil]];
    NSData * data = [NSData dataWithContentsOfURL:url];
    
    json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    //Set up our sessions array
    exhibitHallArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < json.count; i++) {
        //create session object
        NSString * sID = [[json objectAtIndex:i] objectForKey:@"id"];
        NSString * sDate = [[json objectAtIndex:i] objectForKey:@"scheduleDate"];
        NSString * sName = [[json objectAtIndex:i] objectForKey:@"sessionName"];
        NSString * sTime = [[json objectAtIndex:i] objectForKey:@"sessionTime"];
        
        EHSchedule   * mySchedule = [[EHSchedule alloc] initWithScheduleID: sID andScheduleDate: sDate andSessionName: sName andSessionTime: sTime];
        
        //Add our sessions object to our exhibitHallArray
        [exhibitHallArray addObject:mySchedule];
        
        
        
    }
    
    
    
    [self.tableView reloadData];
    
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
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [exhibitHallArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ExhibitHallCell";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    ExhibitHallScheduleCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[ExhibitHallScheduleCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    // Configure the cell...
    
    EHSchedule * ehschedule = nil;
    
    ehschedule = [exhibitHallArray objectAtIndex:indexPath.row];
    
    cell.scheduleDate.text = ehschedule.scheduleDate;
    cell.scheduleDate.font = [UIFont fontWithName:@"Arial" size:10.0];
    
    cell.sessionName.text = ehschedule.sessionName;
    cell.sessionName.font = [UIFont fontWithName:@"Arial" size:13.0];
    cell.sessionName.textColor = [UIColor brownColor];
    
    cell.sessionTime.text = ehschedule.sessionTime;
    cell.sessionTime.font = [UIFont fontWithName:@"Arial" size:12.0];
    
//    cell.sessionName.userInteractionEnabled = YES;
//    UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openUrl:)];
//    [cell.sessionName addGestureRecognizer:gr];
//    gr.numberOfTapsRequired = 1;
//    gr.cancelsTouchesInView = NO;
//    [self.view addSubview:cell.sessionName];
    
    return cell;
}

//- (void)openUrl:(id)sender
//{
//    UIGestureRecognizer *rec = (UIGestureRecognizer *)sender;
//    
//    id hitLabel = [self.view hitTest:[rec locationInView:self.view] withEvent:UIEventTypeTouches];
//    
//    if ([hitLabel isKindOfClass:[UILabel class]]) {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:((UILabel *)hitLabel).text]];
//    }
//}

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
