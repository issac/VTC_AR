//
//  cameraAnnotationAppDelegate.m
//  cameraAnnotation
//
//  Created by Fu Chun Hsu on 2010/5/15.
//  Copyright EvangelistVision 2010. All rights reserved.
//

#import "cameraAnnotationAppDelegate.h"
#import "FirstViewController.h"
@implementation cameraAnnotationAppDelegate

@synthesize window;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    

    // Override point for customization after application launch
	window = [[UIWindow alloc] initWithFrame:
			  [[UIScreen mainScreen] bounds]];
	
	UINavigationController *nav = [[[UINavigationController alloc]initWithRootViewController:[[FirstViewController alloc] init]]autorelease];
	
	[window addSubview:nav.view];
//	[nav release];
    [window makeKeyAndVisible];
	
	return YES;
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
