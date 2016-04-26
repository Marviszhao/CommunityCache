//
//  MAHomeViewController.m
//  CommunityCache-Demo
//
//  Created by imac on 16/4/5.
//  Copyright © 2016年 kingdee. All rights reserved.
//

#import "MAHomeViewController.h"
#import "MADownLoadImgManager.h"
#import "MAWriteFileViewController.h"
#import "MAPostFileManager.h"

@interface MAHomeViewController ()

- (IBAction)clearCache:(id)sender;

- (IBAction)writeToSqliteDataBaseText:(id)sender;
- (IBAction)writeToFileText:(id)sender;

@end

@implementation MAHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)clearCache:(id)sender{
    [[MADownLoadImgManager shareManager] clearImgCatchs];
    [MAPostFileManager celarSaveedFile];
}

- (IBAction)writeToSqliteDataBaseText:(id)sender{
    
}

- (IBAction)writeToFileText:(id)sender{
    MAWriteFileViewController *writeVC = [[MAWriteFileViewController alloc] init];
    [self.navigationController pushViewController:writeVC animated:YES];
}


@end
