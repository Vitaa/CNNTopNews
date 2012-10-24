//
//  NewsViewController.m
//  CNNTopStories
//
//  Created by Vita on 10/24/12.
//  Copyright (c) 2012 Vita. All rights reserved.
//

#import "NewsViewController.h"
#import "News.h"
@interface NewsViewController ()
@property (strong, nonatomic) News* news;
@end

@implementation NewsViewController

- (id)initWithNews:(News*)news
{
    self = [super init];
    if (self) {
        _news = news;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.title = self.news.title;
	
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.autoresizesSubviews = YES;
    webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.news.link]]];
    
    [self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

@end
