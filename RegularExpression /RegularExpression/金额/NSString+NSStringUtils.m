//
//  NSString+NSStringUtils.m
//  RegularExpression
//
//  Created by yumingming on 16/3/25.
//  Copyright © 2016年 MM. All rights reserved.
//

#import "NSString+NSStringUtils.h"

@implementation NSString (NSStringUtils)
+ (NSString *)stringWithString:(NSString *)string times:(NSInteger)times{
    NSMutableString *result = [[NSMutableString alloc] init];
    for (int i = 0; i < times; i++) {
        [result appendString:string];
    }
    return result;
}

- (NSString *)replace:(NSString *)o with:(NSString *)n{
    return [self stringByReplacingOccurrencesOfString:o withString:n];
}

- (NSString *)format4n4{
    NSInteger len = self.length;
    if (len < 8) {
        return self;
    }
    NSRange range = NSMakeRange(4, len - 8);
    NSString *points = [NSString stringWithString:@"*" times:6];
    return [self stringByReplacingCharactersInRange:range withString:points];
}

- (NSString *)formatAccount
{
    NSInteger len = self.length;
    NSMutableString *result = [[NSMutableString alloc] init];
    for (int i = 0; i < len; i+= 4) {
        if (i + 4 >= len) {
            [result appendString:[self substringFromIndex:i]];
        }else{
            [result appendString:[self substringWithRange:NSMakeRange(i, 4)]];
            [result appendString:@" "];
        }
    }
    return result;
}

//手机号中间四位星号
- (NSString *)mobileFormat
{
    NSInteger len = self.length;
    if (len <= 7) {
        return self;
    }
    NSRange range = NSMakeRange(3, len - 7);
    NSString *points = [NSString stringWithString:@"*" times:4];
    return [self stringByReplacingCharactersInRange:range withString:points];
}

- (NSString *)phoneNumberTrim{
    return [[[[[self replace:@"-" with:@""] replace:@"+86" with:@""] replace:@"(" with:@""] replace:@")" with:@""] replace:@" " with:@""];
}

- (NSString *)formatMonery{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setCurrencySymbol:@""];
    [formatter setNegativeFormat:@""];
    NSDecimalNumber *number = [NSDecimalNumber decimalNumberWithString:[self replace:@"," with:@""]];
    return [[formatter stringFromNumber:number] formatWhiteSpace];
}

- (NSString *)formatMoneryRe{
    return [[[self formatMonery] replace:@"," with:@""] substringToIndex:[[self formatMonery] replace:@"," with:@""].length];

}

//根据币种格式化金额
- (NSString *)formatMoneyWithCurrency:(NSString *)currency
{
    //    if (!MBIsStringWithAnyText(currency)) {
    //        return [self formatMonery];
    //    }
    //    NSArray *specialCurrency = [MBConstant kSpecialCurrency];
    //    if ([specialCurrency containsObject:currency]) {
    //        return [self formatMonerySpecial];
    //    }
    //    if ([currency isEqualToString:@"日元"] ||
    //        [currency isEqualToString:@"韩元"] ||
    //        [currency isEqualToString:@"越南盾"]) {
    //        return [self formatMonerySpecial];
    //    }
    //    else{
    //        return [self formatMonery];
    //    }
    return @"-";
}

- (NSString *)formatMonerySpecial{
    return [[self formatMonery] componentsSeparatedByString:@"."][0];
}

- (NSString *)formatMoneryThreeDecimal
{
    NSString * value = [NSString stringWithFormat:@"%.3f",
                        [[self replace:@"," with:@""] doubleValue]];

    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setCurrencySymbol:@""];

    NSDecimalNumber *number = [NSDecimalNumber decimalNumberWithString:[value componentsSeparatedByString:@"."][0]];
    return [NSString stringWithFormat:@"%@.%@",
            [[formatter stringFromNumber:number] formatWhiteSpace],
            [value componentsSeparatedByString:@"."][1]];
}

-(NSString *)formatMoneryFourDecimal{
    NSString * value = [NSString stringWithFormat:@"%.4f",
                        [[self replace:@"," with:@""] doubleValue]];

    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setCurrencySymbol:@""];

    NSDecimalNumber *number = [NSDecimalNumber decimalNumberWithString:[value componentsSeparatedByString:@"."][0]];
    return [NSString stringWithFormat:@"%@.%@",
            [[formatter stringFromNumber:number] formatWhiteSpace],
            [value componentsSeparatedByString:@"."][1]];
}

-(NSString *)formatBalance{
    return [[[self formatMonery] replace:@"," with:@""] substringToIndex:[[self formatMonery] replace:@"," with:@""].length-1];
}

- (NSString *)correctUserInput
{
    NSString *result = self;
    if (result.length > 0)
    {
        if ([result hasPrefix:@"."])
        {
            result = [NSString stringWithFormat:@"0%@",result];
        }
    }
    return result;
}
-(NSString *)formatAnyDecimal{
    if ([[self componentsSeparatedByString:@"."] count]==1) {
        return [[self formatMonery] componentsSeparatedByString:@"."][0];
    }
    NSString *str=[self componentsSeparatedByString:@"."][1];
    NSString *value=[[self formatMonery] componentsSeparatedByString:@"."][0];
    if (!value) {
        return [NSString stringWithFormat:@"0.%@",str];
    }
    return [NSString stringWithFormat:@"%@.%@",value,str];
}



- (NSString *)formatWhiteSpace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)formatWhiteSpaceAndNewLineCharacterSet
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)formatMoneyUpper
{
    NSString *strValue = [self replace:@"," with:@""];
    NSRange range = [strValue rangeOfString:@"."];

    if (range.location != NSNotFound) {//0.5549999
        NSString* pointStr = [strValue substringFromIndex:range.location+1];
        if ([pointStr length] > 3) {
            strValue = [strValue substringToIndex:range.location + 4];
        }
    }

    NSString *str = [NSString stringWithFormat:@"%f", ([strValue doubleValue] + 0.005)];
    range = [str rangeOfString:@"."];

    NSString* yuanStr = nil;
    NSString* jiaoAndFenStr = nil;
    NSArray* arr = @[@"零",@"壹",@"贰",@"叁",@"肆",@"伍",@"陆",@"柒",@"捌",@"玖"];
    NSMutableString* hanziStr = [NSMutableString stringWithString:@""];

    if (range.location != NSNotFound) {
        yuanStr = [str substringToIndex:range.location];
        jiaoAndFenStr = [str substringFromIndex:range.location+1];
    }
    else{
        yuanStr = str;
        jiaoAndFenStr = @"";
    }

    NSInteger yuanAdd0Count = 16 - yuanStr.length;
    NSInteger jiaoAndFenAdd0Count = 2 - jiaoAndFenStr.length;
    NSMutableString* yuanStrAfterAdd0 = [NSMutableString stringWithString:@""];
    NSMutableString* jiaoAndFenStrAfterAdd0 = [NSMutableString stringWithString:@""];

    for (int i = 0; i < yuanAdd0Count; i++) {
        [yuanStrAfterAdd0 appendString:@"0"];
    }
    [yuanStrAfterAdd0 appendString:yuanStr];
    [jiaoAndFenStrAfterAdd0 appendString:jiaoAndFenStr];
    for (int j = 0; j < jiaoAndFenAdd0Count; j++) {
        [jiaoAndFenStrAfterAdd0 appendString:@"0"];
    }

    NSString* zhaoStr = [yuanStrAfterAdd0 substringToIndex:4];
    NSString* hanziZhaoStr = [NSString stringWithFormat:@"%@%@%@%@",[[zhaoStr substringToIndex:1] intValue] != 0 ? [NSString stringWithFormat:@"%@仟",arr[[[zhaoStr substringToIndex:1] intValue]]]:@"零",[[zhaoStr substringWithRange:NSMakeRange(1, 1)] intValue] != 0 ? [NSString stringWithFormat:@"%@佰",arr[[[zhaoStr substringWithRange:NSMakeRange(1, 1)] intValue]]]:@"零",[[zhaoStr substringWithRange:NSMakeRange(2, 1)] intValue] != 0 ? [NSString stringWithFormat:@"%@拾",arr[[[zhaoStr substringWithRange:NSMakeRange(2, 1)] intValue]]]:@"零",arr[[[zhaoStr substringFromIndex:3] intValue]]];
    for (int k = 0; k < 3; k++) {
        hanziZhaoStr = [hanziZhaoStr stringByReplacingOccurrencesOfString:@"零零" withString:@"零"];
    }
    if ([hanziZhaoStr hasSuffix:@"零"]) {
        if (hanziZhaoStr.length - 1 == 0) {
            hanziZhaoStr = @"";
        }
        else{
            hanziZhaoStr = [hanziZhaoStr substringToIndex:hanziZhaoStr.length-1];
        }
    }
    if ([hanziZhaoStr length] > 0) {
        [hanziStr appendString:hanziZhaoStr];
        [hanziStr appendString:@"兆"];
    }


    NSString* yiStr = [yuanStrAfterAdd0 substringWithRange:NSMakeRange(4,4)];
    NSString* hanziYiStr = [NSString stringWithFormat:@"%@%@%@%@",[[yiStr substringToIndex:1] intValue] != 0 ? [NSString stringWithFormat:@"%@仟",arr[[[yiStr substringToIndex:1] intValue]]]:@"零",[[yiStr substringWithRange:NSMakeRange(1, 1)] intValue] != 0 ? [NSString stringWithFormat:@"%@佰",arr[[[yiStr substringWithRange:NSMakeRange(1, 1)] intValue]]]:@"零",[[yiStr substringWithRange:NSMakeRange(2, 1)] intValue] != 0 ? [NSString stringWithFormat:@"%@拾",arr[[[yiStr substringWithRange:NSMakeRange(2, 1)] intValue]]]:@"零",arr[[[yiStr substringFromIndex:3] intValue]]];
    for (int k = 0; k < 3; k++) {
        hanziYiStr = [hanziYiStr stringByReplacingOccurrencesOfString:@"零零" withString:@"零"];
    }
    if ([hanziYiStr hasSuffix:@"零"]) {
        if (hanziYiStr.length - 1 == 0) {
            hanziYiStr = @"";
        }
        else{
            hanziYiStr = [hanziYiStr substringToIndex:hanziYiStr.length-1];
        }
    }
    if ([hanziYiStr length] > 0) {
        [hanziStr appendString:hanziYiStr];
        [hanziStr appendString:@"亿"];
    }

    NSString* wanStr = [yuanStrAfterAdd0 substringWithRange:NSMakeRange(8,4)];
    NSString* hanziWanStr = [NSString stringWithFormat:@"%@%@%@%@",[[wanStr substringToIndex:1] intValue] != 0 ? [NSString stringWithFormat:@"%@仟",arr[[[wanStr substringToIndex:1] intValue]]]:@"零",[[wanStr substringWithRange:NSMakeRange(1, 1)] intValue] != 0 ? [NSString stringWithFormat:@"%@佰",arr[[[wanStr substringWithRange:NSMakeRange(1, 1)] intValue]]]:@"零",[[wanStr substringWithRange:NSMakeRange(2, 1)] intValue] != 0 ? [NSString stringWithFormat:@"%@拾",arr[[[wanStr substringWithRange:NSMakeRange(2, 1)] intValue]]]:@"零",arr[[[wanStr substringFromIndex:3] intValue]]];
    for (int k = 0; k < 3; k++) {
        hanziWanStr = [hanziWanStr stringByReplacingOccurrencesOfString:@"零零" withString:@"零"];
    }
    if ([hanziWanStr hasSuffix:@"零"]) {
        if (hanziWanStr.length - 1 == 0) {
            hanziWanStr = @"";
        }
        else{
            hanziWanStr = [hanziWanStr substringToIndex:hanziWanStr.length-1];
        }
    }
    if ([hanziWanStr length] > 0) {
        [hanziStr appendString:hanziWanStr];
        [hanziStr appendString:@"万"];
    }

    NSString* geStr = [yuanStrAfterAdd0 substringWithRange:NSMakeRange(12,4)];
    NSString* hanziGeStr = [NSString stringWithFormat:@"%@%@%@%@",[[geStr substringToIndex:1] intValue] != 0 ? [NSString stringWithFormat:@"%@仟",arr[[[geStr substringToIndex:1] intValue]]]:@"零",[[geStr substringWithRange:NSMakeRange(1, 1)] intValue] != 0 ? [NSString stringWithFormat:@"%@佰",arr[[[geStr substringWithRange:NSMakeRange(1, 1)] intValue]]]:@"零",[[geStr substringWithRange:NSMakeRange(2, 1)] intValue] != 0 ? [NSString stringWithFormat:@"%@拾",arr[[[geStr substringWithRange:NSMakeRange(2, 1)] intValue]]]:@"零",arr[[[geStr substringFromIndex:3] intValue]]];
    for (int k = 0; k < 3; k++) {
        hanziGeStr = [hanziGeStr stringByReplacingOccurrencesOfString:@"零零" withString:@"零"];
    }
    if ([hanziGeStr hasSuffix:@"零"]) {
        if (hanziGeStr.length - 1 == 0) {
            hanziGeStr = @"";
        }
        else{
            hanziGeStr = [hanziGeStr substringToIndex:hanziGeStr.length-1];
        }
    }
    if ([hanziGeStr length] > 0) {
        [hanziStr appendString:hanziGeStr];
    }
    NSString* returnHanziStr = hanziStr;

    if ([hanziStr hasPrefix:@"零"]) {
        returnHanziStr = [hanziStr substringFromIndex:1];
    }
    if (returnHanziStr.length > 0) {
        returnHanziStr = [NSString stringWithFormat:@"%@元",returnHanziStr];
    }

    if ([[jiaoAndFenStrAfterAdd0 substringWithRange:NSMakeRange(1,1)] intValue] != 0) {
        NSString* JiaoFen = [NSString stringWithFormat:@"%@%@分",[[jiaoAndFenStrAfterAdd0 substringToIndex:1] intValue] != 0 ? [NSString stringWithFormat:@"%@角",arr[[[jiaoAndFenStrAfterAdd0 substringToIndex:1] intValue]]]:@"零",arr[[[jiaoAndFenStrAfterAdd0 substringWithRange:NSMakeRange(1,1)] intValue]]];
        NSString* realStr = [NSString stringWithFormat:@"%@%@",returnHanziStr,JiaoFen];
        if ([realStr hasPrefix:@"零"]) {
            realStr = [realStr substringFromIndex:1];
        }
        return realStr;
    }
    else{
        NSString* Jiao = [[jiaoAndFenStrAfterAdd0 substringToIndex:1] intValue] != 0 ? [NSString stringWithFormat:@"%@角",arr[[[jiaoAndFenStrAfterAdd0 substringToIndex:1] intValue]]]:returnHanziStr.length>0 ? @"整":@"";
        return [NSString stringWithFormat:@"%@%@",returnHanziStr,Jiao];
    }
}
@end
