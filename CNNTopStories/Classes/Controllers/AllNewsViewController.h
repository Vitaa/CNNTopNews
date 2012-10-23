//
//  AllNewsViewController.h
//  CNNTopStories
//
//  Created by Vita on 10/23/12.
//  Copyright (c) 2012 Vita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLParser.h"

@class LoadingView;


@interface AllNewsViewController : UIViewController <XMLParserDelegate>
{
    XMLParser *parser;
    LoadingView *loadingView;
    
}

@end
