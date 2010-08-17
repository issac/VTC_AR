//
//  ARDataSingleton.h
//  III_AR_Navigation
//
//  Created by Chun F.Hsu on 2010/5/3.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface ARDataSingleton : NSObject {
	CLLocation *myLocation;
}
@property (nonatomic, retain)CLLocation *myLocation;
+(ARDataSingleton *) sharedData;
@end
