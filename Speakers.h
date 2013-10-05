//
//  Speakers.h
//  Fall2013IOSApp
//
//  Created by Barry on 6/16/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Speakers : NSObject

@property (nonatomic, strong) NSString * speakerID;
@property (nonatomic, strong) NSString * speakerName;
@property (nonatomic, strong) NSString * speakerCompany;
@property (nonatomic, strong) NSString * speakerCity;
@property (nonatomic, strong) NSString * speakerState;
@property (nonatomic, strong) NSString * speakerCountry;
@property (nonatomic, strong) NSString * speakerBio;
@property (nonatomic, strong) NSString * speakerWebsite;
@property (nonatomic, strong) NSString * speakerPic;
@property (nonatomic, strong) NSString * session1;
@property (nonatomic, strong) NSString * session1Date;
@property (nonatomic, strong) NSString * session1Time;
@property (nonatomic, strong) NSString * session1Desc;
@property (nonatomic, strong) NSString * session2;
@property (nonatomic, strong) NSString * session2Date;
@property (nonatomic, strong) NSString * session2Time;
@property (nonatomic, strong) NSString * session2Desc;
@property (nonatomic, strong) NSString * sessionID;
@property (nonatomic, strong) NSString * sessionID2;
@property (nonatomic, strong) NSString * startTime;
@property (nonatomic, strong) NSString * endTime;
@property (nonatomic, strong) NSString * location;
@property (nonatomic, strong) NSString * sess2StartTime;
@property (nonatomic, strong) NSString * sess2EndTime;
@property (nonatomic, strong) NSString * location2;



//methods
-(id) initWithSpeakerID: (NSString *) sID andSpeakerName: (NSString *) sName andSpeakerCompany: (NSString *) sCompany andSpeakerCity: (NSString *) sCity andSpeakerState: (NSString *) sState andSpeakerCountry: (NSString *) sCountry andSpeakerBio: (NSString *) sBio andSpeakerWebsite: (NSString *) sWebsite andSpeakerPic: (NSString *) sPic andSession1: (NSString *) sSession1 andSession1Date: (NSString *) sSession1Date andSession1Time: (NSString *) sSession1Time andSession1Desc: (NSString *) sSession1Desc andSession2: (NSString *) sSession2 andSession2Date: (NSString *) sSession2Date andSession2Time: (NSString *) sSession2Time andSession2Desc: (NSString *) sSession2Desc andSessionID: (NSString *) sSessionID andSessionID2: (NSString *) sSessionID2 andStartTime: (NSString *) sStartTime andEndTime: (NSString *) sEndTime andLocation: (NSString *) sLocation andSess2StartTime: (NSString *) sSess2StartTime andSess2EndTime: (NSString *) sSess2EndTime andLocation2: (NSString *) sLocation2;


@end
