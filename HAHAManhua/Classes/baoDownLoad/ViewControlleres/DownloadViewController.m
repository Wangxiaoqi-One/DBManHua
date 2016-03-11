//
//  DownloadViewController.m
//  HAHAManhua
//
//  Created by scjy on 16/3/8.
//  Copyright © 2016年 WangXiaoQi. All rights reserved.
//

#import "DownloadViewController.h"
#import <AFNetworking.h>
#import "DownloadCollectionViewCell.h"
#import "DownloadModel.h"
#import "ManHuaViewController.h"


static NSString *itemIdentifier = @"item";

static NSString *currentYear;
static NSString *currentMonth;

@interface DownloadViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

{
    NSString *_year;
    NSString *_month;
}

- (IBAction)previousBtnAction:(UIButton *)sender;

- (IBAction)nextBtnAction:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UIButton *timeBtn;


@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *listArray;



@end

@implementation DownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"暴下载";
    [self showBackBtn];
//    [self showRightBtn];
    [self getTImestamp];
    [self.view addSubview:self.collectionView];
    [self requestModel3];
}

#pragma mark ------CustomMethod

- (void)backBtnAction:(UIButton *)Btn{
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
}

- (void)getTImestamp{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM";
    NSString *datestr = [formatter stringFromDate:date];
    _year = [datestr substringToIndex:4];
    currentYear = _year;
    _month = [datestr substringFromIndex:5];
    currentMonth = _month;
}

- (void)requestModel3{
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
    [sessionManager GET:[NSString stringWithFormat:kDownLoad, _year, _month] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *array = responseObject;
        _year = array[0][@"year"];
        _month = array[0][@"month"];
        [self.timeBtn setTitle:[NSString stringWithFormat:@"%@年%@月", _year, _month] forState:UIControlStateNormal];
        if (self.listArray.count > 0) {
            [self.listArray removeAllObjects];
        }
        for (NSDictionary *dic in array) {
            DownloadModel *model = [[DownloadModel alloc] initWithDictionary:dic];
            [self.listArray addObject:model];
        }
        [self.collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        WXQLog(@"%@", error);
    }];

}

- (void)showRightBtn{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 60, 44);
    [rightBtn setImage:[UIImage imageNamed:@"my_down_load_img_normal"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
}

- (void)rightBtnAction{

}

#pragma mark ---------Lazyloading

- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 22, 5, 22);
        flowLayout.itemSize = CGSizeMake((kScreenWidth - 75) / 2, kScreenHeight / 4);
        flowLayout.minimumInteritemSpacing = 1;
        flowLayout.minimumLineSpacing = 1;
        //设置布局方向(默认垂直方向)
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 178, kScreenWidth, kScreenHeight - 242) collectionViewLayout:flowLayout];
        self.collectionView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.05];
        //设置代理
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        //注册item类型
        [self.collectionView registerNib:[UINib nibWithNibName:@"DownloadCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:itemIdentifier];
    }
    return _collectionView;
}

- (NSMutableArray *)listArray{
    if (_listArray == nil) {
        self.listArray = [NSMutableArray new];
    }
    return _listArray;
}

#pragma mark ----------UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.listArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DownloadCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:itemIdentifier forIndexPath:indexPath];
 
    cell.model = self.listArray[indexPath.row];
    return cell;
}

#pragma mark ----------UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//    NSLog(@"%@", filePath);
//    DownloadModel *model = self.listArray[indexPath.row];
//    NSString *fileName = [filePath stringByAppendingPathComponent:model.zip_name];
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    if ([fileManager fileExistsAtPath:fileName]) {
//        ManHuaViewController *manhuaVC = [[ManHuaViewController alloc] init];
//        manhuaVC.filePath = fileName;
//        [self.navigationController pushViewController:manhuaVC animated:YES];
//    }else{
//        return;
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)previousBtnAction:(UIButton *)sender {
    if ([_month integerValue] == 1) {
        NSInteger year = [_year integerValue] - 1;
        _month = @"12";
        _year = [NSString stringWithFormat:@"%ld", year];
        [self requestModel3];
    }else{
        NSInteger month = [_month integerValue] - 1;
        _month = [NSString stringWithFormat:@"%ld", month];
        [self requestModel3];
    }
}

- (IBAction)nextBtnAction:(UIButton *)sender {
    if ([_year isEqualToString:currentYear]) {
        if ([_month isEqualToString:currentMonth]) {
            return;
        }else{
            NSInteger month = [_month integerValue] + 1;
            _month = [NSString stringWithFormat:@"%ld", month];
            [self requestModel3];
        }
    }else{
        if ([_month isEqualToString:@"12"]) {
            NSInteger year = [_year integerValue] + 1;
            _month = @"1";
            _year = [NSString stringWithFormat:@"%ld", year];
            [self requestModel3];
        }else{
            NSInteger month = [_month integerValue] + 1;
            _month = [NSString stringWithFormat:@"%ld", month];
            [self requestModel3];
        }
    }
    
}
@end
