//
//  News.m
//  CNNTopStories
//
//  Created by Vita on 10/23/12.
//  Copyright (c) 2012 Vita. All rights reserved.
//

#import "News.h"

@implementation News

- (void)setPublishDate:(NSString *)publishDate_ {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"EST"]];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"us"]];
    [formatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss zzz"];
    NSDate *sourceDate = [formatter dateFromString:publishDate_];
   
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    [formatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss"];
    _publishDate = [formatter stringFromDate:sourceDate];
}

@end
