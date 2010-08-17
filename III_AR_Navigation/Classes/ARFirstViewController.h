//
//  ARFirstViewController.h
//  III_AR_Navigation
//
//  Created by Chun F.Hsu on 2010/4/9.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CameraDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "SFAnnotation.h"
#import "CallOutView.h"
#import "ARDataSingleton.h"

@interface ARFirstViewController : UIViewController <CLLocationManagerDelegate,MKMapViewDelegate, UIAccelerometerDelegate> {
	UIImagePickerController *camera; 
	CameraDelegate *myCameraDelegate;
	CLLocationManager *locManager;
	CLLocationCoordinate2D updatedLocation;
	IBOutlet UILabel *headingLabel;
	IBOutlet UIImageView *arrowView;
	double northRotateAngle;
	MKMapView *myMap;
	CGAffineTransform myDistort;
	float AccX;
	float AccY;
	float AccZ;
	float X;
	float Y;
	double max_angle;
	//UIImagePickerController *camera;
	//CallOutView *myview;
	NSMutableArray *annoArray; 
	NSMutableArray *viewArray;
	NSMutableDictionary *annoViewDictionary;
	UIView *back;
	CLLocation *locationCurrent;
	
	//alert
	UIAlertView *baseAlert;
	
	//update Timer
	NSTimer *updateTimer;
	CLLocationDirection updatedHeading;
	double maxdistance;
	
	
	MKCoordinateRegion region;
	
}
@property (nonatomic,retain)IBOutlet MKMapView *myMap;
@property (nonatomic,retain)IBOutlet UILabel *headingLabel;
@property (nonatomic,retain)CLLocationManager *locManager;
@property (nonatomic,retain)UIImagePickerController *camera;
@property (nonatomic,retain)CameraDelegate *myCameraDelegate;
@property (nonatomic,retain)UIImageView *arrowView;

@property (nonatomic,retain) NSMutableArray *annoArray;
@property (nonatomic,retain) NSMutableArray *viewArray;
@property (nonatomic,retain) NSMutableDictionary *annoViewDictionary;
//@property (nonatomic,retain)CallOutView *myview;
@property (nonatomic, retain)UIView *back;
@property (nonatomic, retain)CLLocation *locationCurrent;

@property (nonatomic, retain)UIAlertView *baseAlert;

@property (nonatomic, retain)NSTimer *updateTimer;
@property (nonatomic, assign)double maxdistance;
@property (nonatomic, assign)double max_angle;
-(void) drawAnnotation:(double)distanceM;
-(double) initialGeoLocation:(CLLocation *)localCurrent;
-(void) action;
-(CGPoint) CALlocation:(SFAnnotation *)annotation Maxdistance:(double)distanceM;
-(void)updateHeading:(NSTimer *)timer;

@end
