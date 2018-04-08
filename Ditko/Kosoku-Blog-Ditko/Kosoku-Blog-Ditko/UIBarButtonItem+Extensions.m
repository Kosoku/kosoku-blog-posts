//
//  UIBarButtonItem+Extensions.m
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

#import "UIBarButtonItem+Extensions.h"
#import "Constants.h"
#import "WindowAccessoryView.h"

#import <KSOFontAwesomeExtensions/KSOFontAwesomeExtensions.h>
#import <Ditko/Ditko.h>
#import <Stanley/Stanley.h>

@implementation UIBarButtonItem (Extensions)

+ (UIBarButtonItem *)KSO_toggleWindowAccessoryBarButtonItem; {
    return [UIBarButtonItem KDI_barButtonItemWithImage:[UIImage KSO_fontAwesomeSolidImageWithString:@"\uf2d0" size:kBarButtonItemImageSize].KDI_templateImage style:UIBarButtonItemStylePlain block:^(__kindof UIBarButtonItem * _Nonnull barButtonItem) {
        KDIWindow *window = (KDIWindow *)UIApplication.sharedApplication.keyWindow;
        
        window.accessoryView = window.accessoryView == nil ? [[WindowAccessoryView alloc] initWithFrame:CGRectZero] : nil;
    }];
}
+ (UIBarButtonItem *)KSO_badgeButtonBarButtonItem; {
    KDIBadgeButton *badgeButton = [[KDIBadgeButton alloc] initWithFrame:CGRectZero];
    
    kstWeakify(badgeButton);
    void(^block)(void) = ^{
        kstStrongify(badgeButton);
        badgeButton.badgeView.badge = [NSNumberFormatter localizedStringFromNumber:@(arc4random_uniform(999)) numberStyle:NSNumberFormatterDecimalStyle];
    };
    
    badgeButton.translatesAutoresizingMaskIntoConstraints = NO;
    [badgeButton.button setImage:[UIImage KSO_fontAwesomeSolidImageWithString:@"\uf2b9" size:kBarButtonItemImageSize].KDI_templateImage forState:UIControlStateNormal];
    [badgeButton.button KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        block();
    } forControlEvents:UIControlEventTouchUpInside];
    
    block();
    
    return [[UIBarButtonItem alloc] initWithCustomView:badgeButton];
}

@end
