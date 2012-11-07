//
//  RSSItem.m
//  RSSParser
//
//  Created by Thibaut LE LEVIER on 2/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RSSItem.h"

@interface RSSItem (Private)

-(NSArray *)imagesFromHTMLString:(NSString *)htmlstr;

@end

@implementation RSSItem

@synthesize title,itemDescription,content,link,commentsLink,commentsFeed,commentsCount,pubDate,author,guid, podcastFileUrl, podcastFileType, podcastFileLength, podcastItunesDuration;

- (void)dealloc {
    [title release];title = nil;
    [itemDescription release];itemDescription = nil;
    [content release]; content = nil;
    [link release];link = nil;
    [commentsLink release];commentsLink = nil;
    [commentsFeed release];commentsFeed = nil;
    [commentsCount release];commentsCount = nil;
    [pubDate release];pubDate = nil;
    [author release]; author = nil;
    [guid release]; guid = nil;
	[podcastFileUrl release]; podcastFileUrl = nil;
	[podcastFileType release]; podcastFileType = nil;
	[podcastFileLength release]; podcastFileLength = nil;
	[podcastItunesDuration release]; podcastItunesDuration = nil;
    [super dealloc];
}

-(NSArray *)imagesFromItemDescription
{
    if (self.itemDescription) {
        return [self imagesFromHTMLString:self.itemDescription];
    }
    
    return nil;
}

-(NSArray *)imagesFromContent
{
    if (self.content) {
        return [self imagesFromHTMLString:self.content];
    }
    
    return nil;
}

#pragma mark - retrieve images from html string using regexp (private methode)

-(NSArray *)imagesFromHTMLString:(NSString *)htmlstr
{
    NSMutableArray *imagesURLStringArray = [[NSMutableArray alloc] init];
    
    NSError *error;
    
    NSRegularExpression *regex = [NSRegularExpression         
                                  regularExpressionWithPattern:@"(https?)\\S*(png|jpg|jpeg|gif)"
                                  options:NSRegularExpressionCaseInsensitive
                                  error:&error];
    
    [regex enumerateMatchesInString:htmlstr 
                            options:0 
                              range:NSMakeRange(0, htmlstr.length) 
                         usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                             [imagesURLStringArray addObject:[htmlstr substringWithRange:result.range]];
                         }];    
    
    return [NSArray arrayWithArray:imagesURLStringArray];
}

@end
