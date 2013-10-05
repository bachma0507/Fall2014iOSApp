//
//  CoursesViewController.h
//  Fall2013IOSApp
//
//  Created by Barry on 6/27/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoursesViewController : UIViewController <UIWebViewDelegate>
- (IBAction)dcdcButtonPressed:(id)sender;
- (IBAction)ospButtonPressed:(id)sender;
- (IBAction)itsButtonPressed:(id)sender;
- (IBAction)essButtonPressed:(id)sender;
- (IBAction)tpmButtonPressed:(id)sender;

@property (strong, nonatomic) IBOutlet UIWebView *webView;



@end
