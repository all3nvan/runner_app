//
//  MenuViewController.h
//  Runner
//
//  Created by William Souraphath on 10/28/15.
//  Copyright © 2015 Group9. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *menuOptions;


@end
