//
//  HXAlertMaker.m
//  Alert
//
//  Created by 林克文 on 2018/9/27.
//  Copyright © 2018年 LKW. All rights reserved.
//

#import "HXAlertMaker.h"

@interface HXAlertMaker ()

@property (nonatomic, copy) NSString *alertTitle;
@property (nonatomic, copy) NSString *alertMessage;
@property (nonatomic, copy) textFieldHandler textHandler;
@property (nonatomic, assign) UIAlertControllerStyle style;
@property (nonatomic, strong) NSMutableArray <UIAlertAction *>*actions;

@end

@implementation HXAlertMaker

- (instancetype)init
{
    self = [super init];
    if (self) {
        _style = UIAlertControllerStyleAlert;
    }
    return self;
}

- (HXAlertMaker *(^)(NSString *))title
{
    return ^(NSString *title) {
        self.alertTitle = title;
        return self;
    };
}

- (HXAlertMaker *(^)(NSString *))message
{
    return ^(NSString *message) {
        self.alertMessage = message;
        return self;
    };
}

- (HXAlertMaker *(^)(UIAlertControllerStyle))preferredStyle
{
    return ^(UIAlertControllerStyle style) {
        self.style = style;
        return self;
    };
}

- (HXAlertMaker *(^)(textFieldHandler))addTextField
{
    return ^(textFieldHandler handler) {
        self.textHandler = handler;
        return self;
    };
}

- (HXAlertMaker *(^)(NSString *, UIAlertActionStyle, alertActionHandler))action
{
    return ^(NSString *title, UIAlertActionStyle style, alertActionHandler handler) {
        UIAlertAction *actionX = [UIAlertAction actionWithTitle:title
                                                          style:style
                                                        handler:handler];
        [self.actions addObject:actionX];
        return self;
    };
}

- (UIAlertController *(^)(void))show
{
    return ^(void) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:self.alertTitle
                                                                       message:self.alertMessage
                                                                preferredStyle:self.style];
        [self.actions enumerateObjectsUsingBlock:^(UIAlertAction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [alert addAction:obj];
        }];
        if (self.textHandler) { [alert addTextFieldWithConfigurationHandler:self.textHandler];}
        [[self currentVisibleController] presentViewController:alert animated:YES completion:nil];
        return alert;
    };
}

- (UIViewController *)currentVisibleController
{
    return [self visibleControllerFromController:[UIApplication sharedApplication].delegate.window.rootViewController];
}

- (UIViewController *)visibleControllerFromController:(UIViewController *)controller
{
    if (!controller) { return nil;}
    UIViewController *presented = controller.presentedViewController;
    if (presented) { return [self visibleControllerFromController:presented];}
    if ([controller isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navi = (UINavigationController *)controller;
        if (!navi.viewControllers.count) { return navi;}
        return [self visibleControllerFromController:navi.topViewController];
    } else if ([controller isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tab = (UITabBarController *)controller;
        if (!tab.viewControllers.count) { return tab;}
        return [self visibleControllerFromController:tab.selectedViewController];
    } else {
        return controller;
    }
}

#pragma mark  lazy 

- (NSMutableArray<UIAlertAction *> *)actions
{
    if (!_actions) {
        _actions = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _actions;
}


@end
