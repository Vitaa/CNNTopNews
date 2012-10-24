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
#import "News.h"

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
    
    self.navigationController.navigationBarHidden = YES;
    
    allNewsView = [[AllNewsView alloc] initWithFrame:self.view.bounds];
    allNewsView.delegate = self;
    allNewsView.newsTableView.dataSource = self;
    allNewsView.newsTableView.delegate = self;
    [self.view addSubview:allNewsView];
    
    loadingView = [[LoadingView alloc] initWithFrame:self.view.bounds];
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
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        [parser parseNews:[NSURL URLWithString:@"http://rss.cnn.com/rss/cnn_topstories.rss"]];
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
    
    [[[UIAlertView alloc] initWithTitle:@"Error!" message:@"Couldn't load news.." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
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
    cell.textLabel.text = news.title;
    cell.detailTextLabel.text = news.publishDate;
    
    return cell;
}


#pragma mark -
#pragma UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

#pragma mark -
#pragma AllNewsViewDelegate

- (void)reloadPressed {
    [NSThread detachNewThreadSelector:@selector(loadNews) toTarget:self withObject:nil];
}

@end
