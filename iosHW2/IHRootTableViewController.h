//
//  IHRootTableViewController.h
//  iosHW2
//
//  Created by Claire Hsu on 2014/8/26.
//  Copyright (c) 2014年 livebricks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IHRootTableViewController : UITableViewController{
   UIActivityIndicatorView *indicatorView;
   NSDictionary *jsonDataAll;
   NSArray *itemsArr;
   NSMutableArray *imgPaths;
}

@end
