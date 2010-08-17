//
//  ARSecondeViewController.m
//  III_AR_Navigation
//
//  Created by Chun F.Hsu on 2010/4/9.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ARSecondeViewController.h"


@implementation ARSecondeViewController
@synthesize myMap2;
@synthesize locManager;

@synthesize myPointArray;
@synthesize detailViewController;
@synthesize annoArray;
@synthesize locationCurrent;

@synthesize text, textarray;
//@synthesize place1;
//@synthesize mylocationtest;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
 	CGAffineTransform myDistort = CGAffineTransformIdentity;
	//myDistort = CGAffineTransformIdentity;
	
	northRotateAngle = (newHeading.magneticHeading>180)? 360-newHeading.magneticHeading : -(newHeading.magneticHeading);
	//myDistort = CGAffineTransformRotate(myDistort, (northRotateAngle/180)*pi);
	//myDistort = CGAffineTransformScale(myDistort, AccX, AccY);
	//NSLog(@"WoW rotate");
	//[arrowView setTransform:myDistort];
	
	
	//northRotateAngle = (newHeading.trueHeading>180)? 360-newHeading.trueHeading : -(newHeading.trueHeading);
	//NSLog(@"%f %f %f %f", newHeading.x, newHeading.y, newHeading.z, newHeading.magneticHeading);
	//headingLabel.text = [NSString stringWithFormat:@"Heading%f, rotating angle:%f",newHeading.trueHeading, northRotateAngle ] ;
	//myDistort = CGAffineTransformMakeScale(0.5, 1);
	//myDistort = CGAffineTransformScale(myDistort, 2, 1);
	//myDistort = CGAffineTransformScale(myDistort, (1.2 - (1.2/128)*newHeading.z)  , (1.2 - (1.2/128)*newHeading.y));
	//NSLog(@"%f %f %f %f", ((1.2/128)*newHeading.z), newHeading.z,((1.2/128)*newHeading.y), newHeading.y);
	//[arrowView setTransform:CGAffineTransformScale(myDistort, (1 - 0.7/128*newHeading.z)  , (1 - 0.7/128*newHeading.y))];
	
	
	//[myMap2 setTransform:CGAffineTransformRotate(myDistort, (northRotateAngle/180)*3.1415926)];
	
	//[arrowView setTransform:transform];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
	
	updatedLocation = newLocation.coordinate; //newlocation -> user's current location.
	NSLog(@"%f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
	
	[self.myMap2 setCenterCoordinate:newLocation.coordinate animated:YES];
	//NSLog(@"%f", LocationNow.coordinate.latitude);

/*	if (LocationNow == nil) {
		NSLog(@"in %f %f", LocationNow.coordinate.latitude, LocationNow.coordinate.longitude);
		[self setMyPoint];
	}
*/	
	//region2.center = newLocation.coordinate;
	
	//MKCoordinateRegion updateRegion;
	
	//updateRegion.center = updatedLocation;
    //MKCoordinateSpan span;
	
	//span.latitudeDelta=.001;
	//span.longitudeDelta=.001;
	//updateRegion.span=span;	
	//[myMap2 setRegion:updateRegion animated:YES];
	
	//[myMap2 setRegion:region2 animated:YES];
	
	//	myMap.region = updateRegion;
	//	MKCoordinateRegion zoomOut = { { newLocation.coordinate.latitude , newLocation.coordinate.longitude }, {4, 4} };
	//	[myMap setRegion:zoomOut animated:YES];
	//	myMap.region.center= newLocation.coordinate; 
	//	myMap.region.span = {newLocation.horizontalAccuracy,newLocation.verticalAccuracy};
	
	//[myMap setRegion:zoomOut  animated:YES];
	//	[self.view setNeedsDisplay];
    //myMap.centerCoordinate = newLocation.coordinate;	
}

-(BOOL)settingLocationManager
{
	//First we will start heading service
	self.locManager = [[[CLLocationManager alloc] init] autorelease];
	//locManager.headingFilter = kCLHeadingFilterNone;	
	//locManager.distanceFilter = kCLLocationAccuracyBest;
	// setup delegate callbacks
	locManager.delegate = self;
	// start the compass
	[locManager startUpdatingHeading];	
	[locManager startUpdatingLocation];	//update the user's current location -> didUpdateToLocation
	return YES;
}


//- (void)mapView:(MKMapView *)map regionDidChangeAnimated:(BOOL)animated
- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView
//- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView
{
	//NSLog(@"didloadmap1");
	//for (id currentAnnotation in mapView.annotations) {
		//if ([currentAnnotation isEqual:annotationToSelect]) {
		//if ([currentAnnotation isKindOfClass:[SFAnnotation class]]) {
	//		NSLog(@"didloadmap2");
			//[mapView deselectAnnotation:currentAnnotation animated:YES];
	//		[mapView selectAnnotation:currentAnnotation animated:FALSE];
	//	break;
			//[self.myMap2 selectAnnotation:currentAnnotation animated:FALSE];
			//[mapView selectAnnotation:[mapView.annotations objectAtIndex:0] animated:FALSE];
			//[mapView selectAnnotation:[mapView.annotations objectAtIndex:4] animated:FALSE];
		//}
		//}
	//}
}
/*
- (void)showDetails:(id)sender
{
    // the detail view does not want a toolbar so hide it
	NSLog(@"detail1");
	UIButton* btn = (UIButton *) sender;	
	// here btn is the selected button...
    NSLog(@"Button %d is selected",btn.tag); 
	
    //[self.navigationController setToolbarHidden:YES animated:NO];
    
    //[self.navigationController pushViewController:self.detailViewController animated:YES];
    //[self.navigationController setToolbarHidden:YES animated:NO];
	//[self.navigationController setNavigationBarHidden:NO];
	//[detailViewController.myImageView initWithImage:[UIImage imageNamed:@"Hotel.png"]];
    [self.navigationController pushViewController:self.detailViewController animated:YES];
	//[detailViewController release];
	
//	[self.view addSubview:detailViewController];
	NSLog(@"detail2");

}
*/
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
	NSLog(@"callout1");
	
	[self.navigationController popToRootViewControllerAnimated:YES];
	if ([view.annotation.title isEqual: @"美麗華"])
	{
		[detailViewController init:@"miramar.png" NavTitle:view.annotation.title];	
	}
	else if([view.annotation.title isEqual: @"Wego"])
	{
		[detailViewController init:@"wego.png" NavTitle:view.annotation.title];	
	}
	else if([view.annotation.title isEqual: @"捷運劍南路站"])
	{
		[detailViewController init:@"Jiannan RD.png" NavTitle:view.annotation.title];	
	}
	else if([view.annotation.title isEqual: @"圓山大飯店"])
	{
		[detailViewController init:@"Hotel.png" NavTitle:view.annotation.title];	
	}
	else if([view.annotation.title isEqual: @"典華婚宴會場"])
	{
		[detailViewController init:@"issac.png" NavTitle:view.annotation.title];	
	}
	else if([view.annotation.title isEqual: @"松山機場"])
	{
		[detailViewController init:@"airport.png" NavTitle:view.annotation.title];	
	}
	else if([view.annotation.title isEqual: @"台北市立美術館"])
	{
		[detailViewController init:@"tfam.png" NavTitle:view.annotation.title];	
	}
	else if([view.annotation.title isEqual: @"捷運圓山站"])
	{
		[detailViewController init:@"yuanshan.png" NavTitle:view.annotation.title];	
	}
	else if([view.annotation.title isEqual: @"士林夜市"])
	{
		[detailViewController init:@"nightmarket.png" NavTitle:view.annotation.title];	
	}
	//經濟部DEMO POI
	/*	經濟部 (25.027935299122106, 121.5168035030365)
	 中正紀念堂 (25.034652613569115, 121.52183532714844)
	 捷運古亭站 (25.027070090065664, 121.52237176895142)
	 建國中學 (25.03123081482577, 121.5128231048584)
	 總統府 (25.040076746689472, 121.5119218826294)
	 國家戲劇院 (25.035255306871402, 121.5182089805603)
	 國家音樂廳 (25.03700504484288, 121.51915311813354)
	 大安森林公園 (25.030200368098846, 121.53578281402588)
	 龍山寺 (25.036820351457415, 121.49994850158691)
	 */	
	else if([view.annotation.title isEqual: @"經濟部"])
	{
		[detailViewController init:@"Eco.png" NavTitle:view.annotation.title];	
	}
	else if([view.annotation.title isEqual: @"中正紀念堂"])
	{
		[detailViewController init:@"KStemple.png" NavTitle:view.annotation.title];	
	}
	else if([view.annotation.title isEqual: @"捷運古亭站"])
	{
		[detailViewController init:@"Guting.png" NavTitle:view.annotation.title];	
	}
	else if([view.annotation.title isEqual: @"建國中學"])
	{
		[detailViewController init:@"seniorschool.png" NavTitle:view.annotation.title];	
	}
	else if([view.annotation.title isEqual: @"總統府"])
	{
		[detailViewController init:@"president.png" NavTitle:view.annotation.title];	
	}
	else if([view.annotation.title isEqual: @"國家戲劇院"])
	{
		[detailViewController init:@"drama.png" NavTitle:view.annotation.title];	
	}
	else if([view.annotation.title isEqual: @"國家音樂廳"])
	{
		[detailViewController init:@"music.png" NavTitle:view.annotation.title];	
	}
	else if([view.annotation.title isEqual: @"大安森林公園"])
	{
		[detailViewController init:@"park.png" NavTitle:view.annotation.title];	
	}
	else if([view.annotation.title isEqual: @"龍山寺"])
	{
		[detailViewController init:@"LStemple.png" NavTitle:view.annotation.title];	
	}
	else if([view.annotation.title isEqual: @"B 43"])
	{
		[detailViewController init:@"B43.png" NavTitle:view.annotation.title];	
	}
	else if([view.annotation.title isEqual: @"B 40"])
	{
		[detailViewController init:@"B40.png" NavTitle:view.annotation.title];	
	}
	else if([view.annotation.title isEqual: @"UC Berkeley"])
	{
		[detailViewController init:@"UCBerkeley.png" NavTitle:view.annotation.title];	
	}
	else if([view.annotation.title isEqual: @"Bay Bridge"])
	{
		[detailViewController init:@"Baybridge.png" NavTitle:view.annotation.title];	
	}
	else if([view.annotation.title isEqual: @"Golden Gate Bridge"])
	{
		[detailViewController init:@"GoldenGate.png" NavTitle:view.annotation.title];	
	}
	else if([view.annotation.title isEqual: @"San Francisco"])
	{
		[detailViewController init:@"SF.png" NavTitle:view.annotation.title];	
	}
	else if([view.annotation.title isEqual: @"Berkeley Yacht Harbor"])
	{
		[detailViewController init:@"YachtHarbor.png" NavTitle:view.annotation.title];	
	}
	else if([view.annotation.title isEqual: @"Stanford University"])
	{
		[detailViewController init:@"Stanford.png" NavTitle:view.annotation.title];	
	}
	//earthmine around
	else if([view.annotation.title isEqual: @"earthmine"])
	{
		[detailViewController init:@"earthmine.png" NavTitle:view.annotation.title];	
	}
	else if([view.annotation.title isEqual: @"Vik's Chaat Corner"])
	{
		[detailViewController init:@"vik.png" NavTitle:view.annotation.title];	
	}
	else if([view.annotation.title isEqual: @"Laborde Architecture"])
	{
		[detailViewController init:@"laborde.png" NavTitle:view.annotation.title];	
	}	
	
	else if([view.annotation.title isEqual: @"LifeLong Medical Care"])
	{
		[detailViewController init:@"lifelong.png" NavTitle:view.annotation.title];	
	}
	else if([view.annotation.title isEqual: @"All Things Computers"])
	{
		[detailViewController init:@"ATC.png" NavTitle:view.annotation.title];	
	}
	
/*	else if([view.annotation.title isEqual: @"Berkeley Yacht Harbor"])
	{
		[detailViewController init:@"YachtHarbor.png" NavTitle:view.annotation.title];	
	}	
	else if([view.annotation.title isEqual: @"Berkeley Yacht Harbor"])
	{
		[detailViewController init:@"YachtHarbor.png" NavTitle:view.annotation.title];	
	}	
*/	
	[self.navigationController pushViewController:self.detailViewController animated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
	//NSLog(@"annotationview");
	if ([annotation isKindOfClass:[SFAnnotation class]]) 
    {
		MKPinAnnotationView *pinView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation
																	   reuseIdentifier:@"pinViewTest"]autorelease];
		pinView.pinColor = MKPinAnnotationColorRed;
		pinView.animatesDrop = YES;
		pinView.canShowCallout = YES;
		
		NSLog(@"ori %@", annotation.title);
		
		if(
		   [annotation.title isEqual:@"美麗華"] 
		   || [annotation.title isEqual:@"圓山大飯店"]
		   || [annotation.title isEqual:@"捷運劍南路站"]
		   || [annotation.title isEqual:@"Wego"]
		   || [annotation.title isEqual:@"典華婚宴會場"]
		   || [annotation.title isEqual:@"松山機場"]		   
		   || [annotation.title isEqual:@"台北市立美術館"]
		   || [annotation.title isEqual:@"捷運圓山站"]
		   || [annotation.title isEqual:@"士林夜市"]
		   || [annotation.title isEqual:@"經濟部"]
		   || [annotation.title isEqual:@"中正紀念堂"]
		   || [annotation.title isEqual:@"捷運古亭站"]
		   || [annotation.title isEqual:@"建國中學"]
		   || [annotation.title isEqual:@"總統府"]
		   || [annotation.title isEqual:@"國家戲劇院"]
		   || [annotation.title isEqual:@"國家音樂廳"]
		   || [annotation.title isEqual:@"大安森林公園"]
		   || [annotation.title isEqual:@"龍山寺"]

		   || [annotation.title isEqual:@"Laborde Architecture"]
		   || [annotation.title isEqual:@"LifeLong Medical Care"]
		   || [annotation.title isEqual:@"All Things Computers"]
		   
		   
		   || [annotation.title isEqual:@"B 43"]
		   || [annotation.title isEqual:@"B 40"]
		   || [annotation.title isEqual:@"UC Berkeley"]
		   || [annotation.title isEqual:@"Bay Bridge"]
		   || [annotation.title isEqual:@"Golden Gate Bridge"]
		   || [annotation.title isEqual:@"San Francisco"]
		   || [annotation.title isEqual:@"Berkeley Yacht Harbor"]
		   || [annotation.title isEqual:@"Stanford University"]
		   || [annotation.title isEqual:@"earthmine"]
		   || [annotation.title isEqual:@"Vik's Chaat Corner"]
		   )
		{
			NSLog(@"pic %@", annotation.title);
			
			//detailViewController = [[Detail1 alloc] init:@"miramar.png" NavTitle:annotation.title];
			//[detailViewController init:@"miramar.png" NavTitle:annotation.title];
			UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//			[rightButton addTarget:self
//							action:@selector(showDetails:)
//			forControlEvents:UIControlEventTouchUpInside];
			pinView.rightCalloutAccessoryView = rightButton;
		}
		else{
			//left image tag
			NSLog(@"nopic %@", annotation.title);
			UIImageView *sfIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SFIcon.png"]];
			pinView.leftCalloutAccessoryView = sfIconView;
			[sfIconView release];
		}
		return pinView;
	}
	return nil;
}


//issac 0521 for annotation distance
-(double) computeRelativeDistance : (CLLocation *)myLocation Destination: (CLLocationCoordinate2D)destCoordinate
{
	CLLocation *localLocation = [[[CLLocation alloc] initWithLatitude:destCoordinate.latitude longitude:destCoordinate.longitude]autorelease];
	//(CLLocationDistance)distanceFromLocation:(const CLLocation *)location
	//CLLocationDistance distance = [myCoordinate distanceFromLocation:localLocation];
	
	//CLLocationDistance distance = [myLocation distanceFromLocation:localLocation];
	CLLocationDistance distance = [myLocation getDistanceFrom:localLocation];
	return distance;
}

//issac 0504 for map point
- (void)/*(SFAnnotation *)*/ createMapPoint:(MKMapView *)mapView coordinateX:(double)coorX coordinateY:(double)coorY
									  Title:(NSString*)title Subtitle:(NSString*)subtitle Number:(int)Num
{
	if(mapView!=nil){

		//set POI lat and lng
		CLLocationCoordinate2D p1;
		//SFAnnotation *poi = [[SFAnnotation alloc] init ];
		SFAnnotation *poi;
		if(coorX && coorY){
			p1.latitude=coorX;
			p1.longitude = coorY;
			poi = [[SFAnnotation alloc] initWithCoords:p1]; 
			//[poi initWithCoords:p1];
			if(title!=NULL)
				poi.title=title;
			
			NSLog(@"%@", poi.title);
			
			//if(subtitle!=NULL)
			//	poi.subtitle=subtitle;
			
			poi.Number = Num;
			
			//count the distance
			poi.distance = [self computeRelativeDistance:locationCurrent Destination:poi.coordinate];
			NSString *myString = [NSString stringWithFormat:@"%.0f meters away", poi.distance];
			poi.subtitle = myString;
			
			[self.myMap2 addAnnotation:poi];
			
			
			//add annotation into array
			//[annoArray addObject:poi];

			//[self.myMap2 deselectAnnotation:poi animated:YES];
			//[self.myMap2 selectAnnotation:poi animated:FALSE];
			//NSLog(@"createMappoint!");
			[poi release];
			
		}
		//return poi;
	}
	//return nil;
}	

- (void) performDismiss
{
	//test 0520
	//maxdistance = 0.0;

	//locationCurrent = [[CLLocation alloc] initWithLatitude:updatedLocation.latitude longitude:updatedLocation.longitude];

	//issac 0608 singleton
	ARDataSingleton *singleton = [ARDataSingleton sharedData];
	//[singleton.myLocation initWithLatitude:locationCurrent.latitude longitude:locationCurrent.longitude];
	locationCurrent = [[CLLocation alloc] initWithLatitude:singleton.myLocation.coordinate.latitude
												 longitude:singleton.myLocation.coordinate.longitude];
	
//	NSLog(@"%f %f", locationCurrent.coordinate.latitude, locationCurrent.coordinate.longitude);
	
	[self setMyMap];
}
- (void) action
{
	// Auto dismiss after 3 seconds for this example
	[self performSelector:@selector(performDismiss) withObject:nil
			   afterDelay:0.1f];
}


- (void)setMyPoint
{
	/*	CLLocationCoordinate2D p1;
	 p1.latitude = 25.063546878877353;
	 p1.longitude = 121.55214657064167;
	 CLLocationCoordinate2D p2;
	 p2.latitude = 25.054896374127832;
	 p2.longitude = 121.55742009489931;
	 */	
	/*	[self createMapPoint:myMap2 
	 coordinateX:<#(double)coorX#> 
	 coordinateY:<#(double)coorY#> 
	 Title:<#(NSString *)title#> 
	 Subtitle:<#(NSString *)subtitle#>];
	 */
	//SFAnnotation place[10];
/*	
 {"台北 101 "      , 25.033492284074082, 121.56422018047304, 0, 0}, *
 {"松山機場 "      , 25.063546878877353, 121.55214657064167, 0, 0},*
 {"台朔大樓 "      , 25.056658542397958, 121.54969738657833, 0, 0},
 {"京華城 "        , 25.047693297937872, 121.56186702154896, 0, 0},
 {"松山醫院 "      , 25.054896374127832, 121.55742009489931, 0, 0},*
 {"捷運中山國中站 ", 25.060939860674153, 121.54424535064861, 0, 0},
 {"美麗華 "        , 25.083754775873032, 121.55733263292502, 0, 0}}*
 
 wego (25.08380126794627, 121.55585646629333)*
 典華 (25.08395673961566, 121.55519127845764)*
 台北戀館 (25.082994755492088, 121.55490159988403)
 家樂福 (25.08228540882096, 121.55800223350525)*
 維多利亞酒店 (25.08411221108758, 121.55877470970154)*
 國防部史政編輯室 (25.08548229489565, 121.55490159988403)
 捷運劍南路站 (25.084850697882406, 121.55558824539185)*
 
 大直捷運站 (25.07953543698054, 121.54685497283936)
 西湖捷運站 (25.082139652146584, 121.5671968460083)
 圓山大飯店 (25.078602570310615, 121.52626633644104)*
 大佳河濱公園 (25.07510425699454, 121.5304183959961)*
 兒童育樂中心 (25.073393934108477, 121.52217864990234)
 
 台北市立美術館 (25.07213061209311, 121.52445316314697)
 圓山捷運站 (25.071353176683118, 121.52015089988708)
 士林夜市 (25.0868815135935, 121.52545094490051)
*/
	
	
	NSLog(@"point");

//	locationCurrent = [locationCurrent initWithLatitude:updatedLocation.latitude longitude:updatedLocation.longitude];
	//locationCurrent = [locationCurrent initWithLatitude:updatedLocation.latitude longitude:updatedLocation.longitude];
//	NSLog(@"%f %f", updatedLocation.latitude, updatedLocation.longitude);
	
	detailViewController = [Detail1 alloc];
	[self createMapPoint:myMap2 
					  coordinateX:25.063546878877353 
					  coordinateY:121.55214657064167 
							Title:@"松山機場" 
						 Subtitle:@"飛航國內與兩岸航班"
				  Number:0];
	[self createMapPoint:myMap2 
					  coordinateX:25.054896374127832 
					  coordinateY:121.55742009489931 
							Title:@"松山醫院" 
				Subtitle:@"醫院"
				  Number:1];

	[self createMapPoint:myMap2 
					  coordinateX:25.033492284074082 
					  coordinateY:121.56422018047304 
							Title:@"台北 101" 
				Subtitle:@"世界第二高樓"
				  Number:2];

	[self createMapPoint:myMap2 
					  coordinateX:25.083754775873032 
					  coordinateY:121.55733263292502 
							Title:@"美麗華" 
				Subtitle:@"摩天輪 IMAX影城"
				  Number:3];

	[self createMapPoint:myMap2 
					  coordinateX:25.08395673961566 
					  coordinateY:121.55519127845764 
							Title:@"典華婚宴會場" 
				Subtitle:@"舉辦中外各式婚宴"
				  Number:4];

	[self createMapPoint:myMap2 
				  coordinateX:25.08380126794627 
					  coordinateY:121.55585646629333 
							Title:@"Wego" 
				Subtitle:@"薇閣旅舍"
				  Number:5];
	

	[self createMapPoint:myMap2 
					  coordinateX:25.08411221108758 
					  coordinateY:121.55877470970154 
							Title:@"維多利亞酒店" 
				Subtitle:@"知名飯店 提供中西式餐點"
				  Number:6];

	[self createMapPoint:myMap2 
					  coordinateX:25.08228540882096 
					  coordinateY:121.55800223350525 
							Title:@"家樂福" 
				Subtitle:@"知名大型量販店"
				  Number:7];

		[self createMapPoint:myMap2 
					  coordinateX:25.084850697882406 
					  coordinateY:121.55558824539185 
							Title:@"捷運劍南路站" 
				Subtitle:@"Jiannan RD. MRT Station"
					  Number:8];
	
	[self createMapPoint:myMap2 
				   coordinateX:25.078602570310615 
				   coordinateY:121.52626633644104 
							 Title:@"圓山大飯店" 
				Subtitle:@"VTC Conference"
				  Number:9];

	
	[self createMapPoint:myMap2 
			 coordinateX:25.07510425699454 
			 coordinateY:121.5304183959961 
				   Title:@"大佳河濱公園" 
				Subtitle:@"提供民眾遊憩活動"
				  Number:10];

	
	[self createMapPoint:myMap2 
			 coordinateX:25.073393934108477 
			 coordinateY:121.52217864990234 
				   Title:@"兒童育樂中心" 
				Subtitle:@"兒童遊樂園"
				  Number:11];
	
	[self createMapPoint:myMap2 
			 coordinateX:25.07213061209311 
			 coordinateY:121.52445316314697 
				   Title:@"台北市立美術館" 
				Subtitle:@"北美館典藏作品展 3/6 ~ 8/15"
				  Number:12];
	
	[self createMapPoint:myMap2 
			 coordinateX:25.071353176683118 
			 coordinateY:121.52015089988708
				   Title:@"捷運圓山站" 
				Subtitle:@"Yuanshan MRT Station"
				  Number:13];
	
	[self createMapPoint:myMap2 
			 coordinateX:25.0868815135935
			 coordinateY:121.52545094490051
				   Title:@"士林夜市" 
				Subtitle:@"台北市最具規模著名夜市"
				  Number:14];

	//經濟部DEMO POI
	/*	經濟部 (25.027935299122106, 121.5168035030365)
	 中正紀念堂 (25.034652613569115, 121.52183532714844)
	 捷運古亭站 (25.027070090065664, 121.52237176895142)
	 建國中學 (25.03123081482577, 121.5128231048584)
	 總統府 (25.040076746689472, 121.5119218826294)
	 國家戲劇院 (25.035255306871402, 121.5182089805603)
	 國家音樂廳 (25.03700504484288, 121.51915311813354)
	 大安森林公園 (25.030200368098846, 121.53578281402588)
	 龍山寺 (25.036820351457415, 121.49994850158691)
	 */	
	[self createMapPoint:myMap2 
			 coordinateX:25.027935299122106
			 coordinateY:121.5168035030365
				   Title:@"經濟部" 
				Subtitle:@"福州街"
				  Number:15];	
	
	[self createMapPoint:myMap2 
			 coordinateX:25.034652613569115
			 coordinateY:121.52183532714844
				   Title:@"中正紀念堂" 
				Subtitle:@"中正文化中心"
				  Number:16];	

	[self createMapPoint:myMap2 
			 coordinateX:25.027070090065664
			 coordinateY:121.52237176895142
				   Title:@"捷運古亭站" 
				Subtitle:@"MRT Station"
				  Number:17];	

	[self createMapPoint:myMap2 
			 coordinateX:25.03123081482577
			 coordinateY:121.5128231048584
				   Title:@"建國中學" 
				Subtitle:@""
				  Number:18];	

	[self createMapPoint:myMap2 
			 coordinateX:25.040076746689472
			 coordinateY:121.5119218826294
				   Title:@"總統府" 
				Subtitle:@""
				  Number:19];	

	[self createMapPoint:myMap2 
			 coordinateX:25.03700504484288
			 coordinateY:121.51915311813354
				   Title:@"國家音樂廳" 
				Subtitle:@""
				  Number:20];	
	
	[self createMapPoint:myMap2 
			 coordinateX:25.030200368098846
			 coordinateY:121.53578281402588
				   Title:@"大安森林公園" 
				Subtitle:@""
				  Number:21];	

	[self createMapPoint:myMap2 
			 coordinateX:25.036820351457415
			 coordinateY:121.49994850158691
				   Title:@"龍山寺" 
				Subtitle:@""
				  Number:22];	
	
	[self createMapPoint:myMap2 
			 coordinateX:25.035255306871402 
			 coordinateY:121.5182089805603
				   Title:@"國家戲劇院" 
				Subtitle:@""
				  Number:23];

	
	[self createMapPoint:myMap2 
			 coordinateX:37.424843 
			 coordinateY:-122.094412 
				   Title:@"B 2375" 
				Subtitle:@"Google Building"
				  Number:24];
	[self createMapPoint:myMap2 
			 coordinateX:37.424128 
			 coordinateY:-122.094948 
				   Title:@"B 2350" 
				Subtitle:@""
				  Number:25];
	
	[self createMapPoint:myMap2 
			 coordinateX:37.424179 
			 coordinateY:-122.094117 
				   Title:@"B sal3" 
				Subtitle:@""
				  Number:26];
	
	[self createMapPoint:myMap2 
			 coordinateX:37.423906 
			 coordinateY:-122.092540 
				   Title:@"B sal" 
				Subtitle:@""
				  Number:27];
	
	[self createMapPoint:myMap2 
			 coordinateX:37.423872 
			 coordinateY:-122.091644 
				   Title:@"B c" 
				Subtitle:@""
				  Number:28];
	
	[self createMapPoint:myMap2 
			 coordinateX:37.423135 
			 coordinateY:-122.092534 
				   Title:@"B sal2" 
				Subtitle:@""
				  Number:29];
	
	
	[self createMapPoint:myMap2 
			 coordinateX:37.422551 
			 coordinateY:-122.090555 
				   Title:@"B 1945" 
				Subtitle:@""
				  Number:30];
	
	[self createMapPoint:myMap2 
			 coordinateX:37.421746 
			 coordinateY:-122.090233 
				   Title:@"B 1965" 
				Subtitle:@""
				  Number:31];
	
	[self createMapPoint:myMap2 
			 coordinateX:37.422828 
			 coordinateY:-122.088613 
				   Title:@"B 2000" 
				Subtitle:@""
				  Number:32];
	
	[self createMapPoint:myMap2 
			 coordinateX:37.422863 
			 coordinateY:-122.087551 
				   Title:@"B 1900" 
				Subtitle:@""
				  Number:33];
	
	
	[self createMapPoint:myMap2 
			 coordinateX:37.421964 
			 coordinateY:-122.087561 
				   Title:@"B 1950" 
				Subtitle:@""
				  Number:34];
	
	
	[self createMapPoint:myMap2 
			 coordinateX:37.420080 
			 coordinateY:-122.086129 
				   Title:@"B 1098" 
				Subtitle:@""
				  Number:35];

	[self createMapPoint:myMap2 
			 coordinateX:37.420098 
			 coordinateY:-122.083608
				   Title:@"B 44" 
				Subtitle:@""
				  Number:36];
	
	[self createMapPoint:myMap2 
			 coordinateX:37.420089
			 coordinateY:-122.082031
				   Title:@"B 45" 
				Subtitle:@""
				  Number:37];
	
	[self createMapPoint:myMap2 
			 coordinateX:37.419071
			 coordinateY:-122.082267
				   Title:@"B 46" 
				Subtitle:@""
				  Number:38];	
	
	[self createMapPoint:myMap2 
			 coordinateX:37.419243
			 coordinateY:-122.081156
				   Title:@"B 47" 
				Subtitle:@""
				  Number:39];	
	
	[self createMapPoint:myMap2 
			 coordinateX:37.418760
			 coordinateY:-122.079713
				   Title:@"B 1055" 
				Subtitle:@""
				  Number:40];	
	
	[self createMapPoint:myMap2 
			 coordinateX:37.422458
			 coordinateY:-122.085550
				   Title:@"B 41" 
				Subtitle:@""
				  Number:41];	
	
	[self createMapPoint:myMap2 
			 coordinateX:37.421589
			 coordinateY:-122.085679
				   Title:@"B 42" 
				Subtitle:@""
				  Number:42];	
	
	[self createMapPoint:myMap2 
			 coordinateX:37.422407
			 coordinateY:-122.084541
				   Title:@"B 40" 
				Subtitle:@""
				  Number:43];	
	
	[self createMapPoint:myMap2 
			 coordinateX:37.421435
			 coordinateY:-122.084069
				   Title:@"B 43" 
				Subtitle:@""
				  Number:44];
	
	[self createMapPoint:myMap2 
			 coordinateX:37.874853
			 coordinateY:-122.245474
				   Title:@"UC Berkeley" 
				Subtitle:@""
				  Number:45];	
	
	[self createMapPoint:myMap2 
			 coordinateX:37.816158
			 coordinateY:-122.353020
				   Title:@"Bay Bridge" 
				Subtitle:@""
				  Number:46];
	
	[self createMapPoint:myMap2 
			 coordinateX:37.820904
			 coordinateY:-122.479362
				   Title:@"Golden Gate Bridge" 
				Subtitle:@""
				  Number:47];
	
	[self createMapPoint:myMap2 
			 coordinateX:37.769901
			 coordinateY:-122.419281
				   Title:@"San Francisco" 
				Subtitle:@""
				  Number:48];
	
	[self createMapPoint:myMap2 
			 coordinateX:37.861573
			 coordinateY:-122.321777
				   Title:@"Berkeley Yacht Harbor" 
				Subtitle:@""
				  Number:49];
	
	[self createMapPoint:myMap2 
			 coordinateX:37.423889
			 coordinateY:-122.166595
				   Title:@"Stanford University" 
				Subtitle:@""
				  Number:50];
	
	[self createMapPoint:myMap2 
			 coordinateX:37.862043
			 coordinateY:-122.298244
				   Title:@"earthmine" 
				Subtitle:@""
				  Number:51];
	//earthmine
	[self createMapPoint:myMap2 
			 coordinateX:37.861014
			 coordinateY:-122.298238
				   Title:@"Laborde Architecture" 
				Subtitle:@""
				  Number:0];
	
	[self createMapPoint:myMap2 
			 coordinateX:37.862657
			 coordinateY:-122.299966
				   Title:@"All Things Computers" 
				Subtitle:@""
				  Number:0];
	
	[self createMapPoint:myMap2 
			 coordinateX:37.861942
			 coordinateY:-122.296039
				   Title:@"LifeLong Medical Care" 
				Subtitle:@""
				  Number:0];
	
	
	[self createMapPoint:myMap2 
			 coordinateX:37.861357
			 coordinateY:-122.298244
				   Title:@"Vik's Chaat Corner" 
				Subtitle:@""
				  Number:52];
		
	
	NSLog(@"point over");
}

-(void)setMyMap{
	[myMap2 initWithFrame:CGRectMake(-95, -70, 520, 660)];
//	myMap2 =[[[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)]autorelease];
//	myMap2 =[[[MKMapView alloc] initWithFrame:CGRectMake(-110, -110, 520, 660)]autorelease];
//	myMap2 = [[[MKMapView alloc] 
//				initWithFrame:CGRectMake(0.0,0.0,self.view.frame.size.width,self.view.frame.size.height)]autorelease];
//	myMap2 = [[[MKMapView alloc] initWithFrame:self.view.bounds]autorelease];
//	NSLog(@"%f",[[UIScreen mainScreen]description]);

	//[myMap2 showsUserLocation]; 

	myMap2.mapType = MKMapTypeHybrid;
	myMap2.showsUserLocation = YES;
	
	//important!
	myMap2.delegate = self;
	
	//MKCoordinateRegion region2;
	
	//region2.center = myMap2.userLocation.coordinate;
	
	//issac 0608 singleton test
	region2.center.latitude = locationCurrent.coordinate.latitude;
	region2.center.longitude = locationCurrent.coordinate.longitude;
	
	
	//美麗華
	//region2.center.latitude = 25.083754775873032;
	//region2.center.longitude = 121.55733263292502;
	//經濟部
//	region2.center.latitude = 25.027935299122106;
//	region2.center.longitude = 121.5168035030365;
	//no iphone test
	//locationCurrent = [locationCurrent initWithLatitude:region2.center.latitude longitude:region2.center.longitude];
	
	
    MKCoordinateSpan span;
	
	span.latitudeDelta=.010;
	span.longitudeDelta=.010;
	
	region2.span = span;
	//zoom out by issac
	//region.span.latitudeDelta = region.span.latitudeDelta * 0.5;
	//region.span.longitudeDelta = region.span.longitudeDelta * 0.5;
	//[mylocationtest arrayWithObjects:];
	//MKPlacemark *placemark=[[MKPlacemark alloc] initWithCoordinate:region2.center];
	//mPlacemark = [MKPlacemark alloc];
	//[myMap2 addAnnotation:mPlacemark];
	//[self.myMap2 viewForAnnotation:place1];
	//[self.myMap2 viewForAnnotation:place1];
	
	[self setMyPoint];
	
	//[self.myMap2 addAnnotations:myPointArray];
/*	SFAnnotation *place1;

	CLLocationCoordinate2D p1;
	p1.latitude = 25.063546878877353;
	p1.longitude = 121.55214657064167;
	
	place1 = [[SFAnnotation alloc] initWithCoords:p1];

	[self.myMap2 addAnnotation:place1 ];
*/	NSLog(@"annotation 1");
	
	[self.myMap2 setRegion:region2 animated:YES];
	NSLog(@"annotation 2");
	
	[self.view addSubview:myMap2];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	//issac 0511
	// create a custom navigation bar button and set it to always says "Back"
	UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
	temporaryBarButtonItem.title = @"BACK";
	self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
	//NSString *temp = [[NSString alloc] init];
	//temp = @"周圍景點地圖";
	//self.navigationItem.title = temp;
	[temporaryBarButtonItem release];
	
	locationCurrent = [CLLocation alloc];
	//[self settingLocationManager];

//	[self action];
	//issac 0608 singleton
	ARDataSingleton *singleton = [ARDataSingleton sharedData];
	//[singleton.myLocation initWithLatitude:locationCurrent.latitude longitude:locationCurrent.longitude];
	locationCurrent = [[CLLocation alloc] initWithLatitude:singleton.myLocation.coordinate.latitude
												 longitude:singleton.myLocation.coordinate.longitude];
	
	//	NSLog(@"%f %f", locationCurrent.coordinate.latitude, locationCurrent.coordinate.longitude);
	
	//text from file test 0722
	if(text = nil)
	{
		NSString *fPath = [[NSBundle mainBundle] pathForResource:@"text" ofType:@"txt"];
		text = [[NSString alloc] initWithContentsOfFile:fPath
									   usedEncoding:nil
											  error:nil];
		textarray = [text componentsSeparatedByString:"\n"];
	}
	
	[self setMyMap];
	
	//self.parentViewController.view = self.view ;
}
/*
-(void)viewWillAppear:(BOOL)animated
{
	NSLog(@"viewAppear1");
	for (id currentAnnotation in myMap2.annotations) {
		//if ([currentAnnotation isEqual:annotationToSelect]) {
		if ([currentAnnotation isKindOfClass:[SFAnnotation class]]) {
			//NSLog(@"didloadmap2");
			//[mapView deselectAnnotation:currentAnnotation animated:YES];
			//[mapView selectAnnotation:currentAnnotation animated:YES];
			[myMap2 selectAnnotation:currentAnnotation animated:FALSE];
		}
		//}
	}
	
}
*/
// Override to allow orientations other than the default portrait orientation.
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
//}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	//[self dismissModalViewControllerAnimated:YES];
	self.myMap2 = nil;
    self.detailViewController = nil;
	self.locationCurrent = nil;
	[locManager stopUpdatingHeading];
	[locManager stopUpdatingLocation];
}


- (void)dealloc {
	//[self dismissModalViewControllerAnimated:YES];
	//[locManager release];
	[detailViewController release];
	[myMap2 release];
	[locationCurrent release];
	
    [super dealloc];
}


@end
