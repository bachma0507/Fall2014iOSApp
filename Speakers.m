//
//  Speakers.m
//  Fall2013IOSApp
//
//  Created by Barry on 6/16/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "Speakers.h"

@implementation Speakers

@synthesize speakerID;
@synthesize speakerName;
@synthesize speakerCompany;
@synthesize speakerCity;
@synthesize speakerState;
@synthesize speakerCountry;
@synthesize speakerBio;
@synthesize speakerWebsite;
@synthesize speakerPic;
@synthesize session1;
@synthesize session1Date;
@synthesize session1Time;
@synthesize session1Desc;
@synthesize session2;
@synthesize session2Date;
@synthesize session2Time;
@synthesize session2Desc;
@synthesize sessionID;
@synthesize sessionID2;
@synthesize startTime;
@synthesize endTime;
@synthesize location;
@synthesize sess2StartTime;
@synthesize sess2EndTime;
@synthesize location2;



-(id) initWithSpeakerID: (NSString *) sID andSpeakerName: (NSString *) sName andSpeakerCompany: (NSString *) sCompany andSpeakerCity: (NSString *) sCity andSpeakerState: (NSString *) sState andSpeakerCountry: (NSString *) sCountry andSpeakerBio: (NSString *) sBio andSpeakerWebsite: (NSString *) sWebsite andSpeakerPic: (NSString *) sPic andSession1: (NSString *) sSession1 andSession1Date: (NSString *) sSession1Date andSession1Time: (NSString *) sSession1Time andSession1Desc: (NSString *) sSession1Desc andSession2:(NSString *)sSession2 andSession2Date:(NSString *)sSession2Date andSession2Time:(NSString *)sSession2Time andSession2Desc:(NSString *)sSession2Desc andSessionID:(NSString *)sSessionID andSessionID2:(NSString *)sSessionID2 andStartTime: (NSString *) sStartTime andEndTime: (NSString *) sEndTime andLocation: (NSString *) sLocation andSess2StartTime: (NSString *) sSess2StartTime andSess2EndTime: (NSString *) sSess2EndTime andLocation2: (NSString *) sLocation2
{
    self = [super init];
    if (self) {
        speakerID = sID;
        speakerName = sName;
        speakerCompany = sCompany;
        speakerCity = sCity;
        speakerState = sState;
        speakerCountry = sCountry;
        speakerBio = sBio;
        speakerWebsite = sWebsite;
        speakerPic = sPic;
        session1 = sSession1;
        session1Date = sSession1Date;
        session1Time = sSession1Time;
        session1Desc = sSession1Desc;
        session2 = sSession2;
        session2Date = sSession2Date;
        session2Time = sSession2Time;
        session2Desc = sSession2Desc;
        sessionID = sSessionID;
        sessionID2 = sSessionID2;
        startTime = sStartTime;
        endTime = sEndTime;
        location = sLocation;
        sess2StartTime = sSess2StartTime;
        sess2EndTime = sSess2EndTime;
        location2 = sLocation2;
        
    }
    
    return self;
}


@end
