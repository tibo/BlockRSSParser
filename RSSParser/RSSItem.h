//
//  RSSItem.h
//  RSSParser
//
//  Created by Thibaut LE LEVIER on 2/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSSItem : NSObject

@property (retain,nonatomic) NSString *title;
@property (retain,nonatomic) NSString *itemDescripition;
@property (retain,nonatomic) NSString *content;
@property (retain,nonatomic) NSURL *link;
@property (retain,nonatomic) NSURL *commentsLink;
@property (retain,nonatomic) NSURL *commentsFeed;
@property (retain,nonatomic) NSNumber *commentsCount;
@property (retain,nonatomic) NSDate *pubDate;
@property (retain,nonatomic) NSString *author;
@property (retain,nonatomic) NSString *guid;

-(NSArray *)imagesFromItemDescription;
-(NSArray *)imagesFromContent;

@end
