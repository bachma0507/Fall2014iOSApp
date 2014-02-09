//
//  HotelsViewController.h
//  Fall2013IOSApp
//
//  Created by Barry on 6/21/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "hotels.h"

@interface HotelsViewController : UIViewController

@property (nonatomic, strong) NSMutableArray * json;
@property (nonatomic, strong) NSMutableArray * hotelsArray;

@property (nonatomic, strong) NSString * name;


@property (strong, nonatomic) IBOutlet UILabel *hotelNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *hotelAddressLabel;
@property (strong, nonatomic) IBOutlet UILabel *hotelCityLabel;

@property (strong, nonatomic) IBOutlet UILabel *hotelStateLabel;

@property (strong, nonatomic) IBOutlet UILabel *hotelZipLabel;

@property (strong, nonatomic) IBOutlet UILabel *hotelTelephoneLabel;
@property (strong, nonatomic) IBOutlet UILabel *hotelCountryLabel;
@property (strong, nonatomic) IBOutlet UILabel *hotelWebsite;
@property (strong, nonatomic) IBOutlet UILabel *resDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *groupCodeLabel;

@property (strong, nonatomic) IBOutlet UITextView *hotelDescTextView;
@property (strong, nonatomic) IBOutlet UILabel *alertLineLabel;
@property (strong, nonatomic) IBOutlet UIImageView *hotelImageView;

- (IBAction)resButtonPressed:(id)sender;

@property (nonatomic, strong) hotels * hotels;
- (IBAction)buttonPressed:(id)sender;

//#pragma mark - Methods
-(void) retrieveData;
//- (void)fetchedData:(NSData *)responseData;

@end
