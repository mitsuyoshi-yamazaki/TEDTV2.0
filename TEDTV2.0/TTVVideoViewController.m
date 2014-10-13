//
//  TTVVideoViewController.m
//  TEDTV2.0
//
//  Created by Yamazaki Mitsuyoshi on 10/13/14.
//  Copyright (c) 2014 Mitsuyoshi. All rights reserved.
//

#import "TTVVideoViewController.h"

#import "YTPlayerView.h"

#import "DDXML.h"
#import "DDXMLElementAdditions.h"
#import "DDXMLElement+TTVAdditions.h"

@interface TTVVideoViewController ()

@property (nonatomic, weak) IBOutlet YTPlayerView *playerView;

- (NSString *)videoID;

@end

@implementation TTVVideoViewController

@synthesize content = _content;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	NSLog(@"%@", self.content);
	
	[self.playerView loadWithVideoId:self.videoID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Accessor
- (void)setContent:(DDXMLElement *)content {
	
	if (content == _content) {
		return;
	}
	
	_content = content;
	
	self.title = [content childValueForElementName:@"title"];
	self.navigationItem.title = self.title;
}

- (NSString *)videoID {
	
	NSString *guid = [self.content childValueForElementName:@"guid"];
	NSArray *components = [guid componentsSeparatedByString:@":"];
	
	return components.lastObject;
}

@end
