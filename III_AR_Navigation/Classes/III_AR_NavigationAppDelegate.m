//
//  III_AR_NavigationAppDelegate.m
//  III_AR_Navigation
//
//  Created by Chun F.Hsu on 2010/4/9.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "III_AR_NavigationAppDelegate.h"


@implementation III_AR_NavigationAppDelegate

@synthesize window;
@synthesize tabBarController;
@synthesize lastedViewController;
@synthesize FirstViewController;
@synthesize SecondViewController;

//@synthesize myNavController;
//@synthesize firstViewController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    // Check the device at this part
	sleep(5);
	[[UIApplication sharedApplication] setStatusBarHidden:NO];
	//[application setStatusBarHidden:YES animated:NO];
	CLLocationManager *locManager = [[CLLocationManager alloc] init];
	if ((locManager.headingAvailable && locManager.locationServicesEnabled)==NO) {
		UIAlertView *servicesDisabledAlert = [[UIAlertView alloc] initWithTitle:@"Location Services Disabled" message:@"You currently have all location services for this device disabled. If you proceed, you will be asked to confirm whether location services should be reenabled." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[servicesDisabledAlert show];
		[servicesDisabledAlert release];
	}
	
		[locManager release];
		locManager =nil;
	
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]==NO)
		//	[self getStarted:nil];
    {
		NSLog(@"很抱歉此產品需要配搭相機功能方可使用 \n EvangelistVision Group");
	}
    // Add the tab bar controller's current view as a subview of the window
	//issac
	//lastedViewController = nil;
	lastedViewController = FirstViewController;
    [window addSubview:tabBarController.view];
	
	//[window addSubview:myNavController.view];
	[window makeKeyAndVisible];
}


// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewControllers {
    NSLog(@"%@",[[viewControllers class]description]);

	//if (![viewControllers isKindOfClass:[ARSecondeViewController class]]) {
	if (![viewControllers isKindOfClass:[UINavigationController class]]) {
		//[viewControllers  dismissModalViewControllerAnimated:YES];
		//[viewControllers viewWillAppear:YES];
	}
	else {
		[viewControllers  dismissModalViewControllerAnimated:YES];
		//[viewControllers viewWillAppear:YES];
	}
	
	//if (lastedViewController == nil) {
	//	lastedViewController = viewControllers;
	//}
	//if(lastedViewController != viewControllers)
	//if(![viewControllers isMemberOfClass:[ARFirstViewController class]])
	
/*	if(lastedViewController != viewControllers)
	{
		//[lastedViewController dismissModalViewControllerAnimated:YES];
		
		if((lastedViewController == SecondViewController))
			//[FirstViewController start];
		lastedViewController = viewControllers;
	}
*/
}


/*
// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
}
*/


- (void)dealloc {
    [tabBarController release];
	//[firstViewController release];
    [window release];
    [super dealloc];
}

@end

