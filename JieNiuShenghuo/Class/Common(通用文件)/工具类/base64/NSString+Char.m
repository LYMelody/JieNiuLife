/*********************************************************************
 *            Copyright (C) 2011, 网龙天晴数码应用产品二部
 * @文件描述:对NSNumber的扩展,用于排序好友列表
 **********************************************************************
 *   Date        Name        Description
 *   2011/10/19  luzj        New
 *********************************************************************/


@implementation NSString (NSString_Char)

//从char*指针性的字符串转换为NSString
+ (NSString *)stringWithNullableCString:(const char *)pStr
{
    if (pStr != NULL)
    {
        return [NSString stringWithUTF8String:pStr];
    }
    return @"";
}

- (unsigned int) unsignedIntValue
{
    return (unsigned int)([self longLongValue]);
}


@end
