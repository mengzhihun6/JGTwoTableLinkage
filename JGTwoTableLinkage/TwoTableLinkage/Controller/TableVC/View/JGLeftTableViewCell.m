//
//  JGLeftTableViewCell.m
//  TwoTableLinkage
//
//  Created by stkcctv on 16/9/18.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import "JGLeftTableViewCell.h"

@interface JGLeftTableViewCell ()
@property (nonatomic, strong) UIView *redView;
@end

@implementation JGLeftTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 40)];
        self.name.numberOfLines = 0;
        self.name.font = [UIFont systemFontOfSize:15];
        self.name.textColor = JGRGBAColor(130, 130, 130, 1.0);
        self.name.highlightedTextColor = [UIColor redColor];
        [self.contentView addSubview:self.name];
        
        self.redView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, 5, 45)];
        self.redView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.redView];
    }
    
    
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
    
    self.contentView.backgroundColor = selected ? [UIColor whiteColor] : [UIColor colorWithWhite:0 alpha:0.1];
    self.highlighted = selected;
    self.name.highlighted = selected;
    self.redView.hidden = !selected;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



@end
