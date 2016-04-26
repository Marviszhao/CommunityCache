//
//  MAWriteFileViewController.m
//  CommunityCache-Demo
//
//  Created by imac on 16/4/5.
//  Copyright © 2016年 kingdee. All rights reserved.
//

#import "MAWriteFileViewController.h"
#import "MAScrollView.h"
#import "MAPostTableViewCell.h"
#import "MARefershTableView.h"
#import "MAPostFileManager.h"
#import "MAParseHelper.h"

#define CELL_IDENTIFIER @"MAPostTableViewCell"

@interface MAWriteFileViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
MAScrollViewDelegate,
MAScrollViewRefreshDelegate
>

@property (nonatomic, strong) MARefershTableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) NSUInteger pageNum;

@property (nonatomic, strong) MAScrollView *cusScrollView;
@end

@implementation MAWriteFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.extendedLayoutIncludesOpaqueBars = NO;
//    self.modalPresentationCapturesStatusBarAppearance = NO;
    //    正方形等宽高
    CGRect bounds = [UIScreen mainScreen].bounds;
    CGRect frame = CGRectMake(0, 0, bounds.size.width, 130);
    self.cusScrollView = [[MAScrollView alloc] initWithFrame:frame];
    self.cusScrollView.MADelegate = self;
    
    frame = CGRectMake(0, 64, bounds.size.width , bounds.size.height - 64);
    self.tableView = [[MARefershTableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[MAPostTableViewCell nib] forCellReuseIdentifier:CELL_IDENTIFIER];
    self.tableView.rowHeight = 76;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = self.cusScrollView;
    UIView *bcgView = [[UIView alloc] init];
    bcgView.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundView = bcgView;
    
    self.tableView.refreshDelegate = self;
    [self.tableView addRefreshControlWithText:@"下拉刷新"];
    [self.tableView addLoadMoreFootWithText:@"加载更多"];
    
    [self.view addSubview:self.tableView];
    
    [self requestBannerData];
    [self requestPostListData];
    
}

- (void)dealloc{
    [self.cusScrollView stopTimer:YES];
    NSLog(@"MAWriteFileViewController dealloc!");
}

- (void)requestBannerData{
    //!!!没有网络时候的处理
    NSString *urlStr = [NSString stringWithFormat:@"http://localhost:8080/AppServer/index.jsp"];
    NSURL *url = [NSURL URLWithString:urlStr];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (connectionError) {
            NSLog(@"connectionError--->>%@",connectionError);
        } else{
            [MAPostFileManager saveBannerDataWithJsonData:data];
            NSError *error = nil;
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            if (error) {
                NSLog(@"json parse failed \r\n");
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView endRefreshWithState:kRefreshStateFinished];
                    NSArray *bannerUrlArr = [MAParseHelper parserBannerDicToArray:json];
                    self.cusScrollView.imgUrlsArray = bannerUrlArr;
                    [self.tableView reloadData];
                });
            }
        }
    }];

}

- (void)requestPostListData{
    //!!!没有网络时候的处理
    self.pageNum = 0;

    NSString *urlStr = [NSString stringWithFormat:@"http://localhost:8080/AppServer/appServer.jsp"];
    NSURL *url = [NSURL URLWithString:urlStr];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (connectionError) {
            NSLog(@"connectionError--->>%@",connectionError);
        } else{
            [MAPostFileManager saveDataWithJsonData:data];
            NSError *error = nil;
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            if (error) {
                NSLog(@"json parse failed \r\n");
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView endRefreshWithState:kRefreshStateFinished];
                    NSArray *postModelArr = [MAParseHelper parserPostListDicToArray:json];
                    self.dataArray = [postModelArr mutableCopy];
                    [self.tableView reloadData];
                });
            }
        }
    }];
}

- (void)requestMorePostListData{
    //!!!没有网络时候的处理
    self.pageNum ++;
    
    NSString *urlStr = [NSString stringWithFormat:@"http://localhost:8080/AppServer/appServer.jsp"];
    NSURL *url = [NSURL URLWithString:urlStr];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (connectionError) {
            NSLog(@"connectionError--->>%@",connectionError);
        } else{
            [MAPostFileManager saveDataWithJsonData:data];
            NSError *error = nil;
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            if (error) {
                NSLog(@"json parse failed \r\n");
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSArray *postModelArr = [MAParseHelper parserPostListDicToArray:json];
                    [self.dataArray addObjectsFromArray:postModelArr];
                    [self.tableView endLoadMoreWithState:kLoadStateDefault];
                    [self.tableView reloadData];
                });
            }
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - UIScrollViewDelegate
#pragma mark
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == _tableView) {
        [_tableView tableViewDidReachFootView];
    }
}

#pragma mark - MAScrollViewRefreshDelegate
// Top refresh
-(void)startRefreshData:(UIScrollView *)scrollView{
    [self requestPostListData];
}

// Bottom loadMore
-(void)startLoadMoreData:(UIScrollView *)scrollView{
    [self requestMorePostListData];
}

#pragma mark - MAScrollViewDelegate
#pragma mark
- (void)MAScrollView:(MAScrollView *)scrollView userTapADIndes:(NSUInteger)index{
    NSLog(@"userTapADIndes---%lu",(unsigned long)index);
}
- (void)MAScrollView:(MAScrollView *)scrollView didScrollToADIndes:(NSUInteger)index{
    NSLog(@"didScrollToADIndes---%lu",(unsigned long)index);
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
#pragma mark

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MAPostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER   forIndexPath:indexPath];
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    MAPostModel *postModel = self.dataArray[indexPath.row];
    [cell resetCellContentWithModel:postModel];
    return cell;
}



@end
