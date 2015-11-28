//
//  ProfileViewController.m
//  Runner
//
//  Created by Yassir Jamal on 11/18/15.
//  Copyright © 2015 Group9. All rights reserved.
//

#import "ProfileViewController.h"
#import "SWRevealViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    SWRevealViewController *revealViewController = self.revealViewController;
//    if (revealViewController)
//    {
        [self.menuButton setTarget: revealViewController];
        [self.menuButton setAction: @selector( revealToggle:)];
        [self.view addGestureRecognizer:revealViewController.panGestureRecognizer];
//    }
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
