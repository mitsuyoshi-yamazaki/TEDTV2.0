//
//  TTVVideoListViewController.m
//  TEDTV2.0
//
//  Created by Yamazaki Mitsuyoshi on 10/13/14.
//  Copyright (c) 2014 Mitsuyoshi. All rights reserved.
//

#import "TTVVideoListViewController.h"

#import "TTVVideoViewController.h"

#import "DDXML.h"
#import "DDXMLElementAdditions.h"
#import "DDXMLElement+TTVAdditions.h"

@interface TTVVideoListViewController ()

@property (nonatomic, copy) NSArray *contents;

- (void)loadVideoData;

@end

@implementation TTVVideoListViewController

@synthesize contents = _contents;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self loadVideoData];
	
//	self.contents = @[@"Oj8eFu72_fc"];
	// http://www.youtube.com/rss/user/TEDtalksDirector/videos.rss
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Accessor
- (void)setContents:(NSArray *)contents {
	
	if (contents == _contents) {
		return;
	}
	
	_contents = contents.copy;
	
	[self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
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
			
			self.contents = [[rootElement elementForName:@"channel"] elementsForName:@"item"];
			
			//			NSLog(@"%@", json);
			
		}];
		
		[task resume];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.contents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
	
	DDXMLElement *content = self.contents[indexPath.row];
	
	cell.textLabel.text = [content childValueForElementName:@"title"];
	
    return cell;
}

#pragma mark - UIStoryboardSegue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	
	if ([segue.identifier isEqualToString:@"PushVideoViewSegue"]) {
		
		NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
		DDXMLElement *content = self.contents[indexPath.row];
		
		TTVVideoViewController *videoViewController = segue.destinationViewController;
		videoViewController.content = content;
	}
}

@end
