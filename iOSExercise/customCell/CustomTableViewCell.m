//
//  CustomTableViewCell.m
//  iOSExercise
//
//  Created by Admin on 11/02/18.
//  Copyright © 2018 Admin. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell
@synthesize headingLbl,thumbImg,descriptionLbl;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        reuseID = reuseIdentifier;
        
        totalWidth = self.contentView.frame.size.width;
        totalheight = self.contentView.frame.size.height;
        
        headingLbl = [[UILabel alloc] init];
        thumbImg = [[UIImageView alloc] init];
        descriptionLbl = [[UILabel alloc] init];
        
        descriptionLbl.preferredMaxLayoutWidth = YES;
        descriptionLbl.lineBreakMode = UILineBreakModeWordWrap;
        
        descriptionLbl.numberOfLines = 0;
        thumbImg.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.contentView addSubview:headingLbl];
        [self.contentView addSubview:thumbImg];
        [self.contentView addSubview:descriptionLbl];
        [self.contentView setNeedsLayout];
    }
    return self;
}

-(void)setNeedsLayout{
    totalWidth = self.contentView.frame.size.width;
    totalheight = self.contentView.frame.size.height;
     [self.contentView layoutIfNeeded];
    headingLbl.frame = CGRectMake(5, 5, totalWidth-10, totalheight/3);
    thumbImg.frame = CGRectMake(headingLbl.frame.origin.x, headingLbl.frame.size.height+5, totalWidth/6, (totalheight-headingLbl.frame.size.height)-10);
    descriptionLbl.frame = CGRectMake(thumbImg.frame.size.width+15, thumbImg.frame.origin.y, (totalWidth-thumbImg.frame.size.width)-30, thumbImg.frame.size.height);
    //descriptionLbl.frame = CGRectMake(thumbImg.frame.size.width+15, thumbImg.frame.origin.y, (totalWidth-thumbImg.frame.size.width)-30, CGFLOAT_MAX);
}


@end
