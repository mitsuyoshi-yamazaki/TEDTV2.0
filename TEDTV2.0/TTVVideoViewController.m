//
//  TTVVideoViewController.m
//  TEDTV2.0
//
//  Created by Yamazaki Mitsuyoshi on 10/13/14.
//  Copyright (c) 2014 Mitsuyoshi. All rights reserved.
//

#import "TTVVideoViewController.h"

#import "YTPlayerView.h"

@interface TTVVideoViewController ()

@property (nonatomic, weak) IBOutlet YTPlayerView *playerView;

@end

@implementation TTVVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	NSLog(@"%@", self.content);
	[self.playerView loadWithVideoId:self.content];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
