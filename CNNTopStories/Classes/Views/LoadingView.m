//
//  LoadingView.m
//  CNNTopStories
//
//  Created by Vita on 10/23/12.
//  Copyright (c) 2012 Vita. All rights reserved.
//

#import "LoadingView.h"

@implementation LoadingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [activityIndicator startAnimating];
        [self addSubview:activityIndicator];
        
        loadingLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        loadingLbl.text = @"Loading...";
        loadingLbl.font = [UIFont systemFontOfSize:24];
        loadingLbl.backgroundColor = [UIColor clearColor];
        loadingLbl.textColor = [UIColor whiteColor];
        [loadingLbl sizeToFit];
        [self addSubview:loadingLbl];
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"loadingBackground.jpg"]];
    }
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width;
    
    activityIndicator.center = CGPointMake(width * 0.5, height - 40);
    loadingLbl.center = CGPointMake(width * 0.5, activityIndicator.frame.origin.y - loadingLbl.frame.size.height);
}

@end
