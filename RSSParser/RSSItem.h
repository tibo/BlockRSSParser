//
//  RSSItem.h
//  RSSParser
//
//  Created by Thibaut LE LEVIER on 2/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSSItem : NSObject <NSCoding>

@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSString *itemDescription;
@property (strong,nonatomic) NSString *content;
@property (strong,nonatomic) NSURL *link;
@property (strong,nonatomic) NSURL *commentsLink;
@property (strong,nonatomic) NSURL *commentsFeed;
@property (strong,nonatomic) NSNumber *commentsCount;
@property (strong,nonatomic) NSDate *pubDate;
@property (strong,nonatomic) NSString *author;
@property (strong,nonatomic) NSString *guid;

-(NSArray *)imagesFromItemDescription;
-(NSArray *)imagesFromContent;

@end
