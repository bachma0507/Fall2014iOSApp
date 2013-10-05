//
//  EHSchedule.m
//  Fall2013IOSApp
//
//  Created by Barry on 6/18/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "EHSchedule.h"

@implementation EHSchedule

@synthesize scheduleID;
@synthesize scheduleDate;
@synthesize sessionName;
@synthesize sessionTime;




-(id) initWithScheduleID: (NSString *) sID andScheduleDate: (NSString *) sDate andSessionName: (NSString *) sName andSessionTime: (NSString *) sTime
{
    self = [super init];
    if (self) {
        
        scheduleID = sID;
        scheduleDate = sDate;
        sessionName = sName;
        sessionTime = sTime;
        
    }
    return self;
}

@end
