//
//  UIViewController+ViewDidLoad.m
//  IMP
//
//  Created by yangwei cui on 2018/5/31.
//  Copyright © 2018年 David. All rights reserved.
//

#import "UIViewController+IMPViewDidLoad.h"
#import <objc/runtime.h>

typedef id (*_IMP)(id, SEL, ...);//有返回值的
typedef void (*_VIMP)(id, SEL, ...);//没有返回值
@implementation UIViewController (IMPViewDidLoad)

//需要把工程的BuidSettings里面的Enable Strict Checking of objec_msgSend Calls 改为NO
//引入runtime库也可以使用 @import ObjectiveC;
+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken
    , ^{
    //获取原始方法
    Method viewDidLoad=class_getInstanceMethod(self, @selector(viewDidLoad));
    //获取方法实现
    _VIMP viewDidLoad_IMP =(_VIMP)method_getImplementation(viewDidLoad);
    //重新设置方法实现
    method_setImplementation(viewDidLoad, imp_implementationWithBlock(^(id target ,SEL action){
      //调用原有的实现方法
      viewDidLoad_IMP(target,@selector(viewDidLoad));
      //新增打印实现部分
      NSLog(@"%@,哈哈，David,我加载完了",target);
    }));
    });
}
@end
