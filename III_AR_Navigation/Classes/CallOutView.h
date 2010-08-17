//
//  CallOutView.h
//  CallOutView
//
//  Created by Hendrik Holtmann on 18.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CallOutView : UIView {

	UIImageView *calloutLeft;
	UIImageView *calloutCenter;
	UIImageView *calloutRight;
	UIButton *calloutButton;
	UILabel *calloutLabel;
	NSString *text;
	CGAffineTransform transform;
	CGPoint calloutPoint;
}

+ (CallOutView*) addCalloutView:(UIView*)parent text:(NSString*)text point:(CGPoint)pt target:(id)target action:(SEL)selector;

-(void) setAnchorPoint:(CGPoint)pt;

-(id)initWithText:(NSString*)atext point:(CGPoint)point;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, retain) UILabel *calloutLabel;
@property (nonatomic) CGPoint calloutPoint;

@end
