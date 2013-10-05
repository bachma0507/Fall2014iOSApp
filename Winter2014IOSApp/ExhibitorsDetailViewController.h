//
//  ExhibitorsDetailViewController.h
//  Fall2013IOSApp
//
//  Created by Barry on 6/26/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "exhibitors.h"
#import "ExhibitorNotesViewController.h"
#import <CoreData/CoreData.h>

@interface ExhibitorsDetailViewController : UIViewController <UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *boothNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *urlLabel;
@property (strong, nonatomic) IBOutlet UIWebView *myWebView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activity;

@property (strong, nonatomic) NSString *exhibitorName;
@property (strong, nonatomic) NSString *boothNumber;
@property (strong, nonatomic) NSString *coId;
@property (strong, nonatomic) NSString *eventId;
@property (strong, nonatomic) NSString *boothId;

@property (strong, nonatomic) NSArray *objects;

@property (nonatomic, strong) exhibitors * myExhibitors;

@property (strong, nonatomic) IBOutlet UIButton *favoritesButton;

- (IBAction)favoritesButtonPressed:(id)sender;

- (IBAction)buttonPressed:(id)sender;
@end
