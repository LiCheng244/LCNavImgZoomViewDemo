//
//  ListCell.h
//  导航栏头像缩放效果
//
//  Created by LiCheng on 2016/12/27.
//  Copyright © 2016年 LiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titlel;

+(instancetype)craeteCell;

@end
