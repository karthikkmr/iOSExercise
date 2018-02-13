//
//  CustomTableViewCell.h
//  iOSExercise
//
//  Created by Admin on 11/02/18.
//  Copyright © 2018 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

//static NSString * const kCellIDTitle = @"CellWithTitle";
static NSString * const kCellIDTitleMain = @"MyIdentifier";

@interface CustomTableViewCell : UITableViewCell{
    NSString *reuseID;
    float totalWidth;
    float totalheight;
}

@property (nonatomic, strong) UILabel *headingLbl;
@property (nonatomic, strong) UIImageView *thumbImg;
@property (nonatomic, strong) UILabel *descriptionLbl;

@end
