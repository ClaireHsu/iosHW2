//
//  IHLargeImageViewController.m
//  iosHW2
//
//  Created by Claire Hsu on 2014/8/29.
//  Copyright (c) 2014年 livebricks. All rights reserved.
//

#import "IHLargeImageViewController.h"

@interface IHLargeImageViewController ()

@end

@implementation IHLargeImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.largeImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    //self.largeImgView.backgroundColor = [UIColor grayColor];
    self.largeImgView.image = [UIImage imageWithContentsOfFile:self.imgFilePath];
    self.largeImgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.largeImgView];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImg:)];
    [self.largeImgView addGestureRecognizer:tapRecognizer];
    self.largeImgView.userInteractionEnabled = YES;
    
    
}

#pragma mark - Gresure delegate
-(void)clickImg:(UITapGestureRecognizer *)gesture{
    self.navigationController.navigationBarHidden = NO;


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
