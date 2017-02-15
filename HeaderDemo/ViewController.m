//
//  ViewController.m
//  HeaderDemo
//
//  Created by 展祥叶 on 2017/2/10.
//  Copyright © 2017年 ye zhanxiang. All rights reserved.
//

#import "ViewController.h"
#import "TableHeaderView.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) TableHeaderView *headerView;
@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic, assign) CGFloat lastOffsetY;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configNavigationBar];
    [self addBgView];
    [self addTableView];
    
}

- (void)configNavigationBar
{
    self.title = @"标题";
    UINavigationBar *bar = self.navigationController.navigationBar;
    [bar setTitleTextAttributes:@{
                                  NSForegroundColorAttributeName:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1]
                                  }];
    bar.backgroundColor = [UIColor clearColor];
    [bar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [bar setShadowImage:[UIImage new]];
}

- ( void)addBgView
{
    _bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    _bgView.image = [UIImage imageNamed:@"bg.jpg"];
    [self.view addSubview:_bgView];
//    _headerView = [[TableHeaderView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 200-64                       )];
//    _headerView.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:_headerView];
    
}

- (void)addTableView
{
    CGFloat width = self.view.frame.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, width, height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    //_tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 200-64)];
    headerView.backgroundColor = [UIColor clearColor];
    _tableView.tableHeaderView = headerView;
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
    [self.view addSubview:_tableView];
}


#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    titleLbl.font = [UIFont systemFontOfSize:12];
    titleLbl.text = @"相关新闻";
    titleLbl.backgroundColor = [UIColor lightGrayColor];
    return titleLbl;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

static const float bgOffset = 32;

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat headerH = _tableView.tableHeaderView.frame.size.height;
    if (_lastOffsetY < offsetY) {
        CGFloat bgY = _bgView.frame.origin.y;
        if (bgY >= -bgOffset  && offsetY > 0) {
            CGFloat a = bgOffset / headerH;
            CGRect rect = _bgView.frame;
            CGRect newR = rect;
            CGFloat distance = (offsetY * a) > bgOffset ? bgOffset : (offsetY * a) ;
            newR.origin.y = -distance;
            //NSLog(@"Y：%f,   %f", newR.origin.y, y);
            _bgView.frame = newR;
        }
        //NSLog(@"上：%f, last:%f", offsetY, _lastOffsetY);
    }else {
        CGFloat bgY = _bgView.frame.origin.y;
        if (bgY < 0 && offsetY <= headerH) {
            CGFloat a = bgOffset / headerH;
            CGRect rect = _bgView.frame;
            CGRect newR = rect;
            CGFloat distance = -bgOffset + ((headerH-offsetY) * a);
            newR.origin.y = distance > 0 ? 0 :distance ;
            _bgView.frame = newR;
        }
        
        //NSLog(@"下：%f, last:%f", offsetY, _lastOffsetY);
    }
    
    _lastOffsetY = scrollView.contentOffset.y;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
