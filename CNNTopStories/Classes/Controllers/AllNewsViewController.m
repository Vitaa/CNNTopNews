//
//  AllNewsViewController.m
//  CNNTopStories
//
//  Created by Vita on 10/23/12.
//  Copyright (c) 2012 Vita. All rights reserved.
//

#import "AllNewsViewController.h"
#import "NewsViewController.h"
#import "LoadingView.h"
#import "XMLParser.h"
#import "News.h"

static NSString *kNewsUrl = @"http://rss.cnn.com/rss/cnn_topstories.rss";

@interface AllNewsViewController ()
@property (strong, nonatomic) NSArray *news;
@end

@implementation AllNewsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        parser = [[XMLParser alloc] init];
        parser.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    allNewsView = [[AllNewsView alloc] initWithFrame:self.view.bounds];
    allNewsView.delegate = self;
    allNewsView.newsTableView.dataSource = self;
    allNewsView.newsTableView.delegate = self;
    [self.view addSubview:allNewsView];
    
    loadingView = [[LoadingView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:loadingView];
    
    [NSThread detachNewThreadSelector:@selector(loadNews) toTarget:self withObject:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

- (void)loadNews {
    @autoreleasepool {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        [parser parseNews:[NSURL URLWithString:kNewsUrl]];
    }
}

#pragma mark -
#pragma XMLParserDelegate
- (void)parserDidEndWithTitle:(NSString*)title news:(NSArray*)news {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    [loadingView removeFromSuperview];
    loadingView = nil;
    
    self.news = news;
    [allNewsView setTitle:title];
    [allNewsView reload];
}

- (void)parserDidFailWithError:(NSError*)error {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    NSLog(@"%@", error);
    
    [[[UIAlertView alloc] initWithTitle:@"Couldn't load news!" message:@"Please check your internet connection" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
}

#pragma mark -
#pragma UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.news count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"NewsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    News *news = [self.news objectAtIndex:indexPath.row];
    cell.textLabel.text = [news.title stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    cell.detailTextLabel.text = news.publishDate;
    
    return cell;
}

#pragma mark -
#pragma UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    News *news = [self.news objectAtIndex:indexPath.row];
    NewsViewController *newsViewController = [[NewsViewController alloc] initWithNews:news];
    [self.navigationController pushViewController:newsViewController animated:YES];
}

#pragma mark -
#pragma AllNewsViewDelegate
- (void)reloadPressed {
    [NSThread detachNewThreadSelector:@selector(loadNews) toTarget:self withObject:nil];
}

@end
