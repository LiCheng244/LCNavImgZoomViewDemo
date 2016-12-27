//
//  ViewController.m
//  导航栏头像缩放效果
//
//  Created by LiCheng on 2016/12/27.
//  Copyright © 2016年 LiCheng. All rights reserved.
//

#import "ViewController.h"
#import "UserInfoCell.h"
#import "ListCell.h"
#import "UIView+Frame.h"

#define LCScreenHeight [UIScreen mainScreen].bounds.size.height
#define LCBScreenWidth [UIScreen mainScreen].bounds.size.width
#define IconImgViewWidth 70


@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

/** tableView */
@property (nonatomic, strong) UITableView *userTableView;
/** 头像图片 */
@property (nonatomic, strong) UIImageView *iconImgView;
/** 标题数组 */
@property (nonatomic, strong)  NSArray *titles;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titles = @[@"公开文章", @"私密文章", @"收藏的文章", @"喜欢的文章", @"我的文章", @"公开文章", @"私密文章", @"收藏的文章", @"喜欢的文章", @"我的文章", @"公开文章", @"私密文章", @"收藏的文章", @"喜欢的文章", @"我的文章"];
    // 自定义 titleView
    [self setupNavTitleView];
    
    // 创建 tableView
    [self setupTableView];
    
}

/** 创建 tableView */
-(void)setupTableView{
    
    self.userTableView = [[UITableView alloc] initWithFrame:(CGRectMake(0, 64, LCBScreenWidth, LCScreenHeight-64))
                                                      style:(UITableViewStylePlain)];
    self.userTableView.delegate = self;
    self.userTableView.dataSource = self;
    self.userTableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.userTableView];
}

/** 自定义导航栏的 titleView */
-(void)setupNavTitleView{
    
    // 自定义导航 titleView
    UIView *titleView = [[UIView alloc] init];
    titleView.frame = CGRectMake(0, 0, IconImgViewWidth, IconImgViewWidth/2);
    
    // 头像图片
    self.iconImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user_icon"]];
    self.iconImgView.frame = CGRectMake(0, 0, IconImgViewWidth, IconImgViewWidth);
    self.iconImgView.backgroundColor = [UIColor whiteColor];
    self.iconImgView.layer.cornerRadius = IconImgViewWidth/2;
    self.iconImgView.layer.masksToBounds = YES;
    [titleView addSubview:self.iconImgView];
    
    // 设置
    self.navigationItem.titleView = titleView;

}

#pragma mark - <UITableViewDataSource>
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }else{
        return self.titles.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) { // 个人信息
        UserInfoCell *userInfoCell = [tableView dequeueReusableCellWithIdentifier:@"userInfoCell"];
        if (userInfoCell == nil) {
            userInfoCell = [UserInfoCell craeteCell];
        }
        return userInfoCell;
        
    }else{ // 列表
        ListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listCell"];
        if (cell == nil) {
            cell = [ListCell craeteCell];
        }
        cell.titlel.text = self.titles[indexPath.row];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 220;
    }else{
        return 50;
    }
}

#pragma mark - <UIScrollViewDelegate>
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    // 当前视图y值偏移量 + tableView 的顶部的内边距
    CGFloat contentSet = scrollView.contentOffset.y + self.userTableView.contentInset.top;
    
    
    if (contentSet >= 0 && contentSet <= IconImgViewWidth/2) { // 头像的下半部分还没有偏移到导航栏时
        
        // 偏移量 0 - IconImgViewWidth/2 图片逐渐缩小
        // 偏移量 IconImgViewWidth/2 - 0 图片逐渐放大
        self.iconImgView.transform = CGAffineTransformMakeScale(1-contentSet/IconImgViewWidth, 1-contentSet/IconImgViewWidth);
        self.iconImgView.y = 0;
        
    }else if (contentSet > IconImgViewWidth/2){ // 向上滚动 超过固定高度后， 图片变为原来的一半大小
        
        self.iconImgView.transform = CGAffineTransformMakeScale(0.5, 0.5);
        self.iconImgView.y = 0;
        
    }else if (contentSet < 0){  // 在正常界面向下拉时，界面不变
        self.iconImgView.transform = CGAffineTransformMakeScale(1, 1);
        self.iconImgView.y = 0;
    }
    
    /**
     *      CGAffineTransformMakeScale
     
     *  缩放效果  两个参数： 代表宽，高的缩放比例
     */
}
@end
