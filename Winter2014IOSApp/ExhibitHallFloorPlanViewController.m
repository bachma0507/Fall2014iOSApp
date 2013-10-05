//
//  ExhibitHallFloorPlanViewController.m
//  Fall2013IOSApp
//
//  Created by Barry on 6/18/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "ExhibitHallFloorPlanViewController.h"
#import "SVWebViewController.h"

@interface ExhibitHallFloorPlanViewController ()

@end

@implementation ExhibitHallFloorPlanViewController
@synthesize webView;
@synthesize activity;

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
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;

	// Do any additional setup after loading the view.
    
    NSString *httpSource = @"http://s23.a2zinc.net/clients/BICSI/fall2013//Public/GeneratePDF.aspx?IMID=undefined&EventId=20&MapId=20";
    //NSString *httpSource = @"http://www.chirpe.com/Floorplan.aspx?EventID=2027";
    NSURL *fullUrl = [NSURL URLWithString:httpSource];
    NSURLRequest *httpRequest = [NSURLRequest requestWithURL:fullUrl];
    [webView loadRequest:httpRequest];
    
//    NSString * myURL = [NSString stringWithFormat:@"http://www.chirpe.com/Floorplan.aspx?EventID=2027"];
//    NSURL *URL = [NSURL URLWithString:myURL];
//	SVWebViewController *webViewController = [[SVWebViewController alloc] initWithURL:URL];
//	[self.navigationController pushViewController:webViewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webViewDidStartLoad:(UIWebView *)WebView
{
    [activity startAnimating];
    
    
}

-(void)webViewDidFinishLoad:(UIWebView *)WebView
{
    [activity stopAnimating];
    activity.hidden = TRUE;
    
}

- (IBAction)handlePinch:(UIPinchGestureRecognizer *)recognizer {
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    recognizer.scale = 1;
}

- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    
}

@end
