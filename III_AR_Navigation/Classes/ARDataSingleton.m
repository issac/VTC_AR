//
//  ARDataSingleton.m
//  III_AR_Navigation
//
//  Created by Chun F.Hsu on 2010/5/3.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ARDataSingleton.h"


@implementation ARDataSingleton
@synthesize myLocation;

static ARDataSingleton *sharedData = nil;

- (id)init
{
	if ( self = [super init] )
	{
		self.myLocation = [[CLLocation alloc] init];
	}
	return self;
}

+(ARDataSingleton *) sharedData {
	if (!sharedData) {
		sharedData = [[self alloc] init];
	}
	return sharedData;
}

//set location in coordinate2D
-(void) SetLocationData{ 
	//myCoordinate = malloc(sizeof(CLLocationCoordinate2D *) * 1);	//sizeof(struct *) * count
	
	//myCoordinate[0].latitude = 25.083754775873032;
	//myCoordinate[0].longitude = 121.55733263292502;
}

@end
