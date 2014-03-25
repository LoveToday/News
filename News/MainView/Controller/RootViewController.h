//
//  RootViewController.h
//  CeLaMen
//
//  Created by lanou3g on 14-3-6.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#define IS_WIDESCREEN ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
@interface RootViewController : UIViewController

@property (nonatomic, retain)RESideMenu * sideMenu;

@end
