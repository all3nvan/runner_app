//
//  SidebarTableViewController.h
//  Runner
//
//  Created by Yassir Jamal on 10/28/15.
//  Copyright © 2015 Group9. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SidebarTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *menuOptions;
@property (weak, nonatomic) IBOutlet UIButton *showHistory;
@property (weak, nonatomic) IBOutlet UIButton *logout;
@property (weak, nonatomic) IBOutlet UIButton *showSettings;
@property (weak, nonatomic) IBOutlet UIButton *showHome;
@end
