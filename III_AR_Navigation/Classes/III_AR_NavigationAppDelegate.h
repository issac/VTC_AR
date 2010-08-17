//
//  III_AR_NavigationAppDelegate.h
//  III_AR_Navigation
//
//  Created by Chun F.Hsu on 2010/4/9.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ARFirstViewController.h"
#import "ARSecondeViewController.h"

@interface III_AR_NavigationAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
	
	//UINavigationController *myNavController;
	//ARFirstViewController *firstViewController;
	
	UIViewController *lastedViewController;
	UIViewController *FirstViewController;
	UIViewController *SecondViewController;
}
//@property (nonatomic,retain) IBOutlet ARFirstViewController *firstViewController;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) IBOutlet UIViewController *lastedViewController;
@property (nonatomic, retain) IBOutlet UIViewController *FirstViewController;
@property (nonatomic, retain) IBOutlet UIViewController *SecondViewController;

//@property (nonatomic, retain) IBOutlet UINavigationController *myNavController;

@end
