//
//  RSSParserTests.m
//  RSSParser_Sample
//
//  Created by Thibaut LE LEVIER on 27/11/2013.
//
//

#import "Kiwi.h"
#import "RSSParser.h"

SPEC_BEGIN(RSSParserTests)

describe(@"RSSParser", ^{
    
    __block NSString *atomMock = [[NSBundle bundleForClass:[self class]] pathForResource:@"atom" ofType:@"xml"];
    
    __block NSString *rssWordpressMock = [[NSBundle bundleForClass:[self class]] pathForResource:@"rsswordpress" ofType:@"xml"];
    
    beforeEach(^{

    });
    
    afterAll(^{

    });
    
//Atom tests
    it(@"parser with atom feed should return one item or more", ^{
        
        NSURL *atomMockURL = [NSURL fileURLWithPath:atomMock];

        __block NSArray *items = nil;
        
        [RSSParser parseRSSFeedForRequest:[NSURLRequest requestWithURL:atomMockURL]
                                  success:^(NSArray *feedItems) {
                                      items = [NSArray arrayWithArray:feedItems];
                                  }
                                  failure:^(NSError *error) {
                                      
                                  }];
        
        [[expectFutureValue(items) shouldEventually] beNonNil];
        [[expectFutureValue(items) shouldEventually] haveAtLeast:1];
        
    });
    
    it(@"parser with atom feed should return exactly 20 items", ^{
        
        NSURL *atomMockURL = [NSURL fileURLWithPath:atomMock];
        
        __block NSArray *items = nil;
        
        [RSSParser parseRSSFeedForRequest:[NSURLRequest requestWithURL:atomMockURL]
                                  success:^(NSArray *feedItems) {
                                      items = [NSArray arrayWithArray:feedItems];
                                  }
                                  failure:^(NSError *error) {
                                      
                                  }];
        
        [[expectFutureValue(items) shouldEventually] beNonNil];
        [[expectFutureValue(items) shouldEventually] have:20];
        
    });
    
    it(@"first item in atom feed talk about octopress", ^{
        NSURL *atomMockURL = [NSURL fileURLWithPath:atomMock];
        
        __block NSArray *items = nil;
        __block NSString *testItemTitle = nil;
        __block NSString *testItemContent = nil;
        
        NSURLRequest *request = [NSURLRequest requestWithURL:atomMockURL];
        
        [RSSParser parseRSSFeedForRequest:request
                                  success:^(NSArray *feedItems) {
                                      items = [NSArray arrayWithArray:feedItems];
                                      testItemTitle = [[feedItems firstObject] title];
                                      testItemContent = [[feedItems firstObject] content];
                                  }
                                  failure:^(NSError *error) {
                                  }];
        
        [[expectFutureValue(items) shouldEventually] beNonNil];
        [[expectFutureValue(items) shouldEventually] haveAtLeast:1];
        
        [[expectFutureValue(testItemTitle) shouldEventually] containString:@"octopress" options:NSCaseInsensitiveSearch];
        [[expectFutureValue(testItemContent) shouldEventually] containString:@"octopress" options:NSCaseInsensitiveSearch];
        
    });
    
    it(@"last item title and content in atom feed talk about Mac and TimeMachine", ^{
        
        NSURL *atomMockURL = [NSURL fileURLWithPath:atomMock];
        
        __block NSArray *items = nil;
        __block NSString *testItemTitle = nil;
        __block NSString *testItemContent = nil;
        
        [RSSParser parseRSSFeedForRequest:[NSURLRequest requestWithURL:atomMockURL]
                                  success:^(NSArray *feedItems) {
                                      items = [NSArray arrayWithArray:feedItems];
                                      testItemTitle = [[feedItems lastObject] title];
                                      testItemContent = [[feedItems lastObject] content];
                                  }
                                  failure:^(NSError *error) {
                                      
                                  }];
        
        [[expectFutureValue(items) shouldEventually] beNonNil];
        [[expectFutureValue(items) shouldEventually] haveAtLeast:1];
        
        [[expectFutureValue(testItemTitle) shouldEventually] containString:@"mac" options:NSCaseInsensitiveSearch];
        [[expectFutureValue(testItemContent) shouldEventually] containString:@"timeMachine" options:NSCaseInsensitiveSearch];
        
    });
    
//RSS Wordpress tests
    it(@"parser with wordpress rss feed should return one item or more", ^{
        
        NSURL *rssWordpressMockURL = [NSURL fileURLWithPath:rssWordpressMock];
        
        __block NSArray *items = nil;
        
        [RSSParser parseRSSFeedForRequest:[NSURLRequest requestWithURL:rssWordpressMockURL]
                                  success:^(NSArray *feedItems) {
                                      items = [NSArray arrayWithArray:feedItems];
                                  }
                                  failure:^(NSError *error) {
                                      
                                  }];
        
        [[expectFutureValue(items) shouldEventually] beNonNil];
        [[expectFutureValue(items) shouldEventually] haveAtLeast:1];
        
    });
    
    it(@"parser with wordpress rss feed should return exactly 5 items", ^{
        
        NSURL *rssWordpressMockURL = [NSURL fileURLWithPath:rssWordpressMock];
        
        __block NSArray *items = nil;
        
        [RSSParser parseRSSFeedForRequest:[NSURLRequest requestWithURL:rssWordpressMockURL]
                                  success:^(NSArray *feedItems) {
                                      items = [NSArray arrayWithArray:feedItems];
                                  }
                                  failure:^(NSError *error) {
                                      
                                  }];
        
        [[expectFutureValue(items) shouldEventually] beNonNil];
        [[expectFutureValue(items) shouldEventually] have:5];
        
    });
    
    it(@"first item in wordpress rss feed talk about \"Investing\"", ^{
    
        NSURL *rssWordpressMockURL = [NSURL fileURLWithPath:rssWordpressMock];
        
        __block NSArray *items = nil;
        __block NSString *testItemTitle = nil;
        __block NSString *testItemContent = nil;
        
        [RSSParser parseRSSFeedForRequest:[NSURLRequest requestWithURL:rssWordpressMockURL]
                                  success:^(NSArray *feedItems) {
                                      items = [NSArray arrayWithArray:feedItems];
                                      testItemTitle = [[feedItems firstObject] title];
                                      testItemContent = [[feedItems firstObject] content];
                                  }
                                  failure:^(NSError *error) {
                                      
                                  }];
        
        [[expectFutureValue(items) shouldEventually] beNonNil];
        [[expectFutureValue(items) shouldEventually] haveAtLeast:1];
        
        [[expectFutureValue(testItemTitle) shouldEventually] containString:@"investing" options:NSCaseInsensitiveSearch];
        [[expectFutureValue(testItemContent) shouldEventually] containString:@"investing" options:NSCaseInsensitiveSearch];
        
    });
    
    it(@"last item in wordpress rss feed talk about Spotify", ^{
        
        NSURL *rssWordpressMockURL = [NSURL fileURLWithPath:rssWordpressMock];
        
        __block NSArray *items = nil;
        __block NSString *testItemTitle = nil;
        __block NSString *testItemContent = nil;
        
        [RSSParser parseRSSFeedForRequest:[NSURLRequest requestWithURL:rssWordpressMockURL]
                                  success:^(NSArray *feedItems) {
                                      items = [NSArray arrayWithArray:feedItems];
                                      testItemTitle = [[feedItems lastObject] title];
                                      testItemContent = [[feedItems lastObject] content];
                                  }
                                  failure:^(NSError *error) {
                                      
                                  }];
        
        [[expectFutureValue(items) shouldEventually] beNonNil];
        [[expectFutureValue(items) shouldEventually] haveAtLeast:1];
        
        [[expectFutureValue(testItemTitle) shouldEventually] containString:@"spotify" options:NSCaseInsensitiveSearch];
        [[expectFutureValue(testItemContent) shouldEventually] containString:@"spotify" options:NSCaseInsensitiveSearch];
    });
    
});

SPEC_END