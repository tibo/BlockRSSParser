//
//  ArticleDetailViewController.h
//  RSSParser_Sample
//
//  Created by Thibaut LE LEVIER on 2/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSItem.h"

@interface ArticleDetailViewController : UIViewController
{
 IBOutlet UIWebView *articleWebView;   
}

@property (assign,nonatomic) RSSItem *item;

@end
