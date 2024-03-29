//
//  Sessions.m
//  Fall2013IOSApp
//
//  Created by Barry on 7/11/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "Sessions.h"

@implementation Sessions

@synthesize ID;
@synthesize sessionStatus;
@synthesize sessionDay;
@synthesize sessionDate;
@synthesize sessionTime;
@synthesize sessionName;
@synthesize sessionSpeaker1;
@synthesize speaker1Company;
@synthesize sessionSpeaker2;
@synthesize speaker2Company;
@synthesize sessionSpeaker3;
@synthesize speaker3Company;
@synthesize sessionSpeaker4;
@synthesize speaker4Company;
@synthesize sessionSpeaker5;
@synthesize speaker5Company;
@synthesize sessionSpeaker6;
@synthesize speaker6Company;
@synthesize sessionDesc;
@synthesize ITSCECS;
@synthesize sessionID;
@synthesize startTime;
@synthesize endTime;
@synthesize location;
@synthesize startTimeStr;





-(id) initWithID: (NSString *) sID andSessionStatus: (NSString *) sStatus andSessionDay: (NSString *) sDay andSessionDate: (NSString *) sDate andSessionTime: (NSString *) sTime andSessionName: (NSString *) sName andSessionSpeaker1: (NSString *) sSpeaker1 andSpeaker1Company: (NSString *) sSpeaker1Company andSessionSpeaker2: (NSString *) sSpeaker2 andSpeaker2Company: (NSString *) sSpeaker2Company andSessionSpeaker3: (NSString *) sSpeaker3 andSpeaker3Company: (NSString *) sSpeaker3Company andSessionSpeaker4: (NSString *) sSpeaker4 andSpeaker4Company: (NSString *) sSpeaker4Company andSessionSpeaker5: (NSString *) sSpeaker5 andSpeaker5Company: (NSString *) sSpeaker5Company andSessionSpeaker6: (NSString *) sSpeaker6 andSpeaker6Company: (NSString *) sSpeaker6Company andSessionDesc: (NSString *) sDesc andITSCECS: (NSString *) sITSCECS andSessionID: (NSString *) sSessionID andStartTime: (NSString *) sStartTime andEndTime: (NSString *) sEndTime andLocation: (NSString *) sLocation andStartTimeStr:(NSString *)sStartTimeStr

{
    self = [super init];
    if (self) {
        ID = sID;
        sessionStatus = sStatus;
        sessionDay = sDay;
        sessionDate = sDate;
        sessionTime = sTime;
        sessionName = sName;
        sessionSpeaker1 = sSpeaker1;
        speaker1Company = sSpeaker1Company;
        sessionSpeaker2 = sSpeaker2;
        speaker2Company = sSpeaker2Company;
        sessionSpeaker3 = sSpeaker3;
        speaker3Company = sSpeaker3Company;
        sessionSpeaker4 = sSpeaker4;
        speaker4Company = sSpeaker4Company;
        sessionSpeaker5 = sSpeaker5;
        speaker5Company = sSpeaker5Company;
        sessionSpeaker6 = sSpeaker6;
        speaker6Company = sSpeaker6Company;
        sessionDesc = sDesc;
        ITSCECS = sITSCECS;
        sessionID = sSessionID;
        startTime = sStartTime;
        endTime = sEndTime;
        location = sLocation;
        startTimeStr = sStartTimeStr;
        
    }
    
    return self;
    
}


@end
