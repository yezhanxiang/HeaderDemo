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
    [self addTableView];
    [self addBgView];
    
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
    _headerView = [[TableHeaderView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 200-64                       )];
    _headerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_headerView];
    
}

- (void)addTableView
{
    CGFloat width = self.view.frame.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, height) style:UITableViewStylePlain];
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
     CGFloat minAlphaOffset = 64;
    CGFloat offsetY = scrollView.contentOffset.y;
    if (_lastOffsetY < offsetY) {
        if (fabs(offsetY) < minAlphaOffset) {
            CGFloat alpha = _headerView.alpha - (offsetY - _lastOffsetY) / minAlphaOffset;
            _headerView.alpha = alpha;
            CGRect rect = _headerView.frame;
            CGRect newRect = rect;
            newRect.origin.y = rect.origin.y - (offsetY - _lastOffsetY);
            _headerView.frame = newRect;
            CGRect r = _bgView.frame;
            CGRect nr = r;
            nr.size.height = r.size.height - (offsetY - _lastOffsetY);
            _bgView.frame = nr;
            
        }
        NSLog(@"上：%f, last:%f", offsetY, _lastOffsetY);
    }else {
        
        if (_lastOffsetY >= -minAlphaOffset && _lastOffsetY < 0) {
            
            CGFloat alpha =  fabs(offsetY) / minAlphaOffset;
            _headerView.alpha = alpha;
            CGRect rect = _headerView.frame;
            CGRect newRect = rect;
            newRect.origin.y = fabs(offsetY);
            _headerView.frame = newRect;
        }
        
//        CGRect r = _bgView.frame;
//        CGRect nr = r;
//        nr.size.height = r.size.height + fabs((offsetY - _lastOffsetY));
//        _bgView.frame = nr;
        
        NSLog(@"下：%f, last:%f", offsetY, _lastOffsetY);
    }
    
    _lastOffsetY = scrollView.contentOffset.y;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
