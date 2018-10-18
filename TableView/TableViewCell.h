//
//  TableViewCell.h
//  TableView
//
//  Created by iOS on 2017/5/4.
//  Copyright © 2017年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NumberModel.h"

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btn;
- (IBAction)selectBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView * photoImage;
@property (weak, nonatomic) IBOutlet UILabel * topLab;
@property (weak, nonatomic) IBOutlet UILabel * midLab;
@property (weak, nonatomic) IBOutlet UILabel * bottomLab;
@property (weak, nonatomic) IBOutlet UILabel * numberLab;
@property (weak, nonatomic) IBOutlet UIView *topView;
- (IBAction)subBtn:(id)sender;
- (IBAction)addBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *centerNumberLab;

@property (nonatomic,strong) NumberModel * model;
-(void)updateUI:(NSIndexPath *)indexPath;

@end
