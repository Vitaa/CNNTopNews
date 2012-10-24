//
//  AllNewsView.h
//  CNNTopStories
//
//  Created by Vita on 10/23/12.
//  Copyright (c) 2012 Vita. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AllNewsViewDelegate <NSObject>

- (void)reloadPressed;

@end

@interface AllNewsView : UIView
{
    UILabel *headerLbl;
}

- (void)reload;
- (void)setTitle:(NSString*)title;

@property (weak, nonatomic) id<AllNewsViewDelegate> delegate;
@property (strong, nonatomic) UITableView *newsTableView;


@end
