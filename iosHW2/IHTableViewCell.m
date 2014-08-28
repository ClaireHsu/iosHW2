//
//  IHTableViewCell.m
//  iosHW2
//
//  Created by Claire Hsu on 2014/8/25.
//  Copyright (c) 2014年 livebricks. All rights reserved.
//

#import "IHTableViewCell.h"
#import <UIKit/UILabel.h>

#define SYSTEM_VERSION_LESS_THAN(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)


@implementation IHTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        self.imgView = [[UIImageViewAligned alloc]initWithFrame:CGRectMake(0.0, 0.0, 100.0,100.0)];
        //self.imgView.backgroundColor = [UIColor greenColor];
        self.imgView.contentMode = UIViewContentModeScaleAspectFit;
        //self.imgView.clipsToBounds = YES;
        self.imgView.alignLeft = YES;
        
        [self.contentView addSubview:self.imgView];
        

        self.catDscLabel = [[VALabel alloc]initWithFrame:CGRectMake(120.0, 0.0, 180.0, 50.0)];
        //self.catDscLabel.backgroundColor = [UIColor grayColor];
     
        self.catDscLabel.adjustsFontSizeToFitWidth = YES;
      
        [self.catDscLabel setNumberOfLines:2];
        self.catDscLabel.verticalAlignment = VerticalAlignmentTop;
        
        [self.contentView addSubview:self.catDscLabel];
        
        
        self.nameLabel = [[VALabel alloc]initWithFrame:CGRectMake(120.0, 50.0, 180.0, 50.0)];
        //self.nameLabel.backgroundColor = [UIColor greenColor];
        
        self.nameLabel.adjustsFontSizeToFitWidth = YES;
        
        [self.nameLabel setNumberOfLines:2];
        self.nameLabel.verticalAlignment = VerticalAlignmentBottom;
        
        [self.contentView addSubview:self.nameLabel];
        
        if (SYSTEM_VERSION_LESS_THAN(@"7.0")) {
            self.catDscLabel.lineBreakMode = NSLineBreakByWordWrapping;
            self.nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
        }
        
    }
    
    return self;
}



- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setFrame:(CGRect)frame{

    [super setFrame:frame];
    
}

@end
