# MethdSwizzling
runtime的应用

```objective-c

+(void)load{
    //保证交换方法只执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //获取这个类的viewDidLoad方法，它的类型是一个object_method结构体的指针
        Method viewDidLoad = class_getInstanceMethod(self, @selector(viewDidLoad));
        //获取到自己新建的一个方法
        Method customViewDidLoad = class_getInstanceMethod(self, @selector(customViewDidLoad));
        //交换方法
        method_exchangeImplementations(viewDidLoad, customViewDidLoad);
    });  
}
//新建一个方法
-(void)customViewDidLoad{
    //调用自己原有的方法
    [self customViewDidLoad];
    NSLog(@"%@ did load",self);
}



```
