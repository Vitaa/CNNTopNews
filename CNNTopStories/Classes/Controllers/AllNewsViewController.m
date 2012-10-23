//
//  AllNewsViewController.m
//  CNNTopStories
//
//  Created by Vita on 10/23/12.
//  Copyright (c) 2012 Vita. All rights reserved.
//

#import "AllNewsViewController.h"
#import "LoadingView.h"
#import "XMLParser.h"

@interface AllNewsViewController ()

@end

@implementation AllNewsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        loadingView = [[LoadingView alloc] initWithFrame:CGRectZero];
        parser = [[XMLParser alloc] init];
        parser.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
	
    loadingView.frame = self.view.bounds;
    [self.view addSubview:loadingView];
    
    [NSThread detachNewThreadSelector:@selector(loadNews) toTarget:self withObject:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadNews {
    @autoreleasepool {
        [parser parseNews:[NSURL URLWithString:@"http://rss.cnn.com/rss/cnn_topstories.rss"]];
    }
}

#pragma mark -
#pragma XMLParserDelegate
- (void)parserDidEndWithTitle:(NSString*)title news:(NSArray*)news {
    [loadingView removeFromSuperview];
    loadingView = nil;
}

- (void)parserDidFailWithError:(NSError*)error {
    NSLog(@"%@", error);
    
    [[[UIAlertView alloc] initWithTitle:@"Error!" message:@"Couldn't load news.." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
}

@end
