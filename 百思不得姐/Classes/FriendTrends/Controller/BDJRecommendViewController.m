//
//  BDJRecommendViewController.m
//  百思不得姐
//
//  Created by 😄 on 16/8/22.
//  Copyright © 2016年 😄. All rights reserved.
//

#import "BDJRecommendViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "BDJRecommendTypeCell.h"
#import <MJExtension.h>
#import "BDJRecommendType.h"
#import "BDJRecommendUserCell.h"
#import "BDJRecommendUser.h"

@interface BDJRecommendViewController () <UITableViewDelegate, UITableViewDataSource>

//左边的数据类型
@property (nonatomic, strong) NSArray *type;

//右边的数据类型
@property (nonatomic, strong) NSArray *users;

//左边表格
@property (weak, nonatomic) IBOutlet UITableView *typeTableView;
//右边表格
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

@end

@implementation BDJRecommendViewController

static NSString * const BDJTypeId = @"type";

static NSString * const BDJTypeUser = @"user";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTableView];
    
    //设置指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    //发送网络请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
       
        [SVProgressHUD dismiss];
        
        
        self.type = [BDJRecommendType objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.typeTableView reloadData];
        
        //默认选中首行
        [self.typeTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败"];
    }];
    
}

- (void)setUpTableView
{
    //注册cell
    [self.typeTableView registerNib:[UINib nibWithNibName:NSStringFromClass([BDJRecommendTypeCell class]) bundle:nil] forCellReuseIdentifier:BDJTypeId];
    
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([BDJRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:BDJTypeUser];
    
    //设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.typeTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.typeTableView.contentInset;
    self.userTableView.rowHeight = 70;
    
    //设置标题
    self.navigationItem.title = @"推荐关注";
    
    //设置背景色
    self.view.backgroundColor = BDJGlobalBg;

}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.typeTableView) {
        return self.type.count;
    }else{
        
        BDJRecommendType *c = self.type[self.typeTableView.indexPathForSelectedRow.row];
        
        
        return c.users.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.typeTableView) { //左边表格
        BDJRecommendTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:BDJTypeId];
        
        cell.type = self.type[indexPath.row];
        
        return  cell;
    }else{ //右边表格
        BDJRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:BDJTypeUser];
        
        BDJRecommendType *c = self.type[self.typeTableView.indexPathForSelectedRow.row];
        
        cell.user = c.users[indexPath.row];
        
        return  cell;
    }
    
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BDJRecommendType *c  = self.type[indexPath.row];
    
    if (c.users.count) {  //显示曾经获取到的数据
        
        [self.userTableView reloadData];
        
    }else{
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"list";
        params[@"c"] = @"subscribe";
        params[@"category_id"] = @(c.id);
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            
            NSArray *users = [BDJRecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
            
            [c.users addObjectsFromArray:users];
            
            //刷新右边表格
            [self.userTableView reloadData];
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            
        }];
        

        
    }
    
    }

@end
