//
//  TableHeaderView.m
//  HeaderDemo
//
//  Created by 展祥叶 on 2017/2/10.
//  Copyright © 2017年 ye zhanxiang. All rights reserved.
//

#import "TableHeaderView.h"

@implementation TableHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.titleLbl];
        [self addSubview:self.attentionLbl];
        [self addSubview:self.attentBtn];
    }
    return self;
}

- (UILabel *)titleLbl
{
    if (!_titleLbl) {
        _titleLbl = [UILabel new];
        _titleLbl.frame = CGRectMake(20, 10, self.frame.size.width-20, 40);
        _titleLbl.text = @"我是律师XXX，关于公司业务，房产纠纷，交通事故相关问题，可以为你服务，免费咨询法律纠纷问题！！！";
        _titleLbl.numberOfLines = 0;
        _titleLbl.textColor = [UIColor whiteColor];
        _titleLbl.font = [UIFont boldSystemFontOfSize:16];
        
    }
    return _titleLbl;
}

- (UILabel *)attentionLbl
{
    if (!_attentionLbl) {
        _attentionLbl = [UILabel new];
        _attentionLbl.frame  = CGRectMake(20, CGRectGetMaxY(_titleLbl.frame)+5, self.frame.size.width-20, 20);
        _attentionLbl.text = @"----- 1.2万 关注 -----";
        _attentionLbl.textAlignment = NSTextAlignmentCenter;
        _attentionLbl.textColor = [UIColor whiteColor];
        _attentionLbl.font = [UIFont systemFontOfSize:12];
    }

    return _attentionLbl;
}

- (UIButton *)attentBtn
{
    if (!_attentBtn) {
        _attentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _attentBtn.frame = CGRectMake(CGRectGetWidth(self.frame)/2-25,  CGRectGetMaxY(_attentionLbl.frame)+10, 80, 30);
        _attentBtn.layer.cornerRadius = 15;
        _attentBtn.layer.masksToBounds = YES;
        _attentBtn.backgroundColor = [UIColor redColor];
        [_attentBtn setTitle:@"+ 关注" forState:UIControlStateNormal];
        [_attentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _attentBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        
    }
    return _attentBtn;
}

@end
