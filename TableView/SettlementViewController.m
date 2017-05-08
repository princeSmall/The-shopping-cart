//
//  SettlementViewController.m
//  TableView
//
//  Created by tongle on 2017/5/8.
//  Copyright © 2017年 tongle. All rights reserved.
//

#import "SettlementViewController.h"

@interface SettlementViewController ()

@end

@implementation SettlementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithTitle:@"return" style:UIBarButtonItemStyleDone target:self action:@selector(dismissViewControllerAnimated:completion:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    // Do any additional setup after loading the view.
}
-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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
