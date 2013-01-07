This is a simple <a href="https://github.com/AFNetworking/AFNetworking/">AFNetworking</a> and block based RSS parser.

## Get started

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

## TODO

-Testing

-Documentation

-Feed header data

## License

Like AFNetworking, this parser is available under the MIT license.