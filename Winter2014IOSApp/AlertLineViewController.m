//
//  AlertLineViewController.m
//  Fall2013IOSApp
//
//  Created by Barry on 6/22/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "AlertLineViewController.h"

@interface AlertLineViewController ()

@end

//set up background process macro to get to data URL
//#define kBgQueue dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1
//#define getDataURL [NSURL URLWithString: @"http://speedyreference.com/hotels.php"] //2

@implementation AlertLineViewController
@synthesize alertLineTextView, json, hotels, hotelsArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //download data using background Grand Central dispatch process called from macro
//    dispatch_async(kBgQueue, ^{
//        NSData* data = [NSData dataWithContentsOfURL:
//                        getDataURL];
//        [self performSelectorOnMainThread:@selector(fetchedData:)
//                               withObject:data waitUntilDone:YES];
//    });
    
    [self retrieveData];
        
}

- (void)retrieveData
{
    NSURL * url = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"hotels-json.json" ofType:nil]];
    NSData * data = [NSData dataWithContentsOfURL:url];
    
    json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    //Set up our hotelss array
    hotelsArray = [[NSMutableArray alloc] init];
    
    //interate through JSON fetched data
    for (int i = 0; i < json.count; i++) {
        
        NSString * hID = [[json objectAtIndex:i] objectForKey:@"id"];
        NSString * hStatus = [[json objectAtIndex:i] objectForKey:@"hotelStatus"];
        NSString * hName = [[json objectAtIndex:i] objectForKey:@"hotelName"];
        NSString * hAddress = [[json objectAtIndex:i] objectForKey:@"hotelAddress"];
        NSString * hCity = [[json objectAtIndex:i] objectForKey:@"hotelCity"];
        NSString * hState = [[json objectAtIndex:i] objectForKey:@"hotelState"];
        NSString * hZip = [[json objectAtIndex:i] objectForKey:@"hotelZip"];
        NSString * hAlert = [[json objectAtIndex:i] objectForKey:@"hotelAlert"];
        NSString * hCountry = [[json objectAtIndex:i] objectForKey:@"hotelCountry"];
        NSString * hTelephone = [[json objectAtIndex:i] objectForKey:@"hotelTelephone"];
        NSString * hWebsite = [[json objectAtIndex:i] objectForKey:@"hotelWebsite"];
        NSString * hResWebsite = [[json objectAtIndex:i] objectForKey:@"hotelResWebsite"];
        NSString * hDescription = [[json objectAtIndex:i] objectForKey:@"hotelDescription"];
        NSString * hGroupCode = [[json objectAtIndex:i] objectForKey:@"groupCode"];
        NSString * hResDate = [[json objectAtIndex:i] objectForKey:@"resDate"];
        NSString * hAlertLine = [[json objectAtIndex:i] objectForKey:@"alertLine"];
        
        //instantiate myHotel object using data objects from JSON iteration
        hotels * myHotel = [[hotels alloc] initWithHoteID: hID andHotelStatus: hStatus andHotelName: hName andHotelAddress: hAddress andHotelCity: hCity andHotelState: hState andHotelZip: hZip andHotelTelephone:  hTelephone andHotelWebsite: hWebsite andHotelResWebsite: hResWebsite andHotelDescription: hDescription andHotelAlert: hAlert andHotelCountry: hCountry andGroupCode: hGroupCode andResDate: hResDate andAlertLine:hAlertLine];
        
        //Add our myHotel object to our hotelsArray
        [hotelsArray addObject:myHotel];
        
        //create instance of hotels and assign it to index 0 in array
        hotels * hotel = [hotelsArray objectAtIndex:0];
        
        //assign textview text property to hotelAlert property of instance
        alertLineTextView.text = hotel.hotelAlert;

    }
    
    
    
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
