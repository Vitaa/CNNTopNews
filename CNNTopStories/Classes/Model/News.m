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
    // create date from string
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"EEE, d MMM yyyy HH:mm:ss zzz"];
    NSDate *date = [df dateFromString: publishDate_];
   
    // get string from date
    NSDateFormatter* df_local = [[NSDateFormatter alloc] init];
    [df_local setTimeZone:[NSTimeZone timeZoneWithName:@"EST"]];
    [df_local setDateFormat:@"EEE, d MMM yyyy HH:mm:ss"];
    
    _publishDate = [df_local stringFromDate:date];;    
}

@end
