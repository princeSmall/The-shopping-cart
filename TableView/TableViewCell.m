//
//  TableViewCell.m
//  TableView
//
//  Created by tongle on 2017/5/4.
//  Copyright © 2017年 tongle. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.btn setBackgroundImage:[UIImage imageNamed:@"choose"] forState:UIControlStateNormal];
    self.topView.hidden = YES;
    // Initialization code
}
-(void)updateUI:(NSIndexPath *)indexPath{
    self.photoImage.image = self.model.photoImage;
    self.numberLab.text = [NSString stringWithFormat:@"x %ld",self.model.number];
    self.bottomLab.text = [NSString stringWithFormat:@"$ %ld",self.model.price];
    self.midLab.text = self.model.info;
    self.topLab.text = self.model.title;
    self.centerNumberLab.text = [NSString stringWithFormat:@"%ld",self.model.number];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)selectBtn:(id)sender {

}

- (IBAction)subBtn:(id)sender {
    if ([self.centerNumberLab.text integerValue]  < 2) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"不能再少了" delegate:nil cancelButtonTitle:@"好哒" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        self.centerNumberLab.text = [NSString stringWithFormat:@"%ld",[self.centerNumberLab.text integerValue] - 1];
        self.model.number = [self.centerNumberLab.text integerValue] ;
        self.numberLab.text = [NSString stringWithFormat:@"x %ld",self.model.number];
    }
}

- (IBAction)addBtn:(id)sender {
    self.centerNumberLab.text = [NSString stringWithFormat:@"%ld",[self.centerNumberLab.text integerValue] + 1];
    self.model.number = [self.centerNumberLab.text integerValue] ;
    self.numberLab.text = [NSString stringWithFormat:@"x %ld",self.model.number];
}
@end
