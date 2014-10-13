//
//  TTVVideoListViewController.m
//  TEDTV2.0
//
//  Created by Yamazaki Mitsuyoshi on 10/13/14.
//  Copyright (c) 2014 Mitsuyoshi. All rights reserved.
//

#import "TTVVideoListViewController.h"

#import "TTVVideoViewController.h"

@interface TTVVideoListViewController ()

@property (nonatomic, copy) NSArray *contents;

- (void)loadVideoData;

@end

@implementation TTVVideoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.contents = @[@"Oj8eFu72_fc"];
	
	// http://www.youtube.com/rss/user/TEDtalksDirector/videos.rss
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Loading
- (void)loadVideoData {
	
//	NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//	NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
//	
//	
//		NSURL *URL = [NSURL URLWithString:@"http://www.youtube.com/rss/user/TEDtalksDirector/videos.rss"];
//		NSURLSessionTask *task = [session dataTaskWithURL:URL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//			
//			//			NSLog(@"request finished");
//			//			NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
//			
//			id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
//			
//			//			NSLog(@"%@", json);
//			
//			[self.posts addObject:json];
//			
//			[self.coverScrollView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
//			[self.coverTableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
//		}];
//		
//		[task resume];
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
    
	cell.textLabel.text = self.contents[0];
	
    return cell;
}

#pragma mark - UIStoryboardSegue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	
	if ([segue.identifier isEqualToString:@"PushVideoViewSegue"]) {
		
		TTVVideoViewController *videoViewController = segue.destinationViewController;
		videoViewController.content = self.contents[0];
	}
}

@end
