//
//  SubmitMemberIDViewController.m
//  Fall2014IOSApp
//
//  Created by Barry on 8/5/14.
//  Copyright (c) 2014 BICSI. All rights reserved.
//

#import "SubmitMemberIDViewController.h"
#import "KeychainItemWrapper.h"

@interface SubmitMemberIDViewController ()

{
    KeychainItemWrapper *keychainItem;
}

@end

@implementation SubmitMemberIDViewController
@synthesize json, functionsArray, objects;


- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


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
    
    keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"BICSIMemberID" accessGroup:nil];
//    NSString *password = [keychainItem objectForKey:(__bridge id)(kSecValueData)];
//    NSLog(@"Keychain password = %@", password);
    NSString *username = [keychainItem objectForKey:(__bridge id)(kSecAttrAccount)];
    NSLog(@"Keychain username = %@", username);
    if ([username isEqualToString:@""]) {
        NSLog(@"Username is null");
    }
    else
    {
        [self.txtUsername setText:[keychainItem objectForKey:(__bridge id)(kSecAttrAccount)]];
        //[self.txtPassword setText:[keychainItem objectForKey:(__bridge id)(kSecValueData)]];
    }

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginClicked:(id)sender {
    
    
    
    //NSInteger success = 0;
    @try {
        
        
        
        if([[self.txtUsername text] isEqualToString:@""]) {
            
            [self alertStatus:@"Please enter Member ID" :@"Sign in Failed!" :0];
            
        } else {
            
            
            
            NSString *post =[[NSString alloc] initWithFormat:@"sess=CN-FALL-CA-0914&custcd=%@",[self.txtUsername text]];
            
            NSLog(@"PostData: %@",post);
            
            NSString * webURL = [[NSString alloc] initWithFormat:@"https://dev-webservice.bicsi.org/json/reply/MobFunctions?sess=CN-FALL-CA-0914&custcd=%@", [self.txtUsername text]];
            
            
            NSURL *url=[NSURL URLWithString:webURL];
            
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            
            NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:url];
            [request setHTTPMethod:@"POST"];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:postData];
            
            
            NSError *error = [[NSError alloc] init];
            NSHTTPURLResponse *response = nil;
            NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            
            NSLog(@"Response code: %ld", (long)[response statusCode]);
            
            if ([response statusCode] >= 200 && [response statusCode] < 300)
            {
                NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
                NSLog(@"Response ==> %@", responseData);
                
                //NSError *error = nil;
//                NSDictionary *jsonData = [NSJSONSerialization
//                                          JSONObjectWithData:urlData
//                                          options:NSJSONReadingMutableContainers
//                                          error:&error];
                
                //TRUNCATE FRONT AND END OF JSON. ALSO JSON STATEMENT AND CHANGE SESSIONDATE DATE FORMAT
                            NSString * dataStr = [[NSString alloc] initWithData: urlData encoding:NSUTF8StringEncoding];
                            NSString *newDataStr = [dataStr substringWithRange:NSMakeRange(13, [dataStr length]-13)];
                            NSString *truncDataStr = [newDataStr substringToIndex:[ newDataStr length]-1 ];
                //
                //
                //            NSLog(@"After truncated from front: %@", newDataStr);
                            NSLog(@"After truncated from end: %@", truncDataStr);
                //            
                            NSData* truncData = [truncDataStr dataUsingEncoding:NSUTF8StringEncoding];

                
                
                json = [NSJSONSerialization JSONObjectWithData:truncData options:kNilOptions error:nil];
                
//                if([(NSString *) [json objectAtIndex:0] isEqualToString:@"error_message"]){
//                    
//                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
//                                                                        message:@"No records found!"
//                                                                       delegate:self
//                                                              cancelButtonTitle:@"Ok"
//                                                              otherButtonTitles:nil, nil];
//                    
//                    [alertView show];
//
//                    
//                }
//                
//                else{
                
                functionsArray = [[NSMutableArray alloc] init];
                
                for (int i = 0; i < json.count; i++) {
                    //create functions object
                    NSString * fFunctioncd = [[json objectAtIndex:i] objectForKey:@"FUNCTIONCD"];
                
                    
                    Functions * myFunctions = [[Functions alloc]initWithFunctionCD:fFunctioncd];
                    
                    [functionsArray addObject:myFunctions];
                
                NSManagedObjectContext *context2 = [self managedObjectContext];
                
                NSFetchRequest *fetchRequest2 = [[NSFetchRequest alloc] init];
                
                NSEntityDescription *entity2 = [NSEntityDescription entityForName:@"Sessions" inManagedObjectContext:context2];
                [fetchRequest2 setEntity:entity2];
                
                [fetchRequest2 setPredicate:[NSPredicate predicateWithFormat:@"sessionID == %@", myFunctions.functioncd]];
                    
                NSArray *results2 = [self.managedObjectContext executeFetchRequest:fetchRequest2 error:nil];
                    
                    NSLog(@"MyFunctions.functioncd is : %@", myFunctions.functioncd);
                
                self.objects = results2;
                
                NSManagedObject *object = [results2 objectAtIndex:0];
                [object setValue:@"Yes" forKey:@"planner"];
                    
                    NSError *error = nil;
                    // Save the object to persistent store
                    if (![context2 save:&error]) {
                        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);}
                    
                    
                    NSManagedObjectContext *context = [self managedObjectContext];
                    
                    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Sessnotes" inManagedObjectContext:context];
                    
                    [newManagedObject setValue:[object valueForKey:@"sessionID"] forKey:@"sessionID"];
                    [newManagedObject setValue:[object valueForKey:@"sessionName"] forKey: @"sessionname"];
                    [newManagedObject setValue:[object valueForKey:@"sessionDate"] forKey:@"sessiondate"];
                    
                            NSDateFormatter *df = [[NSDateFormatter alloc] init];
                            [df setDateFormat:@"hh:mm a"];
                            NSString *sessStartTime = [df stringFromDate: [object valueForKey:@"startTime"]];
                    
                            NSDateFormatter *df2 = [[NSDateFormatter alloc] init];
                            [df2 setDateFormat:@"hh:mm a"];
                            NSString *sessEndTime = [df2 stringFromDate: [object valueForKey:@"endTime"]];
                    
                    NSString * sessionTimeStr = [[NSString alloc]initWithFormat:@"%@ - %@", sessStartTime, sessEndTime];
                    
                    [newManagedObject setValue:sessionTimeStr forKey:@"sessiontime"];
                    [newManagedObject setValue:[object valueForKey:@"location"] forKey:@"location"];
                    
                    [newManagedObject setValue:[object valueForKey:@"startTime"] forKey:@"starttime"];
                    //[newManagedObject setValue:newDeviceID forKey:@"deviceowner"];
                    [newManagedObject setValue:@"Yes" forKey:@"agenda"];
                    
                    NSError *error2 = nil;
                    // Save the object to persistent store
                    if (![context save:&error]) {
                        NSLog(@"Can't Save! %@ %@", error2, [error2 localizedDescription]);
                    }

                //}
                    
                    [keychainItem setObject:[self.txtUsername text] forKey:(__bridge id)(kSecAttrAccount)];
                    
                    [self performSegueWithIdentifier:@"submit_success" sender:self];
                
                }
                
//                success = [jsonData[@"success"] integerValue];
//                NSLog(@"Success: %ld",(long)success);
//                
//                if(success == 1)
//                {
//                    NSLog(@"Login SUCCESS");
//                    [keychainItem setObject:[self.txtPassword text] forKey:(__bridge id)(kSecValueData)];
//                    [keychainItem setObject:[self.txtUsername text] forKey:(__bridge id)(kSecAttrAccount)];
//                } else {
//                    
//                    NSString *error_msg = (NSString *) jsonData[@"error_message"];
//                    [self alertStatus:error_msg :@"Sign in Failed!" :0];
//                }
                
            } else {
                //if (error) NSLog(@"Error: %@", error);
                [self alertStatus:@"Connection Failed" :@"Sign in Failed!" :0];
            }
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"Sign in Failed." :@"Error!" :0];
    }
//    if (success) {
//        
//        //[self performSegueWithIdentifier:@"login_success" sender:self];
//        
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"   bundle:nil];
//        
//        issuesTableViewController *it = [storyboard instantiateViewControllerWithIdentifier:@"issuesTableID" ];
//        
//        [self presentViewController:it animated:YES completion:NULL];
//        
//        //[self dismissViewControllerAnimated:YES completion:NULL];
//        [[self presentingViewController] dismissViewControllerAnimated:NO completion:nil];
//    }
    
}

- (IBAction)skipClicked:(id)sender {
    
    [self performSegueWithIdentifier:@"submit_success" sender:self];
}

- (void) alertStatus:(NSString *)msg :(NSString *)title :(int) tag
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    alertView.tag = tag;
    [alertView show];
    
}

@end
