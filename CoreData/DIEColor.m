//
//  DIEColor.m
//  CoreData
//
//  Created by apple on 15/10/9.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "DIEColor.h"

@implementation DIEColor
- (instancetype)init
{
    if (self = [super init]) {
        _red = 255;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt:_red forKey:@"red"];
    [aCoder encodeInt:_blue forKey:@"blue"];
    [aCoder encodeInt:_green forKey:@"green"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _red = [aDecoder decodeIntForKey:@"red"];
        _blue = [aDecoder decodeIntForKey:@"blue"];
        _green = [aDecoder decodeIntForKey:@"green"];
    }
    return self;
}
@end






