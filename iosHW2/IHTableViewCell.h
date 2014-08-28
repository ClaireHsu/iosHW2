//
//  IHTableViewCell.h
//  iosHW2
//
//  Created by Claire Hsu on 2014/8/25.
//  Copyright (c) 2014年 livebricks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageViewAligned.h"
#import "VALabel.h"

@interface IHTableViewCell : UITableViewCell{
   
  
}

//@property (nonatomic, strong)UIImageView *imgView;
@property (nonatomic, strong)UIImageViewAligned *imgView;
//@property (nonatomic, strong)UILabel *catDscLabel;
@property (nonatomic, strong)VALabel *catDscLabel;
@property (nonatomic, strong)VALabel *nameLabel;



@end
