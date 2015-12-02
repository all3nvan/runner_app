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
    [_run saveInBackground];
    
    for (PFObject *location in _locations) {
        [location saveInBackground];
    }
    
    [self closePopup:sender];
}

-(void) showInView:(UIView*) aView animated:(BOOL)animated{
    [aView addSubview:self.view];
    if(animated){
        [self showAnimate];
    }
}

-(void) showInView:(UIView*) aView withImage:(UIImage*) image withPace:(NSString*) avgPace withDist:(NSString*) dist withTime: (NSString*) time withDate: (NSDate*) date withTopSpeed:(double) speed withCalories:(CalorieCalculator*) caloriesBurned animated:(BOOL) animated{
    
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
        if(caloriesBurned.caloriesBurned >= 50){
            self.calories.text = [NSString stringWithFormat:@"Calories Burned: %.02f calories,\n %@", caloriesBurned.caloriesBurned, [caloriesBurned comparisonForCaloriesBurned]];
        }
        else{
            self.calories.text = [NSString stringWithFormat:@"Calories Burned: %.02f calories", caloriesBurned.caloriesBurned];
        }
        [self showAnimate];
    }
}

-(void) ShareFacebook{
    SLComposeViewController *fbController=[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];

    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        fbController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        SLComposeViewControllerCompletionHandler __block completionHandler=^(SLComposeViewControllerResult result){
            
            [fbController dismissViewControllerAnimated:YES completion:nil];
            
            switch(result){
                case SLComposeViewControllerResultCancelled:
                default:
                {
                    NSLog(@"Cancelled.....");
                    // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs://"]];
                    
                }
                    break;
                case SLComposeViewControllerResultDone:
                {
                    NSLog(@"Posted....");
                }
                    break;
            }};
        
        
        [fbController setInitialText:@"This is My Sample Text"];
        //        [fbController addImage: @"some image"];
        
        [fbController setCompletionHandler:completionHandler];
        
        [self presentViewController:fbController animated:YES completion:nil];
    }
    else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Please sign in to your Facebook account" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* login = [UIAlertAction actionWithTitle:@"Login" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self viewDidAppear:YES];
        }];
        UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
            [self viewDidAppear:YES];
        }];
        [alert addAction:login];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
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
