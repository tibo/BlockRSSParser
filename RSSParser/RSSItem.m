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

- (NSArray *)urlsFromContent
{
    if (content) {
        NSMutableArray *urlsArray = [[[NSMutableArray alloc] init] autorelease];
        NSRegularExpression *regex = [NSRegularExpression         
                                      regularExpressionWithPattern:@"https?://([-\\w\\.]+)+(:\\d+)?(/([\\w/_\\.]*(\\?\\S+)?)?)?"
                                      options:NSRegularExpressionCaseInsensitive
                                      error:nil];
        
        
        [[regex matchesInString:content options:0 range:NSMakeRange(0, content.length)] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [urlsArray addObject:[content substringWithRange:[obj range]]];
        }];
        
        return urlsArray;
    }
    
    return nil;
}

- (NSArray *)urlsFromItemDescription
{
    if (itemDescripition) {
        NSMutableArray *urlsArray = [[[NSMutableArray alloc] init] autorelease];
        NSRegularExpression *regex = [NSRegularExpression         
                                      regularExpressionWithPattern:@"https?://([-\\w\\.]+)+(:\\d+)?(/([\\w/_\\.]*(\\?\\S+)?)?)?"
                                      options:NSRegularExpressionCaseInsensitive
                                      error:nil];
        
        
        [[regex matchesInString:itemDescripition options:0 range:NSMakeRange(0, itemDescripition.length)] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [urlsArray addObject:[itemDescripition substringWithRange:[obj range]]];
        }];
        
        return urlsArray;
    }

    return nil;
}

- (NSArray *)imagesURLFromContent
{
    //dirty way, if a regex master see this any help will be welcome
    
    NSMutableArray *imagesURLArray = [[[NSMutableArray alloc] init] autorelease];
    [[self urlsFromContent] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        NSRange pngRange = [obj rangeOfString:@"png"];
        NSRange jpgRange = [obj rangeOfString:@"jpg"];
        NSRange jpegRange = [obj rangeOfString:@"jpeg"];
        NSRange gifRange = [obj rangeOfString:@"gif"];
        
        if (pngRange.location != NSNotFound
            || jpgRange.location != NSNotFound
            || jpegRange.location != NSNotFound
            || gifRange.location != NSNotFound) {
            
            [imagesURLArray addObject:obj];
        }
        
        
    }];
    
    return imagesURLArray;
}

- (NSArray *)imagesURLFromItemDescription
{
    //dirty way, if a regex master see this any help will be welcome
    
    NSMutableArray *imagesURLArray = [[[NSMutableArray alloc] init] autorelease];
    [[self urlsFromItemDescription] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        NSRange pngRange = [obj rangeOfString:@"png"];
        NSRange jpgRange = [obj rangeOfString:@"jpg"];
        NSRange jpegRange = [obj rangeOfString:@"jpeg"];
        NSRange gifRange = [obj rangeOfString:@"gif"];
        
        if (pngRange.location != NSNotFound
            || jpgRange.location != NSNotFound
            || jpegRange.location != NSNotFound
            || gifRange.location != NSNotFound) {
            
            [imagesURLArray addObject:obj];
        }
        
        
    }];
    
    return imagesURLArray;    
}

@end
