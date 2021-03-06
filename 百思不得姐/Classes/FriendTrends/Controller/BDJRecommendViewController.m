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
#import <MJRefresh.h>

#define BDJSelectedType self.type[self.typeTableView.indexPathForSelectedRow.row]

@interface BDJRecommendViewController () <UITableViewDelegate, UITableViewDataSource>

//左边的数据类型
@property (nonatomic, strong) NSArray *type;

//右边的数据类型
@property (nonatomic, strong) NSArray *users;

//左边表格
@property (weak, nonatomic) IBOutlet UITableView *typeTableView;
//右边表格
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

@property (nonatomic, strong) NSMutableDictionary *params;

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation BDJRecommendViewController

static NSString * const BDJTypeId = @"type";

static NSString * const BDJTypeUser = @"user";

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTableView];
    
    //设置刷新控件
    [self setUpRefresh];
    
    //加载左侧类型数据
    [self loadTypes];
    
}

/**
 *加载左侧类型数据
 */
- (void)loadTypes
{
    //设置指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    //发送网络请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        
        
        self.type = [BDJRecommendType objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.typeTableView reloadData];
        
        //默认选中首行
        [self.typeTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
        //让表格进入刷新状态
        [self.userTableView.mj_header beginRefreshing];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败"];
    }];

}

/**
 *添加刷新控件
 */
- (void)setUpRefresh
{
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    
    self.userTableView.mj_footer.hidden = YES;
}

/**
 *加载用户数据
 */

- (void)loadNewUsers
{
    BDJRecommendType *currentType = BDJSelectedType;
    
    //设置当前页码为1
    currentType.currentPage = 1;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(currentType.id);
    params[@"page"] = @(currentType.currentPage);
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        //字典数组 －> 模型数组
        NSArray *users = [BDJRecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //清除所有旧数据
        [currentType.users removeAllObjects];
        
        //添加当前类别到对应的数组中
        [currentType.users addObjectsFromArray:users];
        
        //保存总数
        currentType.total = [responseObject[@"total"] integerValue];
        
        //现保存返回的数据，再判断最新的params != params 直接返回，说明有新的请求存在
        if (self.params != params) return;
        
        //刷新右边表格
        [self.userTableView reloadData];
        
        //结束刷新
        [self.userTableView.mj_header endRefreshing];
        
        //让底部空间结束刷新
        [self checkFooterState];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        //最新的params != params 直接返回，说明有新的请求存在
        if (self.params != params) return;
        
        //提醒失败
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
        //结束刷新
        [self.userTableView.mj_header endRefreshing];
        
    }];


}

- (void)loadMoreUsers
{
    BDJRecommendType *type = BDJSelectedType;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @([BDJSelectedType id]);
    params[@"page"] = @(++type.currentPage);
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        //字典数组 -> 模型数组
        NSArray *users = [BDJRecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        
        [type.users addObjectsFromArray:users];
        
        //现保存返回的数据，再判断最新的params != params 直接返回，说明有新的请求存在
        if (self.params != params) return;
        
        //刷新右边表格
        [self.userTableView reloadData];
        
        //让底部空间结束刷新
        [self checkFooterState];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        //最新的params != params 直接返回，说明有新的请求存在
        if (self.params != params) return;
        NSLog(@"Error: %@", error);
        
        //提醒失败
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
        //结束刷新
        [self.userTableView.mj_header endRefreshing];
        
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

/**
 *检测footer状态
 */
- (void)checkFooterState
{
    BDJRecommendType *currentType = BDJSelectedType;
    
    //每次刷新右边表格数据的时候，设置footer是显示／隐藏
    self.userTableView.mj_footer.hidden = (currentType.users.count == 0);
    
    //让底部空间结束刷新
    if (currentType.users.count == currentType.total) { //全部加载完毕
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    }else{
        [self.userTableView.mj_footer endRefreshing];
    }
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.typeTableView) { //左面表格
        return self.type.count;
    }else{  //右面表格

        //监听footer状态
        [self checkFooterState];
        
        return [BDJSelectedType users].count;
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
        
        
        
        cell.user = [BDJSelectedType users][indexPath.row];
        
        return  cell;
    }
    
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.userTableView.mj_header endRefreshing];
    [self.userTableView.mj_footer endRefreshing];
    
    BDJRecommendType *c  = self.type[indexPath.row];
    
    if (c.users.count) {  //显示曾经获取到的数据
        
        [self.userTableView reloadData];
        
    }else{
        
        //刷新表格，马上显示当前内容，防止用户看到上一次的数据
        [self.userTableView reloadData];
        
        //进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
        
        
    }
}

- (void)dealloc
{
    //退出控制器之后，结束所有请求
    [self.manager.operationQueue cancelAllOperations];
    
    [SVProgressHUD dismiss];
}

@end
