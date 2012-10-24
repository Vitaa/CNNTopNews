//
//  AllNewsView.m
//  CNNTopStories
//
//  Created by Vita on 10/23/12.
//  Copyright (c) 2012 Vita. All rights reserved.
//

#import "AllNewsView.h"

@implementation AllNewsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizesSubviews = YES;
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        _newsTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _newsTableView.autoresizesSubviews = YES;
        _newsTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        headerLbl = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.width, 60.0)];
        headerLbl.font = [UIFont systemFontOfSize:40];
        headerLbl.textAlignment = NSTextAlignmentCenter;
        _newsTableView.tableHeaderView = headerLbl;
        
        UIButton *reloadButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [reloadButton setTitle:@"Reload" forState:UIControlStateNormal];
        reloadButton.frame = CGRectMake(0.0, 0.0, 200.0, 40.0);
        [reloadButton addTarget:self action:@selector(reloadPressed) forControlEvents:UIControlEventTouchUpInside];
        _newsTableView.tableFooterView = reloadButton;
        
        [self addSubview:_newsTableView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.newsTableView.frame = self.bounds;
 //   headerLbl.frame = CGRectMake(0.0, 0.0, self.frame.size.width, 60.0);
}

- (void)reload {
    [self.newsTableView reloadData];
}

- (void)setTitle:(NSString*)title {
    headerLbl.text = title;
}

- (void)reloadPressed {
    if ([self.delegate respondsToSelector:@selector(reloadPressed)]) {
        [self.delegate reloadPressed];
    }
}



@end
