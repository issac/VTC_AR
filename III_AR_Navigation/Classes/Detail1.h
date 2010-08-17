//
//  Detail1.h
//  III_AR_Navigation
//
//  Created by Chun F.Hsu on 2010/5/11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Detail1 : UIViewController <UITableViewDataSource, UITableViewDelegate>{
	UIImageView *myImageView;
	UITableView *myTableView;
	
	NSString *text; 
	NSArray *textarray;
	
	NSMutableArray *text_p;
}

@property (nonatomic, retain) IBOutlet UIImageView *myImageView;
@property (nonatomic, retain) IBOutlet UITableView *myTableView;

@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) NSArray *textarray;

@property (nonatomic, retain) NSMutableArray *text_p;

- (id)init:(NSString *)myName NavTitle:(NSString *)myTitle;
//- (void)myinit:(NSString *)myName NavTitle:(NSString *)myTitle;
@end
