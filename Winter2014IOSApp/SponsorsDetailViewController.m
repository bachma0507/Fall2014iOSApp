//
//  SponsorsDetailViewController.m
//  Fall2013IOSApp
//
//  Created by Barry on 6/21/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "SponsorsDetailViewController.h"
#import "SVWebViewController.h"

@interface SponsorsDetailViewController ()

@end

@implementation SponsorsDetailViewController

@synthesize name;
@synthesize image;
@synthesize website;
@synthesize sponsors;
@synthesize sponsorsNameLabel;
@synthesize sponsorsImage;
@synthesize sponsorsWebsite;

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
    
    self.title = sponsors.sponsorName;
    
    //set our labels
    sponsorsNameLabel.text = sponsors.sponsorName;
    sponsorsNameLabel.font = [UIFont fontWithName:@"Arial" size:17.0];
    sponsorsNameLabel.textColor = [UIColor blueColor];
    
    NSString * myURL = [NSString stringWithFormat:@"%@", sponsors.sponsorImage];
    
    UIImage* myImage = [UIImage imageWithData:
                        [NSData dataWithContentsOfURL:
                         [NSURL URLWithString: myURL]]];
    
    //NSString * myImage = [NSString stringWithFormat:@"%@", sponsors.sponsorImage];
    [sponsorsImage setImage:myImage];
    //sponsorsImage.image = [UIImage imageNamed:myImage];
    
    
    //speakerWebsite.text = speakers.speakerWebsite;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(id)sender {
    
    NSString * myURL = [NSString stringWithFormat:@"%@", sponsors.sponsorWebsite];
//    NSURL *url = [NSURL URLWithString:myURL];
//	[[UIApplication sharedApplication] openURL:url];
    NSURL *URL = [NSURL URLWithString:myURL];
	SVWebViewController *webViewController = [[SVWebViewController alloc] initWithURL:URL];
	[self.navigationController pushViewController:webViewController animated:YES];

}
@end
