//
//  FirstViewController.m
//  0424TabPractice
//
//  Created by Fu Chun Hsu on 2010/4/23.
//  Copyright EvangelistVision 2010. All rights reserved.
//

#import "FirstViewController.h"

#import <CoreLocation/CoreLocation.h>


@implementation FirstViewController
@synthesize camera;
//@synthesize cameraDelegate;
@synthesize myview;
@synthesize annoArray;
@synthesize locationCurrent;

//issac
@synthesize locManager;
@synthesize back;

const double pi = 3.14159265;
const CLLocationCoordinate2D yuanShuan = {25.078602570310615 
	,121.52626633644104};
//@synthesize locDelegate;
/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/
-(void) computeRelativeInfo: (SFAnnotation *)targetAnno
{
	
}
//issac
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
	
	updatedLocation = newLocation.coordinate;
	MKCoordinateRegion updateRegion;
	
	updateRegion.center = updatedLocation;
    MKCoordinateSpan span;
	
	span.latitudeDelta=.002;
	span.longitudeDelta=.002;
	updateRegion.span=span;	
	
	
	//[myMap setRegion:updateRegion animated:YES];
	
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
	//CGAffineTransform myDistort = CGAffineTransformIdentity;
	myDistort = CGAffineTransformIdentity;
	//NSLog(@"update");
	
	northRotateAngle = (newHeading.magneticHeading>180)? 360-newHeading.magneticHeading : -(newHeading.magneticHeading);
	//NSLog(@"%f", northRotateAngle);
	
	/*for(SFAnnotation *element in annoArray)
	{
		double delta = (northRotateAngle + element.bearing);// ?
		if (delta >=0 ) {
			delta = (delta > 180)? 360 - delta : delta ;
		}else
		{
			delta = (delta < -180)? (-360) - delta : delta;
		}
		
		//NSLog(@"%f", delta);
		if(fabs(delta) <= 15)
		{
			element.place = CGPointMake((delta + 15) / 30 * 320
										, 400 - (element.distance * 400 / 2000));
//			element.place.x = (delta + 15) / 30 * 320;
//			element.place.y = 400 - (element.distance * 400 / 50000);
		}
	}
	 */
/*	[[back subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
	for(SFAnnotation *element in annoArray)
	{
		
		CallOutView *myview3 = [CallOutView addCalloutView:myview3 
													  text:element.title 
													 point:element.place
													target:self
													action:@selector(handleCalloutClick:)];
		[back insertSubview:myview3 atIndex:0];
		//[myview3 release];
	}
*/	
	
	double FinalAngle = (northRotateAngle/180)*pi;
	myDistort = CGAffineTransformRotate(myDistort, FinalAngle);
	[back setTransform:myDistort];
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
	//[locManager startUpdatingLocation];
	
	return YES;
}





/*
-(void) loadCamera 
{
	camera = [[[UIImagePickerController alloc]init]autorelease];
	camera.delegate = self;
	camera.sourceType = UIImagePickerControllerSourceTypeCamera;
	camera.showsCameraControls = NO;
	camera.navigationBarHidden = NO;
	
	//	camera.wantsFullScreenLayout = YES;
	//	camera.cameraOverlayView= nil;
	camera.cameraOverlayView= self.parentViewController.view;
	camera.cameraViewTransform = CGAffineTransformMakeScale(1.011, 1.011);
	
	//	[self.parentViewController presentModalViewController:camera animated:NO];	
	//	[camera dismissModalViewControllerAnimated:NO];
	
	[self presentModalViewController:camera animated:YES];	
	
}
*/
 -(void)viewWillAppear:(BOOL)animated
 {
 camera = [[[UIImagePickerController alloc]init]autorelease];
 camera.delegate = self;
 camera.sourceType = UIImagePickerControllerSourceTypeCamera;
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
 

// Implement loadView to create a view hierarchy programmatically, without using a nib.
/*-(NSArray *)locationFromResource: (NSString *)resourceName
{
	
	//NSBundle *bundle = [NSBundle mainBundle];
	// NSString *path = [bundle pathForResource:resourceName ofType:@"plist"];
	
	NSString *path=[[NSBundle mainBundle] pathForResource:resourceName ofType:@"plist" ];
	//NSString *path1 = [bundle pathForResource:@"positionMaker" ofType:@"m"];
	
	NSLog(@"path:%@",path);
	NSArray *location=[NSArray arrayWithContentsOfFile:path];	
	NSMutableArray *annotationArray = [NSMutableArray alloc];
	for(NSArray *element in location)
	{
		anno *myanno = [[anno alloc]initWithXAndY:[element objectAtIndex:0] latX:[[element objectAtIndex:1]doubleValue] longY:[[element objectAtIndex:2
																														]doubleValue]];
		[annotationArray addObject:myanno];
		//NSLog(@"YESYESYES");
		 //NSLog(@"%@, %f, %f",[element objectAtIndex:0],[[element objectAtIndex:1]doubleValue]
		 //,[[element objectAtIndex:2]doubleValue]);
		 
		//		annotationArray = [[NSMutableArray alloc]addObject:
		[myanno release];
	}
    return [annotationArray autorelease];
}
*/
/*-(NSMutableArray *)calculateRelativePosition:(anno *)selfAnnotation PointOfInterest:(NSArray *)poiArray currentHeading:
											 (CLHeading *)heading
{
	
	// This MutableArray contains:
	// 1) distance between self and destination
	// 2) angle
	
	NSMutableArray *relativePosition = [NSMutableArray alloc];
	CLLocationCoordinate2D myPosition = selfAnnotation.coordinate;
	NSDate *today = [NSDate date];
    CLLocation *objectLocation = [[CLLocation alloc] initWithCoordinate:myPosition altitude:1 
													 horizontalAccuracy:1 verticalAccuracy:-1 timestamp:today];
    //CLLocationDistance distance = [objectLocation getDistanceFrom:CurrentLocation]/1000;
	
	for ((id)element in poiArray) 
	{
		CLLocationCoordinate2D cord = 
		CLLocation *loc =[[CLLocation alloc] initWithCoordinate:cord altitude:1 
											horizontalAccuracy:1 verticalAccuracy:-1 timestamp:today];
		CLLocationDistance distance = [objectLocation getDistanceFrom:loc];
		//[relativePosition addObject:[distance ]];
		[loc release];
	} 
	 
	return [relativePosition autorelease];
}
 */
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
-(void) handleCalloutClick
{
	
}
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

-(void) test
{
	CLLocation *testLocation = [[CLLocation alloc] initWithLatitude:25.06346878877353 longitude:121.55214657064167];
	CLLocationDistance distance;
	CLLocationCoordinate2D testtest = {25.06346878877353,121.55214657064167};
	CLLocationCoordinate2D destination = {25.033492284074082,121.56422018047304};
	distance = [self computeRelativeDistance:testLocation Destination:destination];
	//double heading = [self Angle:testtest destination:destination];
	NSLog(@"%f", distance);
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
	//[annoArray addObject:nil];	
}
-(double) initialGeoLocation
{
	locationCurrent = [[CLLocation alloc] initWithLatitude:25.078602570310615 longitude:121.52626633644104];
	double max = 0.0;
	for (SFAnnotation *element in annoArray)
	{
		element.distance = [self computeRelativeDistance :locationCurrent Destination: element.coordinate];
		//NSLog(@"%f", element.distance);
		element.bearing = [self Angle:locationCurrent.coordinate destination:element.coordinate];
		element.bearing = (element.bearing * 180)/pi;
		
		if(element.distance > max)
			max = element.distance;
		
		//element.place = 
		//NSLog(@"%f", element.bearing);
	}
	return max;
}

- (void)viewDidLoad {
	//[self calculate ]
	double max = 0.0;
	[self loadAnnotation];
	max = [self initialGeoLocation];
	[self settingLocationManager];
	//[self loadCamera];
	
	
	
/*	for(SFAnnotation *element in annoArray)
	{
		double X, Y;
		X = element.coordinate.latitude;
		Y = element.coordinate.longitude;
		CGPoint myPoint;
		//transform
				
	}
*/	
//	back = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	back = [[UIView alloc] initWithFrame:CGRectMake(-320, 0, 960, 960)];
	back.backgroundColor = [UIColor clearColor];
	//CGPoint testPoint = CGPointMake(160, 320);
    for(SFAnnotation *element in annoArray)
	{
		double mybearing = (element.bearing >= 0)? element.bearing : (180 + element.bearing + 180) ;
		//double mybearing = element.bearing;
		NSLog(@"%f", element.bearing);
		//double mybearing = element.bearing;
		//CGPoint testPoint = CGPointMake(320, element.distance * 320 / max) ;
		CGPoint testPoint = CGPointMake(480 + element.distance * 480/max * sin(mybearing * pi/180)
										, 480 - element.distance * 480/max * cos(mybearing * pi/180));
		
		CallOutView *myview3 = [CallOutView addCalloutView:back 
													  text:element.title 
													 point:testPoint
													target:self
													action:@selector(handleCalloutClick:)];
		
		////////////
		/*
		CALayer *layer = myview3.layer;
		CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
		rotationAndPerspectiveTransform.m34 = 1.0 / -500;
		
		rotationAndPerspectiveTransform=CATransform3DRotate(rotationAndPerspectiveTransform, mybearing * M_PI / 180.0f, 0, 1, 0);
		[layer setTransform:rotationAndPerspectiveTransform];
		
		//	layer.transform = rotationAndPerspectiveTransform;
		*/
		////////////
		//rotatedPoint = CGPointApplyAffineTransform(initialPoint, CGAffineTransformMakeRotation(angle));
		[myview3 setTransform:CGAffineTransformMakeRotation(element.bearing * pi/180)];
		[back insertSubview:myview3 atIndex:0];
		//[myview3 release];
	}
	
	
/*	CGPoint touchPoint = CGPointMake(150, 150);
    CGPoint touchPoint1 = CGPointMake(160, 350);
    CallOutView *myview2 = [CallOutView addCalloutView:myview2 text:@"Center" point:touchPoint1 target:self action:@selector(handleCalloutClick:)];
	myview = [CallOutView addCalloutView:self.myview text:@"Teleport" point:touchPoint target:self action:@selector(handleCalloutClick:)];	
//[myView insertSubview:myButton atIndex:0];
    [back insertSubview:myview2 atIndex:0];
*/
/*	CALayer *layer = myview.layer;
	
	CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
	rotationAndPerspectiveTransform.m34 = 1.0 / -500;
	//rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, 30.0f * M_PI / 180.0f, 0.0f, 0.0f, 1.0f);
	rotationAndPerspectiveTransform=CATransform3DRotate(rotationAndPerspectiveTransform, 60.0f * M_PI / 180.0f, 0, 1, 0);
	[layer setTransform:rotationAndPerspectiveTransform];
*/	
//	layer.transform = rotationAndPerspectiveTransform;
	//[back insertSubview:myview
	//			 atIndex:0];
	[self.view addSubview:back];
	[back release];
	//[myview2 release];
	
	//issac
	//[self test];
	
	[super viewDidLoad];
	//[self loadCamera];
	
	
  }


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.back = nil;
}


- (void)dealloc {
	
	//[locDelegate release];
	[locationCurrent release];
	[myview release];
	//[cameraDelegate release];
	[self dismissModalViewControllerAnimated:YES];
	[camera release];
	[annoArray release];
	[back release];
    [super dealloc];
}

@end
