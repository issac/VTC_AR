
#import "SFAnnotation.h"

@implementation SFAnnotation 

/*@synthesize image;
@synthesize latitude;
@synthesize longitude;
*/
@synthesize coordinate;

@synthesize subtitle,title;

@synthesize Number;
@synthesize bearing;
@synthesize distance;
@synthesize place;

- (id) initWithCoords:(CLLocationCoordinate2D) coords{
	
	self = [super init];
	
	if (self != nil) {
		
		coordinate = coords; 
		
	}
	
	Number = 0;
	
	return self;
	
}

- (id) initWithTextAndLocation : (NSString *)myTitle LocationX:(double)coorX LocationY:(double)coorY
{
	
	self= [super init];
	if (self!=nil) {
		coordinate.latitude = coorX;
		coordinate.longitude = coorY;
		if (myTitle !=nil) {
			title = myTitle;
		}
	}
	//}
	return self;
}
/*-(CLLocationCoordinate2D)coordinate
{
	CLLocationCoordinate2D theCoordinate;
	//theCoordinate.latitude = ;
	//theCoordinage.longitude = ;
	return theCoordinate;
}
*/
/*- (CLLocationCoordinate2D)coordinate:(CLLocationCoordinate2D)myCoord;
{
    //CLLocationCoordinate2D theCoordinate; 
	//theCoordinate = myCoord;
	coordinate = myCoord;
//    theCoordinate.latitude = 25.063546878877353;
//    theCoordinate.longitude = 121.55214657064167;
 //   return theCoordinate; 
	return coordinate;
}
*/
- (void)dealloc
{
    //[image release];
	[subtitle release];
	[title release];
    [super dealloc];
}

/*- (NSString *)title
{
    return @"San Francisco";
}

// optional
- (NSString *)subtitle
{
    return @"Founded: June 29, 1776";
}
*/
@end
