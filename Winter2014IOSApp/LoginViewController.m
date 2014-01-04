//
//  LoginViewController.m
//  Winter2014IOSApp
//
//  Created by Barry on 10/11/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"

#import <Parse/Parse.h>

@implementation LoginViewController

@synthesize userTextField = _userTextField, passwordTextField = _passwordTextField, facebookLoginButton, createUserButton;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //Delete me
    //self.userTextField.text = @"Antonio";
    //self.passwordTextField.text = @"12345";
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    [TestFlight passCheckpoint:@"GalleryLoginPage-info-viewed"];
    
    // Release any retained subviews of the main view.
    self.userTextField = nil;
    self.passwordTextField = nil;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}



#pragma mark IB Actions

//Login button pressed
-(IBAction)logInPressed:(id)sender
{
    [TestFlight passCheckpoint:@"GalleryLoginButton-pressed"];
    
    [PFUser logInWithUsernameInBackground:self.userTextField.text password:self.passwordTextField.text block:^(PFUser *user, NSError *error) {
        if (user) {
            //Open the wall
            [self performSegueWithIdentifier:@"LoginSuccesful" sender:self];
        } else {
            //Something bad has ocurred
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
    }];
}

- (IBAction)loginButtonTouchHandler:(id)sender {
    
    // Set permissions required from the facebook user account
    NSArray *permissionsArray = @[ @"user_about_me"/*, @"user_relationships", @"user_birthday", @"user_location"*/];
    
    // Login PFUser using facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        //[_activityIndicator stopAnimating]; // Hide loading indicator
        
        if (!user) {
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:@"Uh oh. The user cancelled the Facebook login." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                [alert show];
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:@"There is a problem with your facebook log in. Please use another method to log in."/*[error description]*/ delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                [alert show];
            }
        } else if (user.isNew) {
            NSLog(@"User with facebook signed up and logged in!");
            //Open the wall
            [self performSegueWithIdentifier:@"LoginSuccesful" sender:self];
        } else {
            NSLog(@"User with facebook logged in!");
            //Open the wall
            [self performSegueWithIdentifier:@"LoginSuccesful" sender:self];
        }
    }];
    
    //[_activityIndicator startAnimating]; // Show loading indicator until login is finished
    
}

@end

