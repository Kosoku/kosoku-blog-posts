//
//  ViewController.m
//  Kosoku-Blog-Ditko
//
//  Created by William Towe on 3/16/18.
//  Copyright © 2018 Kosoku Interactive, LLC. All rights reserved.
//

#import "ViewController.h"

#import <Ditko/Ditko.h>

@interface ViewController ()
@property (weak,nonatomic) IBOutlet KDIView *borderView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.borderView.backgroundColor = KDIColorW(0.95);
    
    self.borderView.borderOptions = KDIBorderOptionsTopAndBottom;
    self.borderView.borderWidth = 4.0;
    self.borderView.borderColor = KDIColorRandomRGB();
}

@end
