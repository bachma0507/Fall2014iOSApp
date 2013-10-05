//
//  SponsorsTableViewController.m
//  Fall2013IOSApp
//
//  Created by Barry on 6/19/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "SponsorsTableViewController.h"
#import "SponsorsDetailViewController.h"
#import "MBProgressHUD.h"


@interface SponsorsTableViewController ()

@end

//#define getDataURL @"http://speedyreference.com/sponsors.php"
//#define kBgQueue dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1
//#define getDataURL [NSURL URLWithString: @"http://speedyreference.com/sponsors.php"] //2

@implementation SponsorsTableViewController

@synthesize json;
@synthesize sponsorsArray;

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
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        HUD.labelText = @"Loading data...";
        //HUD.detailsLabelText = @"Just relax";
        HUD.mode = MBProgressHUDAnimationFade;
        [self.view addSubview:HUD];
        [HUD showWhileExecuting:@selector(waitForTwoSeconds) onTarget:self withObject:nil animated:YES];
    
//    dispatch_async(kBgQueue, ^{
//        NSData* data = [NSData dataWithContentsOfURL:
//                        getDataURL];
//        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
//    });
    

    
//    HUD = [[MBProgressHUD alloc] initWithView:self.view];
//    [self.view addSubview:HUD];
//    [HUD show:YES];
    
    [self retrieveData];

    
}

- (void)waitForTwoSeconds {
    sleep(1);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - Methods
//- (void)fetchedData:(NSData *)responseData
-(void)retrieveData
{
 
    
    NSURL * url = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"sponsors-json.json" ofType:nil]];
    NSData * data = [NSData dataWithContentsOfURL:url];
    
    json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    //Set up our sessions array
    sponsorsArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < json.count; i++) {
        //create session object
        NSString * sID = [[json objectAtIndex:i] objectForKey:@"id"];
        NSString * sLevel = [[json objectAtIndex:i] objectForKey:@"sponsorLevel"];
        NSString * sSpecial = [[json objectAtIndex:i] objectForKey:@"sponsorSpecial"];
        NSString * sName = [[json objectAtIndex:i] objectForKey:@"sponsorName"];
        NSString * bNumber = [[json objectAtIndex:i] objectForKey:@"boothNumber"];
        NSString * sWebsite = [[json objectAtIndex:i] objectForKey:@"sponsorWebsite"];
        NSString * sImage = [[json objectAtIndex:i] objectForKey:@"sponsorImage"];
        
        Sponsors   * mySponsors = [[Sponsors alloc] initWithSponsorID: sID andSponsorLevel: sLevel andSponsorSpecial: sSpecial andSponsorName: sName andBoothnumber: bNumber andSponsorWebsite:sWebsite andSponsorImage:sImage];
        
        //Add our sessions object to our exhibitHallArray
        [sponsorsArray addObject:mySponsors];
        
        
    }
    
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
//        
//        NSURL *url = [NSURL URLWithString:@"http://speedyreference.com/sponsors.php"];
//        NSData * data = [NSData dataWithContentsOfURL:url];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//            
//            //Set up our sessions array
//            sponsorsArray = [[NSMutableArray alloc] init];
//            
//            for (int i = 0; i < json.count; i++) {
//                //create session object
//                NSString * sID = [[json objectAtIndex:i] objectForKey:@"id"];
//                NSString * sLevel = [[json objectAtIndex:i] objectForKey:@"sponsorLevel"];
//                NSString * sSpecial = [[json objectAtIndex:i] objectForKey:@"sponsorSpecial"];
//                NSString * sName = [[json objectAtIndex:i] objectForKey:@"sponsorName"];
//                NSString * bNumber = [[json objectAtIndex:i] objectForKey:@"boothNumber"];
//                NSString * sWebsite = [[json objectAtIndex:i] objectForKey:@"sponsorWebsite"];
//                NSString * sImage = [[json objectAtIndex:i] objectForKey:@"sponsorImage"];
//                
//                Sponsors   * mySponsors = [[Sponsors alloc] initWithSponsorID: sID andSponsorLevel: sLevel andSponsorSpecial: sSpecial andSponsorName: sName andBoothnumber: bNumber andSponsorWebsite:sWebsite andSponsorImage:sImage];
//                
//                //Add our sessions object to our exhibitHallArray
//                [sponsorsArray addObject:mySponsors];
//                
//                
//            }
//            
//            
//        });
//    });

    
    [self.tableView reloadData];

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
    return sponsorsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SponsorCell";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    SponsorsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[SponsorsViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    // Configure the cell...
    
    Sponsors * sponsors = nil;
    
    sponsors = [sponsorsArray objectAtIndex:indexPath.row];
    
    cell.sponsorName.text = sponsors.sponsorName;
    cell.sponsorName.font = [UIFont fontWithName:@"Arial" size:13.0];
    cell.sponsorName.textColor = [UIColor blueColor];
    
    cell.sponsorLevel.text = sponsors.sponsorLevel;
    cell.sponsorLevel.font = [UIFont fontWithName:@"Arial" size:12.0];
    cell.sponsorLevel.textColor = [UIColor brownColor];
    
    cell.sponsorSpecial.text = sponsors.sponsorSpecial;
    cell.sponsorSpecial.font = [UIFont fontWithName:@"Arial" size:11.0];
    
    cell.boothNumber.text = sponsors.boothNumber;
    cell.boothNumber.font = [UIFont fontWithName:@"Arial" size:11.0];
    


    
//        cell.sponsorName.userInteractionEnabled = YES;
//        UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openUrl:)];
//        [cell.sponsorName addGestureRecognizer:gr];
//        gr.numberOfTapsRequired = 1;
//        gr.cancelsTouchesInView = NO;
//        [self.view addSubview:cell.sponsorName];
    
    return cell;

}

//- (void) openUrl: (UITapGestureRecognizer *) gr {
//    NSURL *url = [NSURL URLWithString:@"http://www.bicsi.org"];
//	[[UIApplication sharedApplication] openURL:url];
//}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row%2 == 0) {
        UIColor *altCellColor = [UIColor colorWithWhite:0.7 alpha:0.1];
        cell.backgroundColor = altCellColor;
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SponsorDetailCell"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        SponsorsDetailViewController *destViewController = segue.destinationViewController;
        destViewController.sponsors = [sponsorsArray objectAtIndex:indexPath.row];
        
    }
}


@end
