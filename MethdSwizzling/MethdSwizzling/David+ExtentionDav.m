//
//  David+ExtentionDav.m
//  MethdSwizzling
//
//  Created by MOON FLOWER on 2018/10/30.
//  Copyright © 2018 David. All rights reserved.
//

#import "David+ExtentionDav.h"


@implementation David (ExtentionDav)


char cname;

-(void)setCn_Name:(NSString *)cn_Name{
    
    objc_setAssociatedObject(self, &cname, cn_Name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString*)cn_Name{
    return objc_getAssociatedObject(self, &cname);
}

@end
