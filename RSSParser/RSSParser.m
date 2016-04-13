//
//  RSSParser.m
//  RSSParser
//
//  Created by Thibaut LE LEVIER on 1/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RSSParser.h"
#import "AFHTTPSessionManager.h"
#import "AFURLResponseSerialization.h"

@interface RSSParser()

@property (nonatomic) NSDateFormatter *formatter;

@end

@implementation RSSParser

#pragma mark lifecycle
- (id)init {
    self = [super init];
    if (self) {
        items = [[NSMutableArray alloc] init];
        
        _formatter = [[NSDateFormatter alloc] init];
        [_formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_EN"]];
        [_formatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss Z"];
    }
    return self;
}

#pragma mark -

#pragma mark parser

+ (void)parseRSSFeedForRequest:(NSURLRequest *)urlRequest
                       success:(void (^)(NSArray *feedItems))success
                       failure:(void (^)(NSError *error))failure
{
    RSSParser *parser = [[RSSParser alloc] init];
    [parser parseRSSFeedForRequest:urlRequest success:success failure:failure];
}


- (void)parseRSSFeedForRequest:(NSURLRequest *)urlRequest
                       success:(void (^)(NSArray *feedItems))success
                       failure:(void (^)(NSError *error))failure
{
    
    block = [success copy];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/xml", @"text/xml",@"application/rss+xml", @"application/atom+xml", nil];
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:urlRequest uploadProgress:nil downloadProgress:nil
      completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
      if (error) {
        if (failure) failure(error);
      } else {
        if (success) {
          [(NSXMLParser *)responseObject setDelegate:self];
          [(NSXMLParser *)responseObject parse];
        }
      }
      }];
    [task resume];
}

#pragma mark -
#pragma mark NSXMLParser delegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
    
    if ([elementName isEqualToString:@"item"] || [elementName isEqualToString:@"entry"]) {
        currentItem = [[RSSItem alloc] init];
    }
    
    tmpString = [[NSMutableString alloc] init];
    tmpAttrDict = attributeDict;
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:@"item"] || [elementName isEqualToString:@"entry"]) {
        [items addObject:currentItem];
    }
    if (currentItem != nil && tmpString != nil) {
        
        if ([elementName isEqualToString:@"title"]) {
            [currentItem setTitle:tmpString];
        } else if ([elementName isEqualToString:@"description"]) {
            [currentItem setItemDescription:tmpString];
        } else if ([elementName isEqualToString:@"content:encoded"] || [elementName isEqualToString:@"content"]) {
            [currentItem setContent:tmpString];
        } else if ([elementName isEqualToString:@"link"]) {
            [currentItem setLink:[NSURL URLWithString:tmpString]];
        } else if ([elementName isEqualToString:@"comments"]) {
            [currentItem setCommentsLink:[NSURL URLWithString:tmpString]];
        } else if ([elementName isEqualToString:@"wfw:commentRss"]) {
            [currentItem setCommentsFeed:[NSURL URLWithString:tmpString]];
        } else if ([elementName isEqualToString:@"slash:comments"]) {
            [currentItem setCommentsCount:[NSNumber numberWithInt:[tmpString intValue]]];
        } else if ([elementName isEqualToString:@"pubDate"]) {
            [currentItem setPubDate:[_formatter dateFromString:tmpString]];
        } else if ([elementName isEqualToString:@"dc:creator"]) {
            [currentItem setAuthor:tmpString];
        } else if ([elementName isEqualToString:@"guid"]) {
            [currentItem setGuid:tmpString];
        }
        
        // sometimes the URL is inside enclosure element, not in link. Reference: http://www.w3schools.com/rss/rss_tag_enclosure.asp
        if ([elementName isEqualToString:@"enclosure"] && tmpAttrDict != nil) {
            NSString *url = [tmpAttrDict objectForKey:@"url"];
            if(url) {
                [currentItem setLink:[NSURL URLWithString:url]];
            }
        }
    }
    
    if ([elementName isEqualToString:@"rss"] || [elementName isEqualToString:@"feed"]) {
        block(items);
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [tmpString appendString:string];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    failblock(parseError);
    [parser abortParsing];
}

#pragma mark -

@end
