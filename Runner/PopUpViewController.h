//
//  PopUpViewController.h
//  Runner
//
//  Created by William Souraphath on 11/15/15.
//  Copyright © 2015 Group9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"

@interface PopUpViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *popUpView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImg;
-(void) showInView:(UIView*) aView animated:(BOOL)animated;
-(void) showInView:(UIView*) aView withImage:(UIImage*) image withPace:(NSString*) avgPace withDist: (NSString*) dist withTime: (NSString*) time withDate:(NSDate*) date withTopSpeed:(double) speed animated:(BOOL) animated;
-(IBAction) closePopup:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *dateTime;
@property (weak, nonatomic) IBOutlet UILabel *avgSpeed;
@property (weak, nonatomic) IBOutlet UILabel *totalDist;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *topSpeed;
-(IBAction) saveRun:(id)sender;
@end
