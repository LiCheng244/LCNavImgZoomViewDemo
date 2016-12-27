//
//  UserInfoCell.m
//  导航栏头像缩放效果
//
//  Created by LiCheng on 2016/12/27.
//  Copyright © 2016年 LiCheng. All rights reserved.
//

#import "UserInfoCell.h"

@implementation UserInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(instancetype)craeteCell{
    
    return  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
}

@end
