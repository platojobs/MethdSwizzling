//
//  ViewController.m
//  MethdSwizzling
//
//  Created by yangwei cui on 2018/5/11.
//  Copyright © 2018年 David. All rights reserved.
//

#import "ViewController.h"
#import "David.h"
#import <objc/runtime.h>
#import "David+ExtentionDav.h"
@interface ViewController ()

@property(nonatomic,strong)David*david;

@property(nonatomic,strong)UIButton*chagevaBt;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.david=[[David alloc]init];
    self.david.en_Name=@"刘德华";
    self.david.cn_Name=@"LDH";
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark 修改类内变量
-(IBAction)changeVary:(UIButton*)sender{
    
    unsigned int count = 0;
    Ivar *ivar = class_copyIvarList([self.david class], &count);
    for (int i = 0; i<count; i++) {
        Ivar var = ivar[i];
        const char *varName = ivar_getName(var);
        NSString *name = [NSString stringWithUTF8String:varName];
        
        if ([name isEqualToString:@"_en_Name"]) {
            object_setIvar(self.david, var, @"周润发");
            break;
        }
    }
    NSLog(@" en_Name=%@",self.david.en_Name);
    
    [sender setTitle:self.david.en_Name forState:UIControlStateNormal];
}

#pragma mark==添加方法
-(IBAction)addMethod:(UIButton*)sender{
    
    class_addMethod([self.david class], @selector(guess), (IMP)guessAnswer, "v@:");
    if ([self.david respondsToSelector:@selector(guess)]) {
        //Method method = class_getInstanceMethod([self.xiaoMing class], @selector(guess));
        [self.david performSelector:@selector(guess)];
        
    } else{
        NSLog(@"Sorry,I don't know");
    }
    
     [sender setTitle:@"addMethod" forState:UIControlStateNormal];
    
    
}
 void guessAnswer(id self,SEL _cmd){
    
    NSLog(@"习近平");
    
}

#pragma mark==添加属性
-(IBAction)addExMethod:(UIButton*)sender{
    NSLog(@"My Chinese name is %@",self.david.cn_Name);
    [sender setTitle:self.david.cn_Name forState:UIControlStateNormal];
}

#pragma mark==交换方法
-(IBAction)exchangMethod:(UIButton*)sender{
    
    Method m1 = class_getInstanceMethod([self.david class], @selector(firN));
    Method m2 = class_getInstanceMethod([self.david class], @selector(secN));
    
    method_exchangeImplementations(m1, m2);
    NSString *secondName = [self.david firN];
    
    [sender setTitle:secondName forState:UIControlStateNormal];
    NSLog(@"David:My name is %@",secondName);
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
