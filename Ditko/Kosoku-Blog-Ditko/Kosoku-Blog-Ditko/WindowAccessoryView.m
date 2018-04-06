//
//  WindowAccessoryView.m
//  Kosoku-Blog-Ditko
//
//  Created by William Towe on 4/6/18.
//  Copyright © 2018 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "WindowAccessoryView.h"
#import "Constants.h"

#import <Ditko/Ditko.h>
#import <Stanley/Stanley.h>

@interface WindowAccessoryView ()
@property (strong,nonatomic) KDILabel *label;
@end

@implementation WindowAccessoryView

- (instancetype)initWithFrame:(CGRect)frame {
    if (!(self = [super initWithFrame:frame]))
        return nil;
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.colors = @[KDIColorRandomHSB(),
                    KDIColorRandomHSB(),
                    KDIColorRandomHSB()];
    self.startPoint = CGPointMake(-1, 0);
    self.endPoint = CGPointMake(1, 0);
    
    self.label = [[KDILabel alloc] initWithFrame:CGRectZero];
    
    self.label.translatesAutoresizingMaskIntoConstraints = NO;
    self.label.backgroundColor = UIColor.whiteColor;
    self.label.font = [UIFont systemFontOfSize:13.0];
    self.label.textColor = UIColor.blackColor;
    self.label.text = @"This is super important";
    self.label.edgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    self.label.KDI_cornerRadius = kCornerRadius;
    self.label.layer.masksToBounds = YES;
    
    [self addSubview:self.label];
    
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize retval = [self.label sizeThatFits:CGSizeZero];
    
    retval.height += kSubviewMargin;
    retval.height += kSubviewMargin;
    
    return retval;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize labelSize = [self.label sizeThatFits:CGSizeZero];
    
    self.label.frame = KSTCGRectCenterInRectHorizontally(CGRectMake(0, CGRectGetHeight(self.bounds) - labelSize.height - kSubviewMargin, labelSize.width, labelSize.height), self.bounds);
}

@end
