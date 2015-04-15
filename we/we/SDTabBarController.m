//
//  SDTabBarController.m
//  SDTabBarController
//
//  Created by chensiding on 15/1/27.
//  Copyright (c) 2015年 siding. All rights reserved.
//

#import "SDTabBarController.h"

@interface SDTabBarController ()

@property (strong, nonatomic) NSMutableArray *tabBarItemViews;
@property (strong, nonatomic) NSMutableArray *tabBarIconImageViews;

@end

@implementation SDTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.iconNameList = @[@"Orgnization", @"People", @"Chat", @"Connection", @"More"];
    self.highlightedTabBarItem = -1;
    
    [self hideOriginalTabBar];
    [self showCustomTabBar];
}

- (void)hideOriginalTabBar
{
    for (id view in self.view.subviews) {
        if([view  isKindOfClass:[UITabBar class]]){
            [view setHidden:YES];
            break;
        }
    }
}

- (void)showCustomTabBar
{
    if([self.iconNameList count] == 0){
        return ;
    }
    
    self.tabBarItemViews = [[NSMutableArray alloc]init];
    self.tabBarIconImageViews = [[NSMutableArray alloc]init];
    
    static NSInteger MAX_ITEM_COUNT = 5;
    
    NSInteger itemCount = MIN(MAX_ITEM_COUNT, [self.iconNameList count]);
    
    CGFloat tabBarItemWidth = [UIScreen mainScreen].bounds.size.width / itemCount;
    CGFloat tabBarItemHeight = 60.0;
    CGFloat tabBarIconWidth = tabBarItemWidth * 0.3;
    CGFloat tabBarIconHeight = tabBarItemWidth * 0.3;
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1];
    view.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 60, [UIScreen mainScreen].bounds.size.width, 60);

    
    for (int i=0;i<itemCount;i++) {
        UIView *tabBarItem = [[UIView alloc]initWithFrame:CGRectMake(i*tabBarItemWidth, 0, tabBarItemWidth, tabBarItemHeight)];
        
        tabBarItem.backgroundColor = [UIColor clearColor];
        
        UIImage *iconImage = [[UIImage imageNamed:self.iconNameList[i]]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                              
        UIImageView *tabBarIcon = [[UIImageView alloc]initWithImage:iconImage];
        tabBarIcon.contentMode = UIViewContentModeScaleAspectFit;
        
        [tabBarIcon setFrame:CGRectMake((tabBarItemWidth - tabBarIconWidth)/2, (tabBarItemHeight - tabBarIconHeight)/2, tabBarIconWidth, tabBarIconHeight)];
        
        [tabBarItem addSubview:tabBarIcon];
        
        tabBarItem.tag = i;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTabBarItem:)];
        [tabBarItem addGestureRecognizer:tap];
        
        [self.tabBarItemViews addObject:tabBarItem];
        [self.tabBarIconImageViews addObject:tabBarIcon];
        
        [view addSubview:tabBarItem];
    }
    
    view.tintColor = [UIColor colorWithRed:190/255.0 green:190/255.0 blue:190/255.0 alpha:1];
    
    [self p_setHighlightedTabBarItem:self.highlightedTabBarItem animated:NO];
    
    [self.view addSubview:view];
}

-(void)tapTabBarItem:(UITapGestureRecognizer *)gesture
{
    if(self.selectedIndex != gesture.view.tag &&
       self.highlightedTabBarItem != gesture.view.tag){
        [self p_unSelectTabBarItem:self.selectedIndex animated:YES];
        [self setSelectedIndex:gesture.view.tag];
        [self p_selectTabBarItem:self.selectedIndex animated:YES];
    }
}

-(void) p_selectTabBarItem:(NSInteger)selectedIndex animated:(bool)animated
{
    if(selectedIndex != self.highlightedTabBarItem &&
       selectedIndex < [self.tabBarItemViews count] &&
       selectedIndex < [self.tabBarIconImageViews count]){
        UIView *tabBarItem = [self.tabBarItemViews objectAtIndex:selectedIndex];
        UIImageView *tabBarIcon = [self.tabBarIconImageViews objectAtIndex:selectedIndex];
        
        if(animated){
            
            tabBarItem.backgroundColor = [UIColor colorWithRed:46/255.0 green:46/255.0 blue:46/255.0 alpha:1];
            [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.05
                  initialSpringVelocity:0.6 options:UIViewAnimationOptionCurveEaseIn  animations:^{
                      tabBarIcon.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);;
                      tabBarItem.tintColor = [UIColor whiteColor];
                      
            } completion:^(BOOL finished) {
                
            }];
            
        }
        else{
            
            tabBarItem.backgroundColor = [UIColor colorWithRed:46/255.0 green:46/255.0 blue:46/255.0 alpha:1];
            tabBarIcon.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.3, 1.3);;
            tabBarItem.tintColor = [UIColor whiteColor];
        }
    }
}

-(void) p_unSelectTabBarItem:(NSInteger)selectedIndex animated:(bool)animated
{
    if(selectedIndex != self.highlightedTabBarItem &&
       selectedIndex < [self.tabBarItemViews count] &&
       selectedIndex < [self.tabBarIconImageViews count]){
        UIView *tabBarItem = [self.tabBarItemViews objectAtIndex:selectedIndex];
        UIImageView *tabBarIcon = [self.tabBarIconImageViews objectAtIndex:selectedIndex];
        
        if(animated){
            
            tabBarItem.backgroundColor = [UIColor clearColor];
            [UIView animateWithDuration:0.2 animations:^{
                tabBarIcon.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
                tabBarItem.tintColor = [UIColor colorWithRed:190/255.0 green:190/255.0 blue:190/255.0 alpha:1];
                
            }];
        }
        else{
            tabBarIcon.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);;
            tabBarItem.tintColor = [UIColor colorWithRed:190/255.0 green:190/255.0 blue:190/255.0 alpha:1];
            
            tabBarItem.backgroundColor = [UIColor clearColor];
        }
    }
}

-(void) p_setHighlightedTabBarItem:(NSInteger)highlightedItem animated:(bool)animated
{
    if(highlightedItem < [self.tabBarItemViews count] &&
       highlightedItem < [self.tabBarIconImageViews count]){
        UIView *tabBarItem = [self.tabBarItemViews objectAtIndex:highlightedItem];
        UIImageView *tabBarIcon = [self.tabBarIconImageViews objectAtIndex:highlightedItem];
        
        tabBarItem.backgroundColor = [UIColor colorWithRed:46/255.0 green:46/255.0 blue:46/255.0 alpha:1];
        tabBarItem.tintColor = [UIColor whiteColor];
        tabBarIcon.transform = CGAffineTransformMakeScale(1.5, 1.5);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self p_selectTabBarItem:self.selectedIndex animated:NO];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
