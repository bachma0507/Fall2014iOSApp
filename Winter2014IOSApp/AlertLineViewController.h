//
//  AlertLineViewController.h
//  Fall2013IOSApp
//
//  Created by Barry on 6/22/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "hotels.h"

@interface AlertLineViewController : UIViewController

@property (nonatomic, strong) NSMutableArray * json;
@property (nonatomic, strong) NSMutableArray * hotelsArray;

@property (strong, nonatomic) IBOutlet UITextView *alertLineTextView;

@property (nonatomic, strong) hotels * hotels;


//- (void)fetchedData:(NSData *)responseData;
-(void)retrieveData;
@end
