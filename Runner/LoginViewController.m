//
//  LoginViewController.m
//  Runner
//
//  Created by Stuart Millner on 10/29/15.
//  Copyright © 2015 Group9. All rights reserved.
//

#import "LoginViewController.h"

@implementation LoginViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.signUpController.signUpView setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]]];
   [self.logInView setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]]];
    
}

@end
