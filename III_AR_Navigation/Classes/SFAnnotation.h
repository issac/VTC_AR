#import <MapKit/MapKit.h>

@interface SFAnnotation : NSObject <MKAnnotation>
{
	CLLocationCoordinate2D coordinate;
/*    UIImage *image;
    NSNumber *latitude;
    NSNumber *longitude;
*/	
	NSString *subtitle;
	NSString *title;
	int Number;
	double bearing;
	double distance;
	CGPoint place;
}
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

/*@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) NSNumber *latitude;
@property (nonatomic, retain) NSNumber *longitude;
*/
@property (nonatomic, retain) NSString *subtitle;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, assign) int Number;
@property (nonatomic, assign) double bearing;
@property (nonatomic, assign) double distance;
@property (nonatomic, assign) CGPoint place;

-(id) initWithCoords:(CLLocationCoordinate2D) coords;
-(id) initWithTextAndLocation:(NSString *)myTitle LocationX:(double)coorX LocationY:(double)coorY;
@end


