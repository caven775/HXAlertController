//
//  NSObject+HXAlertController.m
//  Alert
//
//  Created by 林克文 on 2018/9/27.
//  Copyright © 2018年 LKW. All rights reserved.
//

#import "NSObject+HXAlertController.h"

@implementation NSObject (HXAlertController)

- (HXAlertMaker *)alert
{
    return [[HXAlertMaker alloc] init];
}

@end
