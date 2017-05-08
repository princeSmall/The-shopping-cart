//
//  NumberModel.h
//  TableView
//
//  Created by tongle on 2017/5/4.
//  Copyright © 2017年 tongle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NumberModel : NSObject

@property (nonatomic,assign) NSInteger ID;

@property (nonatomic,assign) NSInteger  price;

@property (nonatomic,copy) NSString * title;

@property (nonatomic,copy) NSString * info;

@property (nonatomic,copy) UIImage * photoImage;

@property (nonatomic,assign) NSInteger  number;

@property (nonatomic,copy) NSString * useInfo;

@property (nonatomic,assign) BOOL isSelected;

@property (nonatomic,assign) BOOL  isEdit;

@end
