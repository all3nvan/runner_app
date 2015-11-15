//
//  PopUpViewController.m
//  Runner
//
//  Created by abc on 11/15/15.
//  Copyright © 2015 Group9. All rights reserved.
//

#import "PopUpViewController.h"

@interface PopUpViewController ()

@end

@implementation PopUpViewController

- (void)viewDidLoad {
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    self.popUpView.layer.cornerRadius = 5;
    self.popUpView.layer.shadowOpacity = 0.8;
    self.popUpView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    [super viewDidLoad];
}

-(void) showAnimate{
    self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.view.alpha = 0;
    [UIView animateWithDuration:0.25 animations:^{
        self.view.alpha = 1;
        self.view.transform = CGAffineTransformMakeScale(1, 1);
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

-(IBAction) closePopup:(id)sender{
    [self removeAnimate];
}

-(void) showInView:(UIView*) aView animated:(BOOL)animated{
    [aView addSubview:self.view];
    if(animated){
        [self showAnimate];
    }
}

-(void) showInView:(UIView*) aView withImage:(UIImage*) image withMessage:(NSString*) message animated:(BOOL) animated{
    [aView addSubview:self.view];
    if(animated){
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
