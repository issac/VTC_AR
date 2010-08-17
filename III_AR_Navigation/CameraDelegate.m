//
//  CameraDelegate.m
//  III_AR_Navigation
//
//  Created by Chun F.Hsu on 2010/4/9.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CameraDelegate.h"


@implementation CameraDelegate
@synthesize selectedImage;
- (void) dealloc
{
	[selectedImage release];
	[super dealloc];
}
@end
