//
//  PopUpViewController.m
//  Runner
//
//  Created by William Souraphath on 11/15/15.
//  Copyright © 2015 Group9. All rights reserved.
//

#import "PopUpViewController.h"

@interface PopUpViewController ()

@end

@implementation PopUpViewController

@synthesize dateTime;

- (void)viewDidLoad {
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [[UIColor clearColor] colorWithAlphaComponent:0.6];
    self.popUpView.layer.cornerRadius = 5;
    self.popUpView.layer.shadowOpacity = 0.8;
    self.popUpView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    [super viewDidLoad];
}

-(void) showAnimate{
    self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.view.alpha = 0;
    [UIView animateWithDuration:0.25 animations:^{
        self.view.frame = CGRectMake(0, 40, 800, 1000);
        self.view.alpha = 1;
        self.view.transform = CGAffineTransformMakeScale(1, 1);
//        NSLog(@"%@", NSStringFromCGRect(self.view.frame));
    }];
}

-(void) removeAnimate{
    [UIView animateWithDuration:0.25 animations:^{
        self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.view.alpha = 0.0;
    } completion:^(BOOL finished){
        if(finished){
            [self.view removeFromSuperview];
        }
    }];
}

//Closes popup window
-(IBAction) closePopup:(id)sender{
    [self removeAnimate];
}

//Save run data to parse and close popup window
-(IBAction) saveRun:(id)sender {
    
    [self closePopup:sender];
}

-(void) showInView:(UIView*) aView animated:(BOOL)animated{
    [aView addSubview:self.view];
    if(animated){
        [self showAnimate];
    }
}

-(void) showInView:(UIView*) aView withImage:(UIImage*) image withPace:(NSString*) avgPace withDist:(NSString*) dist withTime: (NSString*) time withDate: (NSDate*) date withTopSpeed:(double) speed animated:(BOOL) animated{
    
    [aView addSubview:self.view];
    if(animated){
        self.avgSpeed.text = [NSString stringWithFormat:@"Average Speed: %@", avgPace];
        self.totalDist.text = [NSString stringWithFormat:@"Total Distance: %@", dist];
        _logoImg.image = image;
        
        //Splitting time string by delimiter :
        NSArray* lines = [time componentsSeparatedByString:@":"];
        self.time.text = [NSString stringWithFormat:@"Time: %@m %@s", lines[0], lines[1]];
        NSString* dateString = [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
        self.dateTime.text = [NSString stringWithFormat:@"%@", dateString];
        self.topSpeed.text = [NSString stringWithFormat:@"Top Speed: %.02f mps", speed];
        [self showAnimate];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
