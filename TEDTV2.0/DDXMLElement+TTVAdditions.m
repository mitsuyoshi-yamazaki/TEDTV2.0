//
//  DDXMLElement+TTVAdditions.m
//  TEDTV2.0
//
//  Created by Yamazaki Mitsuyoshi on 10/13/14.
//  Copyright (c) 2014 Mitsuyoshi. All rights reserved.
//

#import "DDXMLElement+TTVAdditions.h"

#import "DDXML.h"
#import "DDXMLElementAdditions.h"

@implementation DDXMLElement (TTVAdditions)

- (NSString *)childValueForElementName:(NSString *)name {
	
	DDXMLElement *element = [self elementForName:name];
	return element.stringValue;
}

@end
