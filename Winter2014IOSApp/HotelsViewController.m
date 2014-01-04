//
//  HotelsViewController.m
//  Fall2013IOSApp
//
//  Created by Barry on 6/21/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "HotelsViewController.h"
#import "SVWebViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface HotelsViewController ()

@end


//#define kBgQueue dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1
//#define getDataURL [NSURL URLWithString: @"http://speedyreference.com/hotels.php"] //2

@implementation HotelsViewController
@synthesize hotelNameLabel, hotels, hotelsArray, json, hotelAddressLabel, hotelCityLabel, hotelStateLabel, hotelZipLabel, hotelTelephoneLabel, hotelCountryLabel, hotelWebsite, resDateLabel, groupCodeLabel, hotelDescTextView, alertLineLabel, hotelImageView;

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
    
    [TestFlight passCheckpoint:@"hotel-info-viewed"];
    
    //set backbutton customization for AlertLineViewController 
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    CALayer *layer = self.hotelImageView.layer;
    layer.masksToBounds = NO;
    layer.shadowRadius = 3.0f;
    layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
    layer.shadowOpacity = 0.5f;
    layer.shouldRasterize = YES;
    
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
    
    //Set up our hotels array
    hotelsArray = [[NSMutableArray alloc] init];
    
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
        
        hotels * myHotel = [[hotels alloc] initWithHoteID: hID andHotelStatus: hStatus andHotelName: hName andHotelAddress: hAddress andHotelCity: hCity andHotelState: hState andHotelZip: hZip andHotelTelephone:  hTelephone andHotelWebsite: hWebsite andHotelResWebsite: hResWebsite andHotelDescription: hDescription andHotelAlert: hAlert andHotelCountry: hCountry andGroupCode: hGroupCode andResDate: hResDate andAlertLine:hAlertLine];
        
        
        [hotelsArray addObject:myHotel];
        
        hotels * hotel = [hotelsArray objectAtIndex:0];
        
        hotelNameLabel.text = hotel.hotelName;
        hotelAddressLabel.text = hotel.hotelAddress;
        hotelCityLabel.text = hotel.hotelCity;
        hotelStateLabel.text = hotel.hotelState;
        hotelZipLabel.text = hotel.hotelZip;
        hotelTelephoneLabel.text = hotel.hotelTelephone;
        hotelCountryLabel.text = hotel.hotelCountry;
        resDateLabel.text = hotel.resDate;
        groupCodeLabel.text = hotel.groupCode;
        hotelDescTextView.text = hotel.hotelDescription;
        alertLineLabel.text = hotel.alertLine;
        
        [[hotelDescTextView layer] setBorderColor:[[UIColor colorWithRed:48/256.0 green:134/256.0 blue:174/256.0 alpha:1.0] CGColor]];
        [[hotelDescTextView layer] setBorderWidth:2.3];
        [[hotelDescTextView layer] setCornerRadius:10];
        [hotelDescTextView setClipsToBounds: YES];
        
        
        [hotelAddressLabel setNumberOfLines:0];
        [hotelAddressLabel sizeToFit];
        
        [self.view addSubview:hotelAddressLabel];

    }
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(id)sender {
    
    hotels * hotel = [hotelsArray objectAtIndex:0];
    
    NSString * myURL = [NSString stringWithFormat:@"%@", hotel.hotelWebsite];
//    NSURL *url = [NSURL URLWithString:myURL];
//	[[UIApplication sharedApplication] openURL:url];
    NSURL *URL = [NSURL URLWithString:myURL];
	SVWebViewController *webViewController = [[SVWebViewController alloc] initWithURL:URL];
	[self.navigationController pushViewController:webViewController animated:YES];

}

//- (IBAction)buttonPressedAlertLine:(id)sender {
//}

- (IBAction)resButtonPressed:(id)sender {
    
    hotels * hotel = [hotelsArray objectAtIndex:0];
    
    NSString * myURL = [NSString stringWithFormat:@"%@", hotel.hotelResWebsite];
//    NSURL *url = [NSURL URLWithString:myURL];
//	[[UIApplication sharedApplication] openURL:url];
    NSURL *URL = [NSURL URLWithString:myURL];
	SVWebViewController *webViewController = [[SVWebViewController alloc] initWithURL:URL];
	[self.navigationController pushViewController:webViewController animated:YES];
}
@end
