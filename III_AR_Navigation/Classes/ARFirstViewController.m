//
//  ARFirstViewController.m
//  III_AR_Navigation
//
//  Created by Chun F.Hsu on 2010/4/9.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ARFirstViewController.h"
#import <math.h>
#define showAlert(format, ...) myShowAlert(__LINE__, (char *)__FUNCTION__, format, ##__VA_ARGS__)
#define IMAGEPICKERSOURCE UIImagePickerControllerSourceTypeCamera
const double pii = 3.14159265;
const double range = 90.0f;
const double myTime = 0.2;

@implementation ARFirstViewController

@synthesize myCameraDelegate;
@synthesize camera;
@synthesize locManager;
@synthesize headingLabel;
@synthesize arrowView;
@synthesize myMap;

@synthesize annoArray;
@synthesize viewArray;
@synthesize annoViewDictionary;
@synthesize back;
@synthesize locationCurrent;

@synthesize baseAlert;
@synthesize maxdistance;
@synthesize max_angle;
@synthesize updateTimer;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/
void dumpViews(UIView* view, NSString *text, NSString *indent) 
{
    Class cl = [view class];
    NSString *classDescription = [cl description];
    while ([cl superclass]) 
    {
        cl = [cl superclass];
        classDescription = [classDescription stringByAppendingFormat:@":%@", [cl description]];
    }
	
    if ([text compare:@""] == NSOrderedSame)
        NSLog(@"%@ %@", classDescription, NSStringFromCGRect(view.frame));
    else
        NSLog(@"%@ %@ %@", text, classDescription, NSStringFromCGRect(view.frame));
	
    for (NSUInteger i = 0; i < [view.subviews count]; i++)
    {
        UIView *subView = [view.subviews objectAtIndex:i];
        NSString *newIndent = [[NSString alloc] initWithFormat:@"  %@", indent];
        NSString *msg = [[NSString alloc] initWithFormat:@"%@%d:", newIndent, i];
        dumpViews(subView, msg, newIndent);
        [msg release];
        [newIndent release];
    }
}
- (void) dumpView: (UIView *) aView atIndent: (int) indent into:(NSMutableString *) outstring
{
	for (int i = 0; i < indent; i++) [outstring appendString:@"--"];
	[outstring appendFormat:@"[%2d] %@\n", indent, [[aView class] description]];
	for (UIView *view in [aView subviews]) [self dumpView:view atIndent:indent + 1 into:outstring];
}

// Start the tree recursion at level 0 with the root view
- (NSString *) displayViews: (UIView *) aView
{
	NSMutableString *outstring = [[NSMutableString alloc] init];
	[self dumpView: self.view.window atIndent:0 into:outstring];
	return [outstring autorelease];
}

// Show the tree
- (void) displayViews
{
	CFShow([self displayViews: self.view.window]);
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
	
	updatedLocation = newLocation.coordinate;
	MKCoordinateRegion updateRegion;
	
	updateRegion.center = updatedLocation;
    MKCoordinateSpan span;
	
	span.latitudeDelta=.002;
	span.longitudeDelta=.002;
	updateRegion.span=span;	
	
	//issac stupid test 0520
/*	double max = 0.0;
	max = [self initialGeoLocation:newLocation];
	[self drawAnnotation:max];
*/
/*	if(locationCurrent == nil)
	{
		[self action];
		locationCurrent = [[CLLocation alloc] initWithLatitude:newLocation.coordinate.latitude
													 longitude:newLocation.coordinate.longitude];
		//locationCurrent =
	}
*/
	[myMap setRegion:updateRegion animated:YES];

	//NSTimeInterval howRecent = [newLocation.timestamp timeIntervalSinceNow];
	//double lon = newLocation.coordinate.longitude;
	//double lat = newLocation.coordinate.latitude;
	// This part sets the region 
	//[myMap showsUserLocation];	
	
	//	myMap.region = updateRegion;
	//	MKCoordinateRegion zoomOut = { { newLocation.coordinate.latitude , newLocation.coordinate.longitude }, {4, 4} };
	//	[myMap setRegion:zoomOut animated:YES];
	//	myMap.region.center= newLocation.coordinate; 
	//	myMap.region.span = {newLocation.horizontalAccuracy,newLocation.verticalAccuracy};
	//	[myMap setRegion:zoomOut  animated:YES];
	//	[self.view setNeedsDisplay];
	//	myMap.centerCoordinate = newLocation.coordinate;	
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
	//NS Timer
	updatedHeading = newHeading.trueHeading;
	//updatedHeading = newHeading.magneticHeading;
	//NSLog(@"%f", updatedHeading);
	
	//CGAffineTransform myDistort = CGAffineTransformIdentity;
	myDistort = CGAffineTransformIdentity;
	
	//northRotateAngle = (newHeading.magneticHeading>180)? 360-newHeading.magneticHeading : -(newHeading.magneticHeading);
	//issac 0608 trueheading
	northRotateAngle = (newHeading.trueHeading>180)? 360-newHeading.trueHeading : -(newHeading.trueHeading);
	//northRotateAngle = (newHeading.magneticHeading>180)? 360-newHeading.magneticHeading : -(newHeading.magneticHeading);
	double FinalAngle = (northRotateAngle/180)*pii;
	myDistort = CGAffineTransformRotate(myDistort, FinalAngle);

	//issac 0517
	//[back setTransform:myDistort];
	
	//issac 0531

	
	//issac test 0510 for arrow distort
	//AccX = cos(northRotateAngle)*X + sin(northRotateAngle)*Y;
	//AccY = cos(northRotateAngle)*Y + sin(northRotateAngle)*X;

	//myDistort = CGAffineTransformScale(myDistort, AccX, AccY);
	myDistort = CGAffineTransformScale(myDistort, 0.71, 0.71);
	[arrowView setTransform:myDistort];


	
	
	//northRotateAngle = (newHeading.trueHeading>180)? 360-newHeading.trueHeading : -(newHeading.trueHeading);
	//NSLog(@"%f %f %f %f", newHeading.x, newHeading.y, newHeading.z, newHeading.magneticHeading);
	//headingLabel.text = [NSString stringWithFormat:@"Heading%f, rotating angle:%f",newHeading.trueHeading, northRotateAngle ] ;
	//myDistort = CGAffineTransformMakeScale(0.5, 1);
	//myDistort = CGAffineTransformScale(myDistort, 2, 1);
	//myDistort = CGAffineTransformScale(myDistort, (1.2 - (1.2/128)*newHeading.z)  , (1.2 - (1.2/128)*newHeading.y));
	//NSLog(@"%f %f %f %f", ((1.2/128)*newHeading.z), newHeading.z,((1.2/128)*newHeading.y), newHeading.y);
	//[arrowView setTransform:CGAffineTransformScale(myDistort, (1 - 0.7/128*newHeading.z)  , (1 - 0.7/128*newHeading.y))];
	//[arrowView setTransform:CGAffineTransformRotate(myDistort, (northRotateAngle/180)*pi)];
	//[arrowView setTransform:transform];
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
//- (void)accelerometer:(UIAccelerometer *)sharedAccelerometer didAccelerate:(UIAcceleration *)acceleration
{
	//CGAffineTransform myDistortAcc = CGAffineTransformIdentity;
	//myDistort = CGAffineTransformIdentity;

	NSLog(@"%f %f %f", acceleration.x, acceleration.y, acceleration.z);
	
	AccZ = acceleration.z;
	
	
	
	//[arrowView setTransform:CGAffineTransformMakeScale((1.5 - fabs(acceleration.x))  , (1.5+0.3 - fabs(acceleration.y)))];
	//float xx = -[acceleration x];
	//float yy = [acceleration y];
	//NSLog(@"%f %f", xx, yy);
	//float angle = atan2(yy, xx);
	//myDistortAcc = CGAffineTransformRotate(myDistortAcc, angle);
	//myDistortAcc = CGAffineTransformScale(myDistortAcc, (1.5 - fabs(acceleration.x)), (1.5+0.3 - fabs(acceleration.y)));
	
	//X = (1.5 - fabs(acceleration.x));
	//Y = (1.5+0.4 - fabs(acceleration.y));
	
	//myDistort = CGAffineTransformScale(myDistort, (1.5 - fabs(acceleration.x)), (1.5+0.3 - fabs(acceleration.y)));
	//NSLog(@"%f %f", (1.5 - fabs(acceleration.x)), (1.5+0.3 - fabs(acceleration.y)));
	//NSLog(@"WoW distort !!");
	
	//[arrowView setTransform:CGAffineTransformMakeRotation(angle)];
	//[arrowView setTransform:myDistort];
}

-(BOOL)settingLocationManager
{
	//First we will start heading service
	self.locManager = [[[CLLocationManager alloc] init] autorelease];
	locManager.headingFilter = kCLHeadingFilterNone;	
	locManager.distanceFilter = kCLLocationAccuracyBest;
        // setup delegate callbacks
	locManager.delegate = self;
        // start the compass
	[locManager startUpdatingHeading];
	[locManager startUpdatingLocation];

	return YES;
}

//NS Timer
-(BOOL)PointInView:(SFAnnotation *)annotation range:(double)rangedistance
{
	//issac 0531 test
	//updatedHeading = 200.0;
	
/*	if (annotation.distance > rangedistance) {
		return NO;
	}
*/	
	
	double bearing = (annotation.bearing > 0)?annotation.bearing : (360 + annotation.bearing);
	double left, right;
	left = updatedHeading - range;
	if (left < 0) {
		left = left + 360; 
	}
	right = updatedHeading + range;
	if(right > 360){
		right = right - 360;
	}
	BOOL result = (bearing > left && bearing < right);
	if (left > right) {
		result = (bearing > left || bearing < right);
	}
	return result;
	
	
	
/*	
	double bearing = (annotation.bearing > 0)?annotation.bearing : (360 + annotation.bearing);
	double shift = (fabs(bearing - updatedHeading) > 180) 
						? 360 - fabs(bearing - updatedHeading) : fabs(bearing - updatedHeading);
	if(shift < 30)
	{
		return YES;
	}else
	{
		return NO;
	}
*/
}


/*
-(void)start
{
	camera = [[[UIImagePickerController alloc]init]autorelease];
	camera.delegate = myCameraDelegate;
	camera.sourceType = IMAGEPICKERSOURCE;
	camera.showsCameraControls = NO;
	camera.navigationBarHidden = YES;
	
//	camera.wantsFullScreenLayout = YES;
//	camera.cameraOverlayView= nil;
	camera.cameraOverlayView= self.parentViewController.view;
	camera.cameraViewTransform = CGAffineTransformMakeScale(1.011, 1.011);
	
//	[self.parentViewController presentModalViewController:camera animated:NO];	
//	[camera dismissModalViewControllerAnimated:NO];

	[self presentModalViewController:camera animated:YES];	
	//NSLog(@"%@",[self.parentViewController description]);
//	[self.parentViewController ]
	//NSLog(@"%@",[[self parentViewController] parentViewController description]);

}
*/

/*
-(void)viewWillAppear:(BOOL)animated
{
	camera = [[[UIImagePickerController alloc]init]autorelease];
	camera.delegate = myCameraDelegate;
	camera.sourceType = IMAGEPICKERSOURCE;
	camera.showsCameraControls = NO;
	camera.navigationBarHidden = YES;
	
	//	camera.wantsFullScreenLayout = YES;
	//	camera.cameraOverlayView= nil;
	camera.cameraOverlayView= self.parentViewController.view;
	camera.cameraViewTransform = CGAffineTransformMakeScale(1.011, 1.011);
	
	//	[self.parentViewController presentModalViewController:camera animated:NO];	
	//	[camera dismissModalViewControllerAnimated:NO];
	
	[self.parentViewController presentModalViewController:camera animated:YES];	
	//NSLog(@"%@",[self.parentViewController description]);
	//	[self.parentViewController ]
	//NSLog(@"%@",[[self parentViewController] parentViewController description]);	
}
*/
//issac 0517
-(double) computeRelativeDistance : (CLLocation *)myLocation Destination: (CLLocationCoordinate2D)destCoordinate
{
	CLLocation *localLocation = [[[CLLocation alloc] initWithLatitude:destCoordinate.latitude longitude:destCoordinate.longitude]autorelease];
	//(CLLocationDistance)distanceFromLocation:(const CLLocation *)location
	//CLLocationDistance distance = [myCoordinate distanceFromLocation:localLocation];
	
	//CLLocationDistance distance = [myLocation distanceFromLocation:localLocation];
	CLLocationDistance distance = [myLocation getDistanceFrom:localLocation];
	return distance;
}
- (double)Angle:(CLLocationCoordinate2D)coord1 destination:(CLLocationCoordinate2D)coord2
{
	double theta;
	theta = atan2(sin(coord2.longitude-coord1.longitude)*cos(coord2.latitude), cos(coord1.latitude)*sin(coord2.latitude)
				  -sin(coord1.latitude)*cos(coord2.latitude)*cos(coord2.longitude-coord1.longitude));
	//NSLog(@"%f",theta);
	return theta;
}
-(void) loadAnnotation
{
	annoArray = [[NSMutableArray alloc] init];
	SFAnnotation *poi ;
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"松山機場" 
											  LocationX:25.063546878877353
											  LocationY:121.55214657064167];
	[annoArray addObject:poi];
	[poi release];
	
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"松山醫院" 
											  LocationX:25.054896374127832
											  LocationY:121.55742009489931];
	[annoArray addObject:poi];
	[poi release];
	
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"台北 101" 
											  LocationX:25.033492284074082
											  LocationY:121.56422018047304];
	[annoArray addObject:poi];
	[poi release];
	
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"美麗華" 
											  LocationX:25.083754775873032
											  LocationY:121.55733263292502];
	[annoArray addObject:poi];
	[poi release];
	
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"典華婚宴會場" 
											  LocationX:25.08395673961566
											  LocationY:121.55519127845764];
	[annoArray addObject:poi];
	[poi release];
	
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"Wego" 
											  LocationX:25.08380126794627
											  LocationY:121.55585646629333];
	[annoArray addObject:poi];
	[poi release];
	
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"維多利亞酒店" 
											  LocationX:25.08411221108758
											  LocationY:121.55877470970154];
	[annoArray addObject:poi];
	[poi release];
	
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"家樂福" 
											  LocationX:25.08228540882096
											  LocationY:121.55800223350525];
	[annoArray addObject:poi];
	[poi release];
	
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"捷運劍南路站" 
											  LocationX:25.084850697882406 
											  LocationY:121.55558824539185];
	[annoArray addObject:poi];
	[poi release];
	
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"圓山大飯店" 
											  LocationX:25.078602570310615 
											  LocationY:121.52626633644104];
	[annoArray addObject:poi];
	[poi release];
	
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"大佳河濱公園" 
											  LocationX:25.07510425699454 
											  LocationY:121.5304183959961];
	[annoArray addObject:poi];
	[poi release];
	
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"兒童育樂中心" 
											  LocationX:25.073393934108477 
											  LocationY:121.52217864990234];
	[annoArray addObject:poi];
	[poi release];
	
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"台北市立美術館" 
											  LocationX:25.07213061209311 
											  LocationY:121.52445316314697];
	[annoArray addObject:poi];
	[poi release];
	
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"捷運圓山站" 
											  LocationX:25.071353176683118 
											  LocationY:121.52015089988708];
	[annoArray addObject:poi];
	[poi release];
	
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"士林夜市" 
											  LocationX:25.0868815135935 
											  LocationY:121.52545094490051];
	[annoArray addObject:poi];
	[poi release];

	//經濟部DEMO POI
	/*	經濟部 (25.027935299122106, 121.5168035030365)
	 中正紀念堂 (25.034652613569115, 121.52183532714844)
	 捷運古亭站 (25.027070090065664, 121.52237176895142)
	 建國中學 (25.03123081482577, 121.5128231048584)
	 總統府 (25.040076746689472, 121.5119218826294)x
	 國家戲劇院 (25.040076746689472, 121.5119218826294)x
	 國家音樂廳 (25.03700504484288, 121.51915311813354)
	 大安森林公園 (25.030200368098846, 121.53578281402588)
	 龍山寺 (25.036820351457415, 121.49994850158691)
	 */	
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"經濟部" 
											  LocationX:25.027935299122106 
											  LocationY:121.5168035030365];
	[annoArray addObject:poi];
	[poi release];
	
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"中正紀念堂" 
											  LocationX:25.034652613569115 
											  LocationY:121.52183532714844];
	[annoArray addObject:poi];
	[poi release];

	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"捷運古亭站" 
											  LocationX:25.027070090065664 
											  LocationY:121.52237176895142];
	[annoArray addObject:poi];
	[poi release];

	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"建國中學" 
											  LocationX:25.03123081482577 
											  LocationY:121.5128231048584];
	[annoArray addObject:poi];
	[poi release];
	
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"總統府" 
											  LocationX:25.040076746689472 
											  LocationY:121.5119218826294];
	[annoArray addObject:poi];
	[poi release];

	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"國家音樂廳" 
											  LocationX:25.03700504484288 
											  LocationY:121.51915311813354];
	[annoArray addObject:poi];
	[poi release];

	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"大安森林公園" 
											  LocationX:25.030200368098846 
											  LocationY:121.53578281402588];
	[annoArray addObject:poi];
	[poi release];

	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"龍山寺" 
											  LocationX:25.036820351457415 
											  LocationY:121.49994850158691];
	[annoArray addObject:poi];
	[poi release];
	
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"B 2375" 
											  LocationX:37.424843
											  LocationY:-122.094412];
	[annoArray addObject:poi];
	[poi release];
	
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"B 2350" 
											  LocationX:37.424128
											  LocationY:-122.094948];
	[annoArray addObject:poi];
	[poi release];
	
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"B sal3" 
											  LocationX:37.424179
											  LocationY:-122.094117];
	[annoArray addObject:poi];
	[poi release];
	
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"B sal" 
											  LocationX:37.423906
											  LocationY:-122.092540];
	[annoArray addObject:poi];
	[poi release];
	
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"B c" 
											  LocationX:37.423872
											  LocationY:-122.091644];
	[annoArray addObject:poi];
	[poi release];
	
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"B sal2" 
											  LocationX:37.423135
											  LocationY:-122.092534];
	[annoArray addObject:poi];
	[poi release];
	
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"B 1945" 
											  LocationX:37.422551
											  LocationY:-122.090555];
	[annoArray addObject:poi];
	[poi release];
	
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"B 1965" 
											  LocationX:37.421746
											  LocationY:-122.090233];
	[annoArray addObject:poi];
	[poi release];
	
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"B 2000" 
											  LocationX:37.422828 
											  LocationY:-122.088613];
	[annoArray addObject:poi];
	[poi release];
	
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"B 1900" 
											  LocationX:37.422863 
											  LocationY:-122.087551];
	[annoArray addObject:poi];
	[poi release];
	
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"B 1950" 
											  LocationX:37.421964 
											  LocationY:-122.087561];
	[annoArray addObject:poi];
	[poi release];
	
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"B 1098" 
											  LocationX:37.420080 
											  LocationY:-122.086129];
	[annoArray addObject:poi];
	[poi release];
	
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"B 44" 
											  LocationX:37.420098 
											  LocationY:-122.083608];
	[annoArray addObject:poi];
	[poi release];
	
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"B 45" 
											  LocationX:37.420089 
											  LocationY:-122.082031];
	[annoArray addObject:poi];
	[poi release];
	
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"B 46" 
											  LocationX:37.419071 
											  LocationY:-122.082267];
	[annoArray addObject:poi];
	[poi release];
	
	//經濟部DEMO POI
	/*	經濟部 (25.027935299122106, 121.5168035030365)
	 中正紀念堂 (25.034652613569115, 121.52183532714844)
	 捷運古亭站 (25.027070090065664, 121.52237176895142)
	 建國中學 (25.03123081482577, 121.5128231048584)
	 總統府 (25.040076746689472, 121.5119218826294)x
	 國家戲劇院 (25.040076746689472, 121.5119218826294)x
	 國家音樂廳 (25.03700504484288, 121.51915311813354)
	 大安森林公園 (25.030200368098846, 121.53578281402588)
	 龍山寺 (25.036820351457415, 121.49994850158691)
	 */	
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"B 47" 
											  LocationX:37.419243 
											  LocationY:-122.081156];
	[annoArray addObject:poi];
	[poi release];
	
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"B 1055" 
											  LocationX:37.418760 
											  LocationY:-122.079713];
	[annoArray addObject:poi];
	[poi release];
	
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"B 41" 
											  LocationX:37.422458 
											  LocationY:-122.085550];
	[annoArray addObject:poi];
	[poi release];
	
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"B 42" 
											  LocationX:37.421589 
											  LocationY:-122.085679];
	[annoArray addObject:poi];
	[poi release];
	
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"B 40" 
											  LocationX:37.422407 
											  LocationY:-122.084541];
	[annoArray addObject:poi];
	[poi release];
	
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"B 43" 
											  LocationX:37.421435 
											  LocationY:-122.084069];
	[annoArray addObject:poi];
	[poi release];
	
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"UC Berkeley" 
											  LocationX:37.874853
											  LocationY:-122.245474];
	[annoArray addObject:poi];
	[poi release];
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"Bay Bridge" 
											  LocationX:37.816158 
											  LocationY:-122.353020];
	[annoArray addObject:poi];
	[poi release];
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"Golden Gate Bridge" 
											  LocationX:37.820904 
											  LocationY:-122.479362];
	[annoArray addObject:poi];
	[poi release];
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"San Francisco" 
											  LocationX:37.769901 
											  LocationY:-122.419281];
	[annoArray addObject:poi];
	[poi release];
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"Berkeley Yacht Harbor" 
											  LocationX:37.861573 
											  LocationY:-122.321777];
	[annoArray addObject:poi];
	[poi release];
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"Stanford University" 
											  LocationX:37.423889 
											  LocationY:-122.166595];
	[annoArray addObject:poi];
	[poi release];
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"earthmine" 
											  LocationX:37.862043 
											  LocationY:-122.298244];
	[annoArray addObject:poi];
	[poi release];
	//earthmine around
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"Vik's Chaat Corner" 
											  LocationX:37.861357 
											  LocationY:-122.298442];
	[annoArray addObject:poi];
	[poi release];
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"Laborde Architecture" 
											  LocationX:37.861014 
											  LocationY:-122.298238];
	[annoArray addObject:poi];
	[poi release];
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"All Things Computers‎" 
											  LocationX:37.862657 
											  LocationY:-122.299966];
	[annoArray addObject:poi];
	[poi release];
	poi = [[SFAnnotation alloc] initWithTextAndLocation:@"LifeLong Medical Care‎" 
											  LocationX:37.861942 
											  LocationY:-122.296039];
	[annoArray addObject:poi];
	[poi release];
	
	
	//[annoArray addObject:nil];	
}
-(double) initialGeoLocation:(CLLocation *)localCurrent
{
	//locationCurrent = [[CLLocation alloc] initWithLatitude:25.078602570310615 longitude:121.52626633644104];
	/*NSString * teststring = [NSString stringWithFormat:@"%@%5.0f公尺", element.title, element.distance];
	CallOutView *myview3 = [CallOutView addCalloutView:back 
												  text:teststring
												 point:testPoint
												target:self
												action:@selector(handleCalloutClick:)];
	*/
	//0602Chun Setting Maximum angle
	max_angle = M_PI/6;
	//
	CGPoint testPoint = CGPointMake(0.0,0.0);
	
	viewArray = [[NSMutableArray alloc] init];
	
	double max = 0.0;
	for (SFAnnotation *element in annoArray)
	{
		//Distance
		element.distance = [self computeRelativeDistance :localCurrent Destination: element.coordinate];
		//NSLog(@"%f", element.distance);
		
		//Bearing
		element.bearing = [self Angle:localCurrent.coordinate destination:element.coordinate];
		element.bearing = (element.bearing * 180)/pii;
		
		NSString * teststring = [NSString stringWithFormat:@"%@\n%.0fmeters", element.title, element.distance];
		
		//CallOutView *myview3 = [CallOutView alloc];

		CallOutView *myview3 = [CallOutView addCalloutView:back 
										  text:teststring
										 point:testPoint
										target:self
										action:@selector(handleCalloutClick:)];
		
		[viewArray addObject:myview3];
		
		//NSLog(@"%@", myview3.calloutLabel.text);
		
		//insert to the back view
		//[back insertSubview:myview3 atIndex:0];
		//[myview3 release];
		
		if(element.distance > max)
			max = element.distance;
	}
	//issac 0531
	[self.view addSubview:back];
	[back release];	


	//NSTimer
	updateTimer = [NSTimer scheduledTimerWithTimeInterval:myTime
												   target:self
												 selector:@selector(updateHeading:)
												 userInfo:nil
												  repeats:YES];	

	return max;
}

-(void)updateHeading:(NSTimer *)timer
{
//	NSLog(@"YOYO");
	//issac madness 0601 
	//運算量應該會超大吧XD
	//NSMutableArray *PointArray = [[NSMutableArray alloc] init];
	maxdistance = 4800;
	
	for (int i = 0; i < [annoArray count]; i++) {
		SFAnnotation *element = [annoArray objectAtIndex:i];
		CallOutView *elementV = [viewArray objectAtIndex:i];
		
		if([self PointInView:element range:maxdistance])/*-(BOOL)PointInView:(SFAnnotation *)annotation*/
		//if(1)
		{
			CGPoint testPoint =  [self CALlocation:element Maxdistance:maxdistance];			
			CGPoint testPointT = CGPointMake(testPoint.x, testPoint.y);
			//issac 0601
			//[PointArray addObject: [NSValue valueWithPointer:&testPoint]];
			//for (int y=0; y < [PointArray count] ; y++) {
			//}
			
			
			//issac 0701
			//accelerometer to decide the y position.
			int AccZtemp = 0;
			AccZtemp = AccZ * 10;
			float AccZtemp2 = 0.0;
			AccZtemp2 = AccZtemp / 10.0;
			float AccZtemp3 = 0.0;
			if( (AccZtemp3 = (AccZtemp2 - (-0.4))) >= 0 )
			{
				testPointT.y += AccZtemp3 * 120;
			}else {
				testPointT.y += AccZtemp3 * 120;
				//testPointT.y += (AccZtemp2 >=0 ) ? AccZtemp2 * 90 : AccZtemp2 * -90;
			}
			
		
				
			//issac 0601 2
			//button collision
			for (int y=0 ; y < i ; y++) {
				SFAnnotation *elementT = [annoArray objectAtIndex:y];
				CallOutView *elementTV = [viewArray objectAtIndex:y];
				//NSLog(@"%f %f", testPoint.x, elementTV.calloutPoint.x);
				if (elementTV.calloutPoint.x != 0) {
					//NSLog(@"%f %f", testPoint.x, elementTV.calloutPoint.x);
					if((fabs(testPoint.x - elementTV.calloutPoint.x) < 150) 
						&& fabs(testPoint.y - elementTV.calloutPoint.y) < 70 ){
						if(element.distance > elementT.distance)
						{
							testPointT.y -= 60;
						}else {
							testPointT.y += 60;
						}

					}
				}
			}
			

			
			//issac 0531
			[elementV setAnchorPoint:testPointT];
			//NSLog(@"%f %f %f", testPointT.x, testPointT.y, element.bearing);
			
			//Chun 0602
			double bearing = (element.bearing > 0)?element.bearing : (360 + element.bearing);
			double centerBearing = updatedHeading;
            if (bearing-centerBearing>180) {
				centerBearing+=360;
			}
			else if (bearing-centerBearing<-180) {
				bearing+=360;
			}
			double angleDifference = bearing -centerBearing;
			if (angleDifference>90) {
				angleDifference = 90;
			}
			if (angleDifference <-90) {
				angleDifference = -90;
			}
			angleDifference = -angleDifference;
			//CALayer *layer = elementV.layer;
			CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
			rotationAndPerspectiveTransform.m34 = 1.0 / -500;
			//rotationAndPerspectiveTransform.m34 = 1.0 / 300; 
			rotationAndPerspectiveTransform=CATransform3DRotate(rotationAndPerspectiveTransform, 
																 angleDifference * M_PI / 180.0f
																 , 0, 1, 0);
			// [layer setTransform:rotationAndPerspectiveTransform];
			elementV.layer.transform = rotationAndPerspectiveTransform;
			 
			 //	layer.transform = rotationAndPerspectiveTransform;
			 
			if(!(elementV.superview))
			{
				[back addSubview:elementV];
			}
			//	[back insertSubview:elementV atIndex:0];
			
			//issac 0528
			//id elementV = [viewArray objectAtIndex:[annoArray indexOfObject:element]];
			//[elementV setAnchorPoint:testPoint];
		}else {
			if(!(elementV.superview))
			{
				[elementV removeFromSuperview];
				//elementV.transform = CGAffineTransformIdentity;
			}
			//remove the calloutview from back view
			//id elementV = [viewArray objectAtIndex:[annoArray indexOfObject:element]];
			
			//issac 0531
			//if(elementV.superview != nil)
			//	NSLog(@"YAYA");
			//[elementV removeFromSuperview];
			
			//issac 0601
			CGPoint testPoint =  CGPointMake(0.0, 0.0);
			[elementV setAnchorPoint:testPoint];
		}
	}
/*	
	for(SFAnnotation *element in annoArray)
	{
		CallOutView *elementV = [viewArray objectAtIndex:[annoArray indexOfObject:element]];

		if([self PointInView:element])
		//if(1)
		{
			CGPoint testPoint =  [self CALlocation:element Maxdistance:maxdistance];
			//issac 0531
			[elementV setAnchorPoint:testPoint];
			//if(elementV.superview == nil)
			//	[back insertSubview:elementV atIndex:0];
			
			//issac 0528
			//id elementV = [viewArray objectAtIndex:[annoArray indexOfObject:element]];
			//[elementV setAnchorPoint:testPoint];
		}else {
			//remove the calloutview from back view
			//id elementV = [viewArray objectAtIndex:[annoArray indexOfObject:element]];
			
			//issac 0531
			//if(elementV.superview != nil)
			//	NSLog(@"YAYA");
				//[elementV removeFromSuperview];

			//issac 0601
			CGPoint testPoint =  CGPointMake(0.0, 0.0);
			[elementV setAnchorPoint:testPoint];
		}
	}
*/
}

-(CGPoint) CALlocation:(SFAnnotation *)annotation Maxdistance:(double)distanceM
{
	//distanceM = 3000;
	//mybearing not relative to the north direction anymore?!
	double mybearing = (annotation.bearing >= 0)? annotation.bearing : (360 + annotation.bearing) ;
	
	
	//issac 0531
	mybearing = (mybearing - updatedHeading);

	double mybearing_pi = mybearing * pii/180;
	double Y_coord = (cos(mybearing_pi) >= 0) ? 1 : -1;

	CGPoint testPoint;
//	testPoint = CGPointMake(460 + annotation.distance * 700/distanceM * sin(mybearing * pii/180)
//							, 420 - annotation.distance * 460/distanceM * cos(mybearing * pii/180));
	//issac 0601
//	testPoint = CGPointMake(460 + (annotation.distance * 30/distanceM) * tan(mybearing_pi)
//							, 420 - (annotation.distance * 460/distanceM) * Y_coord);
	//issac 0602
	testPoint = CGPointMake(460 + 320*sin(mybearing_pi), 420 - (annotation.distance * 460/distanceM) * Y_coord);

//	NSLog(@"%f %f %f %f", mybearing, testPoint.x, testPoint.y, annotation.distance);

	return testPoint;
}

-(void) drawAnnotation:(double)distanceM
{
//	back = [[UIView alloc] initWithFrame:CGRectMake(-300, 0, 920, 920)];
//	back.backgroundColor = [UIColor clearColor];

	distanceM = 3000;
    for(SFAnnotation *element in annoArray)
	{
		double mybearing = (element.bearing >= 0)? element.bearing : (180 + element.bearing + 180) ;
		//double mybearing = element.bearing;
		
		//NSLog(@"%f", mybearing);
		//NSLog(@"%f", element.bearing);
		
		//double mybearing = element.bearing;
		//CGPoint testPoint = CGPointMake(320, element.distance * 320 / max) ;
		CGPoint testPoint;
		//if(element.bearing >=0)
		//{
		testPoint = CGPointMake(460 + element.distance * 160/distanceM * sin(mybearing * pii/180)
										, 420 - element.distance * 460/distanceM * cos(mybearing * pii/180));
		//}else{
		//testPoint = CGPointMake(460 + element.distance * 460/distanceM * cos(mybearing * pii/180)
		//									, 420 - element.distance * 460/distanceM * sin(mybearing * pii/180));			
		//}
		
		//NSLog(@"%f %f %f", testPoint.x, testPoint.y, element.distance);
		
		//issac test 0528
		NSInteger temp = [annoArray indexOfObject:element];
		//NSLog(@"%d", temp);
		CallOutView * elementV = [viewArray objectAtIndex:temp];
		
		//issac 0531
		//[elementV initWithText:elementV.calloutLabel.text point:testPoint];
		
		[elementV setAnchorPoint:testPoint];
		//NSLog(@"%@", elementV.calloutLabel.text);

		//[elementV initialize];
/*		NSString * teststring = [NSString stringWithFormat:@"%@%5.0f公尺", element.title, element.distance];
		CallOutView *myview3 = [CallOutView addCalloutView:back 
													  text:teststring
													 point:testPoint
													target:self
													action:@selector(handleCalloutClick:)];
		
		[myview3 setTransform:CGAffineTransformMakeRotation(element.bearing * pii/180)];
*/		
//		[back insertSubview:elementV atIndex:0];
//		[back insertSubview:myview3 atIndex:0];
		
		//[myview3 release];
	}
	
	[self.view addSubview:back];
	[back release];	
}

- (void) performDismiss
{
	[baseAlert dismissWithClickedButtonIndex:0 animated:NO];
	
	//test 0520
	maxdistance = 0.0;
//	locationCurrent = [[CLLocation alloc] initWithLatitude:updatedLocation.latitude longitude:updatedLocation.longitude];
//	locationCurrent = [[CLLocation alloc] initW0ithLatitude:25.027935299122106 
//												 longitude:121.5168035030365];
	locationCurrent = [[CLLocation alloc] initWithLatitude:25.083754775873032 
												 longitude:121.55733263292502];

	//43	37.421435	-122.084069
	//locationCurrent = [[CLLocation alloc] initWithLatitude:37.421435
	//											 longitude:-122.084069];

	//earthmine coordinateX:37.862043 coordinateY:-122.298244
	//locationCurrent = [[CLLocation alloc] initWithLatitude:37.862043
	//											 longitude:-122.298244];
	
	//issac 0608 singleton
	ARDataSingleton *singleton = [ARDataSingleton sharedData];
	[singleton.myLocation initWithLatitude:locationCurrent.coordinate.latitude
								 longitude:locationCurrent.coordinate.longitude];

	//CGPoint testPoint = CGPointMake(160, 320);
	maxdistance = [self initialGeoLocation:locationCurrent];
	
	//[self drawAnnotation:maxdistance];
	
}
- (void) action
{
	baseAlert = [[[UIAlertView alloc] initWithTitle:@"Plz Wait! Confirming your location..."
					 message:nil delegate:self cancelButtonTitle:nil
					 otherButtonTitles: nil] autorelease];
	[baseAlert show];
	// Create and add the activity indicator
	UIActivityIndicatorView *aiv = [[UIActivityIndicatorView alloc]
										initWithActivityIndicatorStyle:
										UIActivityIndicatorViewStyleWhiteLarge];
	aiv.center = CGPointMake(baseAlert.bounds.size.width / 2.0f,
							 baseAlert.bounds.size.height - 40.0f);
	[aiv startAnimating];
	[baseAlert addSubview:aiv];
	[aiv release];
	// Auto dismiss after 3 seconds for this example
	[self performSelector:@selector(performDismiss) withObject:nil
		afterDelay:1.0f];
	
}

-(void)setMyMap{
	myMap.mapType = MKMapTypeStandard;
//	myMap.centerCoordinate = myMap.userLocation.coordinate;
//	NSLog(@"Location:%f", myMap.userLocation.coordinate.latitude);
	[myMap showsUserLocation]; 
	myMap.delegate = self;
	myMap.layer.cornerRadius = 70.0;
	
//	MKCoordinateRegion region;
	//region.center.latitude = locationCurrent.coordinate.latitude;
	//region.center.longitude = locationCurrent.coordinate.longitude;
	//[myMap setRegion:region animated:YES];
	//[myMap setCenterCoordinate:locationCurrent.coordinate animated:YES];
	//CLLocationCoordinate2D mytest = {25.063546878877353, 121.55214657064167};
	//MKPlacemark *placemark=[[MKPlacemark alloc] initWithCoordinate:mytest];
	//[myMap addAnnotation:placemark];
	//[placemark release];
	
	
	//myMap.view.alpha = 0.2f;
	//[self.view addSubview:myMap];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	// 此塊用來先啓動相機
	NSLog(@"YAYA viewdidload");
	
	//open the accelerometer
	//[[UIAccelerometer sharedAccelerometer] setDelegate:self];	

	//[self start];	
	[self setMyMap];
	//accelerometer by issac	
	
	
	//issac 0517
	//[self calculate ]
	maxdistance = 0.0;
	[self loadAnnotation];
	//locationCurrent = nil;
	//locationCurrent = [[CLLocation alloc] initWithLatitude:25.078602570310615 longitude:121.52626633644104];
	
	//[self action];
	
	NSLog(@"what?");

	
	//	back = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	//back = [[UIView alloc] initWithFrame:CGRectMake(-320, 0, 960, 960)];

	back = [[UIView alloc] initWithFrame:CGRectMake(-300, 0, 920, 920)];
	back.backgroundColor = [UIColor clearColor];
	//[self settingLocationManager];

	[self action];

	//locationCurrent = updatedLocation;
//	locationCurrent = [[CLLocation alloc] initWithLatitude:updatedLocation.latitude longitude:updatedLocation.longitude];
	
	//CGPoint testPoint = CGPointMake(160, 320);
//	max = [self initialGeoLocation:locationCurrent];
//	[self drawAnnotation:max];
	

/*	
    for(SFAnnotation *element in annoArray)
	{
		double mybearing = (element.bearing >= 0)? element.bearing : (180 + element.bearing + 180) ;
		//double mybearing = element.bearing;
		NSLog(@"%f", element.bearing);
		//double mybearing = element.bearing;
		//CGPoint testPoint = CGPointMake(320, element.distance * 320 / max) ;
		CGPoint testPoint = CGPointMake(460 + element.distance * 500/max * sin(mybearing * pii/180)
										, 460 - element.distance * 500/max * cos(mybearing * pii/180));
		
		NSString * teststring = [NSString stringWithFormat:@"%f", element.distance];
		CallOutView *myview3 = [CallOutView addCalloutView:back 
													  text:teststring
													 point:testPoint
													target:self
													action:@selector(handleCalloutClick:)];
		
		[myview3 setTransform:CGAffineTransformMakeRotation(element.bearing * pii/180)];
		[back insertSubview:myview3 atIndex:0];
		//[myview3 release];
	}
	
	[self.view addSubview:back];
	[back release];

*/
    [super viewDidLoad];
	//[self performSelector:@selector(displayViews) withObject:nil afterDelay:1.0f];
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}
-(void)viewWillDisappear:(BOOL)animated
{
//	[super viewDidDisappear:animated];
//	if(animated)
//	{
//	}
	NSLog(@"Run hereeee");
	//[self dismissModalViewControllerAnimated:YES];

	[super viewWillDisappear:animated];

}
- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
//	[camera dismissModalViewControllerAnimated:YES];
//	[self dismissModalViewControllerAnimated:YES];

	self.myMap = nil;
	self.camera= nil;
	self.back = nil;
}


- (void)dealloc {
//	[camera dismissModalViewControllerAnimated:YES];
//	[self dismissModalViewControllerAnimated:YES];
	[locManager stopUpdatingHeading];
	[locManager stopUpdatingLocation];
	[locManager release];
	[myCameraDelegate release];
	
	[myMap release];
	[headingLabel release];
	[camera release];
	[arrowView release];
	[locationCurrent release];
	[annoArray release];
	[viewArray release];
	[annoViewDictionary release];
    [super dealloc];
}


@end
