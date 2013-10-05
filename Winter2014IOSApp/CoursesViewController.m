//
//  CoursesViewController.m
//  Fall2013IOSApp
//
//  Created by Barry on 6/27/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "CoursesViewController.h"
#import "SVWebViewController.h"

@interface CoursesViewController ()

@end

@implementation CoursesViewController
@synthesize webView;

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
    
    webView.delegate = self;
    
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"exams.html" ofType:nil]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        [[UIApplication sharedApplication] openURL:request.URL];
        return false;
    }
    return true;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dcdcButtonPressed:(id)sender {
    
    NSString * myURL = [NSString stringWithFormat:@"https://www.bicsi.org/event_details.aspx?sessionaltcd=CL-DC125-NV-0913"];
    NSURL *URL = [NSURL URLWithString:myURL];
	SVWebViewController *webViewController = [[SVWebViewController alloc] initWithURL:URL];
	[self.navigationController pushViewController:webViewController animated:YES];
}

- (IBAction)ospButtonPressed:(id)sender {
    
    NSString * myURL = [NSString stringWithFormat:@"https://www.bicsi.org/event_details.aspx?sessionaltcd=CL-OSP110-NV-0913"];
    NSURL *URL = [NSURL URLWithString:myURL];
	SVWebViewController *webViewController = [[SVWebViewController alloc] initWithURL:URL];
	[self.navigationController pushViewController:webViewController animated:YES];
}

- (IBAction)itsButtonPressed:(id)sender {
    
    NSString * myURL = [NSString stringWithFormat:@"https://www.bicsi.org/event_details.aspx?sessionaltcd=CL-TE350-NV-0913"];
    NSURL *URL = [NSURL URLWithString:myURL];
	SVWebViewController *webViewController = [[SVWebViewController alloc] initWithURL:URL];
	[self.navigationController pushViewController:webViewController animated:YES];
}

- (IBAction)essButtonPressed:(id)sender {
    
    NSString * myURL = [NSString stringWithFormat:@"https://www.bicsi.org/event_details.aspx?sessionaltcd=CL-ESS110-NV-0913"];
    NSURL *URL = [NSURL URLWithString:myURL];
	SVWebViewController *webViewController = [[SVWebViewController alloc] initWithURL:URL];
	[self.navigationController pushViewController:webViewController animated:YES];
}

- (IBAction)tpmButtonPressed:(id)sender {
    
    NSString * myURL = [NSString stringWithFormat:@"https://www.bicsi.org/event_details.aspx?sessionaltcd=CL-PM110-NV-0913"];
    NSURL *URL = [NSURL URLWithString:myURL];
	SVWebViewController *webViewController = [[SVWebViewController alloc] initWithURL:URL];
	[self.navigationController pushViewController:webViewController animated:YES];
}

@end
