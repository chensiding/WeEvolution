//
//  SDTabBarController.h
//  SDTabBarController
//
//  Created by chensiding on 15/1/27.
//  Copyright (c) 2015年 siding. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDTabBarController : UITabBarController

@property (strong, nonatomic) NSArray *iconNameList;
@property (nonatomic) NSInteger highlightedTabBarItem;

@end
