//
//  FirstViewController.h
//  0424TabPractice
//
//  Created by Fu Chun Hsu on 2010/4/23.
//  Copyright EvangelistVision 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "myCameraDelegate.h"
#import	<MapKit/MapKit.h>
#import "CallOutView.h"
#import <QuartzCore/QuartzCore.h>
#import "SFAnnotation.h"

//#import "locationDelegate.h"
//#import "positionMaker.h"
@interface FirstViewController : UIViewController<MKMapViewDelegate, UIAccelerometerDelegate
													, UINavigationControllerDelegate
													, UIImagePickerControllerDelegate
													, CLLocationManagerDelegate>{
	UIImagePickerController *camera;
	CallOutView *myview;
	NSMutableArray *annoArray ; 
	UIView *back;

	
	//issac
	CLLocationManager *locManager;
	CLLocationCoordinate2D updatedLocation;
	double northRotateAngle;
	CGAffineTransform myDistort;
	CLLocation *locationCurrent;
														
}
@property (nonatomic, retain)CLLocation *locationCurrent;
@property (nonatomic,retain) UIImagePickerController *camera;
@property (nonatomic,retain) NSMutableArray *annoArray;
//@property (nonatomic, retain)locationDelegate *locDelegate;
@property (nonatomic,retain)CallOutView *myview;

@property (nonatomic, retain)UIView *back;
//@property (nonatomic,retain) myCameraDelegate *cameraDelegate;


//issac
@property (nonatomic,retain)CLLocationManager *locManager;

@end
