//
//  TangLoginNaviCtrl.h
//  Tang
//
//  Created by wwwbbat on 2017/9/16.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "YGBaseNaviCtrl.h"

@interface TangLoginNaviCtrl : YGBaseNaviCtrl

@property (copy, nonatomic) void (^didLogined)(void);

@end
