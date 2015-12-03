//
//  RunImageViewController.m
//  Runner
//
//  Created by Allen Van on 12/2/15.
//  Copyright © 2015 Group9. All rights reserved.
//

#import "RunImageViewController.h"

@interface RunImageViewController ()

@end

@implementation RunImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    PFQuery *runQuery = [PFQuery queryWithClassName:@"Run"];

    [runQuery getObjectInBackgroundWithId:_runId block:^(PFObject * _Nullable object, NSError * _Nullable error) {
        PFFile *imageFile = [object objectForKey:@"image"];
        [imageFile getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
            _runImage = [UIImage imageWithData:data];
            UIImageView *newImage = [[UIImageView alloc] initWithImage:_runImage];
            _runImageView.image = newImage.image;
        }];
    }];
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
