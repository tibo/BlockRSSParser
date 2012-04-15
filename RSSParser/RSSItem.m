//
//  RSSItem.m
//  RSSParser
//
//  Created by Thibaut LE LEVIER on 2/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RSSItem.h"

@implementation RSSItem

@synthesize title,itemDescripition,content,link,commentsLink,commentsFeed,commentsCount,pubDate,author,guid;

- (void)dealloc {
    [title release];title = nil;
    [itemDescripition release];itemDescripition = nil;
    [content release]; content = nil;
    [link release];link = nil;
    [commentsLink release];commentsLink = nil;
    [commentsFeed release];commentsFeed = nil;
    [commentsCount release];commentsCount = nil;
    [pubDate release];pubDate = nil;
    [author release]; author = nil;
    [guid release]; guid = nil;
    [super dealloc];
}

@end
