//
//  IHLargeImageViewController.h
//  iosHW2
//
//  Created by Claire Hsu on 2014/8/29.
//  Copyright (c) 2014年 livebricks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IHLargeImageViewController : UIViewController <UIGestureRecognizerDelegate>

@property (nonatomic, strong)UIImageView *largeImgView;
@property (nonatomic, strong)NSString *imgFilePath;

@end
