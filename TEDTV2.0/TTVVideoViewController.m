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

@interface TTVVideoViewController () <YTPlayerViewDelegate>

@property (nonatomic, weak) IBOutlet YTPlayerView *playerView;

@property (nonatomic, copy) NSArray *videoData;

- (NSString *)videoID;

- (void)loadVideoData;

- (void)playNextVideo;

@end

@implementation TTVVideoViewController

@synthesize content = _content;

- (void)viewDidLoad {
    [super viewDidLoad];

	[self loadVideoData];
	
	self.playerView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
		
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
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
	
	[self view];
	[self.playerView loadWithVideoId:self.videoID];
}

- (NSString *)videoID {
	
	NSString *guid = [self.content childValueForElementName:@"guid"];
	NSArray *components = [guid componentsSeparatedByString:@":"];
	
	return components.lastObject;
}

#pragma mark - Loading
- (void)loadVideoData {
	
	NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
	NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
	
	
	NSURL *URL = [NSURL URLWithString:@"http://www.youtube.com/rss/user/TEDtalksDirector/videos.rss"];
	NSURLSessionTask *task = [session dataTaskWithURL:URL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
		
		//			NSLog(@"request finished");
		//			NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
		
		DDXMLDocument *document = [[DDXMLDocument alloc] initWithData:data options:DDXMLDocumentXMLKind error:NULL];
		DDXMLElement *rootElement = document.rootElement;
		
		self.videoData = [[rootElement elementForName:@"channel"] elementsForName:@"item"];
		[self performSelectorOnMainThread:@selector(setContent:) withObject:self.videoData[0] waitUntilDone:NO];
		
		//			NSLog(@"%@", json);
		
	}];
	
	[task resume];
}

#pragma mark - Behavior
- (void)playNextVideo {

	NSInteger currentIndex = [self.videoData indexOfObject:self.content];
	NSInteger count = self.videoData.count;
	NSInteger index = (currentIndex + count + 1) % count;
	
	self.content = self.videoData[index];
}

#pragma mark - YTPlayerViewDelegate
- (void)playerViewDidBecomeReady:(YTPlayerView *)playerView {
	
//	NSLog(@"ready");
	[self.playerView playVideo];
}

- (void)playerView:(YTPlayerView *)playerView didChangeToState:(YTPlayerState)state {
	
//	NSLog(@"state: %d", state);
	
	switch (state) {
		case kYTPlayerStateEnded:
			[self playNextVideo];
			break;
			
		default:
			break;
	}
}

@end
