//
//  XMLParser.m
//  CNNTopStories
//
//  Created by Vita on 10/23/12.
//  Copyright (c) 2012 Vita. All rights reserved.
//

#import "XMLParser.h"
#import "News.h"

@interface XMLParser()
@property (strong, nonatomic) NSMutableArray * news;
@property (strong, nonatomic) NSString * newsTitle;

@property (strong, nonatomic) NSMutableString *currentElementValue;
@property (strong, nonatomic) News * currentNews;

@end

@implementation XMLParser

- (id)initWithUrl:(NSURL*)url {

    if (self=[super init]){
        
    }
    return self;
}

- (void)parseNews:url {
    NSXMLParser * parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    parser.delegate = self;
    BOOL result = [parser parse];
    
    if (result) {
        if ([self.delegate respondsToSelector:@selector(parserDidEndWithTitle:news:)]) {
            [self.delegate parserDidEndWithTitle:self.newsTitle news:self.news];
        }
    }
    else {
        if ([self.delegate respondsToSelector:@selector(parserDidFailWithError:)]) {
            [self.delegate parserDidFailWithError:[parser parserError]];
        }
    }
}

#pragma mark -
#pragma NSXMLParser delegate

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    self.news = [[NSMutableArray alloc] init];
    self.newsTitle = @"";
    self.currentNews = nil;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
    
    if ([elementName isEqualToString:@"item"]) {
        self.currentNews = [News new];
    }

}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:@"item"]) {
        [self.news addObject:self.currentNews];
        self.currentNews = nil;
    }
    else if ([elementName isEqualToString:@"title"]) {
        if (self.currentNews) {
            self.currentNews.title = self.currentElementValue;
        }
        else {
            self.newsTitle = self.currentElementValue;
        }
    }
    else if (self.currentNews) {
        if ([elementName isEqualToString:@"pubDate"]) {
            self.currentNews.publishDate = self.currentElementValue;
        }
        else if ([elementName isEqualToString:@"link"]) {
            self.currentNews.link = self.currentElementValue;
        }
    }
    
    self.currentElementValue = nil;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (!self.currentElementValue){
        self.currentElementValue = [NSMutableString stringWithString:string];
    }
    else {
        [self.currentElementValue appendString:string];
    }
}

@end
