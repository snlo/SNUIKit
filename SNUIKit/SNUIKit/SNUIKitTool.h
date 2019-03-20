//
//  SNUIKitTool.h
//  SNUIKit
//
//  Created by snlo on 2018/5/7.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Masonry/Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <Aspects/Aspects.h>

#import <SNTool/SNTool.h>

singletonInterface(SNUIKitTool)

void SNUIKitTool_replaceMethodFromNew(Class aClass, SEL aMethod, SEL newMethod);

@end
