//
//  CameraDelegate.h
//  III_AR_Navigation
//
//  Created by Chun F.Hsu on 2010/4/9.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CameraDelegate : NSObject <UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
	UIImage *selectedImage;

}
@property (nonatomic,retain) UIImage *selectedImage;
@end
