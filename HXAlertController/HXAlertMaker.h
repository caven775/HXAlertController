//
//  HXAlertMaker.h
//  Alert
//
//  Created by 林克文 on 2018/9/27.
//  Copyright © 2018年 LKW. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^textFieldHandler)(UITextField *textField);
typedef void (^alertActionHanlder)(UIAlertAction *action);

@interface HXAlertMaker : NSObject

@property (nonatomic, copy, readonly) HXAlertMaker *(^title)(NSString *title);
@property (nonatomic, copy, readonly) HXAlertMaker *(^message)(NSString *message);
@property (nonatomic, copy, readonly) HXAlertMaker *(^preferredStyle)(UIAlertControllerStyle preferredStyle);
@property (nonatomic, copy, readonly) HXAlertMaker *(^addTextField)(textFieldHandler handker);
@property (nonatomic, copy, readonly) HXAlertMaker *(^action)(NSString *title, UIAlertActionStyle style, alertActionHanlder handler);
@property (nonatomic, strong, readonly) UIAlertController *(^show)(void);

@end
