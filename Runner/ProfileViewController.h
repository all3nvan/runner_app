//
//  ProfileViewController.h
//  Runner
//
//  Created by Yassir Jamal on 11/18/15.
//  Copyright © 2015 Group9. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuButton;
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *joinLabel;
@property (weak, nonatomic) IBOutlet UILabel *numOfRuns;
@property (weak, nonatomic) IBOutlet UILabel *totalCalories;
@property (weak, nonatomic) IBOutlet UILabel *topSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *avgCaloriesLabel;
@property (weak, nonatomic) IBOutlet UILabel *avgDistanceLabel;


@end
