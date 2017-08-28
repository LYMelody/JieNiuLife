/*********************************************************************
 *            Copyright (C) 2011, 网龙天晴数码应用产品二部
 * @文件描述:对NSNumber的扩展,用于排序好友列表
 **********************************************************************
 *   Date        Name        Description
 *   2011/10/19  luzj        New
 *********************************************************************/


#import <Foundation/Foundation.h>


@interface NSString (NSString_Char)

//从char*指针性的字符串转换为NSString
+ (NSString *)stringWithNullableCString:(const char *)pStr;

- (unsigned int) unsignedIntValue;


@end
