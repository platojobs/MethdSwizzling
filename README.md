# MethdSwizzling
runtime的应用

### 解释
```
1.选择器（typedef struct objc_selector *SEL）：选择器用于表示一个方法在运行时的名字，一个方法的选择器是一个注册到（或映射到）Objective-C运行时中的C字符串，它是由编译器生成并在类加载的时候被运行时系统自动映射。
 
2.方法（typedef struct objc_method *Method）：一个代表类定义中一个方法的不明类型。
 
3.实现（typedef id (*IMP)(id, SEL, ...)）：这种数据类型是实现某个方法的函数开始位置的指针，函数使用的是基于当前CPU架构的标准C调用规约。第一个参数是指向self的指针（也就是该类的某个实例的内存空间，或者对于类方法来说，是指向元类（metaclass）的指针）。第二个参数是方法的选择器，后面跟的都是参数。
 
理解这些概念之间关系最好的方式是：一个类（Class）维护一张调度表（dispatch table）用于解析运行时发送的消息；调度表中的每个实体（entry）都是一个方法（Method），其中key值是一个唯一的名字——选择器（SEL），它对应到一个实现（IMP）——实际上就是指向标准C函数的指针。
 
Method Swizzling就是改变类的调度表让消息解析时从一个选择器对应到另外一个的实现，同时将原始的方法实现混淆到一个新的选择器。

```

---------
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
