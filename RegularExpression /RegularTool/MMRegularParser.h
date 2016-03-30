//
//  MMRegularParser.h
//  RegularExpression
//
//  Created by yumingming on 16/1/19.
//  Copyright © 2016年 MM. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MMRegularGroup;
@interface MMRegularParser : NSObject
{
    NSString *_pattern;
    BOOL _ignoreCase;
    MMRegularGroup *_node;
    BOOL _finished;
    NSRegularExpression *_exactQuantifierRegex;
    NSRegularExpression *_rangeQuantifierRegex;
}

- (id)initWithPattern:(NSString*)pattern;
- (id)initWithPattern:(NSString*)pattern ignoreCase:(BOOL)ignoreCase;
- (NSString*)reformatString:(NSString*)input;

@property (readonly, nonatomic) NSString *pattern;


@end
