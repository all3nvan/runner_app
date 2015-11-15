//
//  PopUpViewController.h
//  Runner
//
//  Created by abc on 11/15/15.
//  Copyright © 2015 Group9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"

@interface PopUpViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *popUpView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImg;
-(void) showInView:(UIView*) aView animated:(BOOL)animated;
-(void) showInView:(UIView*) aView withImage:(UIImage*) image withMessage:(NSString*) message animated:(BOOL) animated;
-(IBAction) closePopup:(id)sender;
-(IBAction) saveRun:(id)sender;
@end
