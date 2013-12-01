This is a simple <a href="https://github.com/AFNetworking/AFNetworking/">AFNetworking</a> and block based RSS parser.

Block RSS Parser is now compatible with AFNetworking 2.x.

## Memory management

BlockRSSParser now require ARC.
If you need to use it without ARC, please use the 1.0 tag.

## AFNetworking 1.x compatibility

Please use the 1.1 version (Podspec and git tag)

## Get started

Use Cocoapods! just add this line to you Podfile: 

```
pod 'BlockRSSParser', '~> 2.1'
```

If you don't want to use Cocoapods, follow theses instructions for a manual install :

1. Drag and drop the 4 files related to the parser:

	-RSSParser.h

	-RSSParser.m

	-RSSItem.h

	-RSSItem.m
	
2. You also need to add <a href="https://github.com/AFNetworking/AFNetworking/">AFNetworking</a> to your project

3. Include the two headers RSSParser.h and RSSItem.h where you need it

4. And than just use it this way:

``` objective-c
 NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://blog.lelevier.fr/rss"]];
    [RSSParser parseRSSFeedForRequest:req success:^(NSArray *feedItems) {
    	
    	//you get an array of RSSItem
    	
    } failure:^(NSError *error) {
    	
    	//something went wrong

    }];

```

## The RSS Item:

With this parser you can get most of the informations provided by an RSS feed:

``` objective-c
@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSString *itemDescripition;
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
```
note: take a look at the "RSS Standards" part

## Using the sample project

The sample project is here to provide you a quick way to see how to get started.
Dont forget to run "git submodules init" to fetch AFNetworking in the externals libraries

## RSS Standards

RSS is one of the worst protocol in the world. There is many standard to describe an RSS feed and most of them are outdated.

This parser is optimised to work with a Wordpress feed and some informations like the content or the comments informations will not be present with some other providers.

The sample code use a Tumblr feed provided for my personal blog. The content is empty but the full body of the article is present in the itemDescription (description in the feed) of the feed.

This parser is mostly optimised to use with a wordpress feed.

## Continuous integration

[![Build Status](https://travis-ci.org/tiboll/BlockRSSParser.png?branch=master)](https://travis-ci.org/tiboll/BlockRSSParser)

## TODO

-Testing => In Progress

-Documentation

-Feed header data

## License

Like AFNetworking, this parser is available under the MIT license.