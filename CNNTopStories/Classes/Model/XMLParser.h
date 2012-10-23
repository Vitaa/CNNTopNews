//
//  XMLParser.h
//  CNNTopStories
//
//  Created by Vita on 10/23/12.
//  Copyright (c) 2012 Vita. All rights reserved.
//


@protocol XMLParserDelegate <NSObject>
@optional
- (void)parserDidEndWithTitle:(NSString*)title news:(NSArray*)news;
- (void)parserDidFailWithError:(NSError*)error;

@end

@interface XMLParser : NSObject <NSXMLParserDelegate>
{
}

@property (weak, nonatomic) id<XMLParserDelegate>delegate;

- (void)parseNews:(NSURL*)url;

@end
