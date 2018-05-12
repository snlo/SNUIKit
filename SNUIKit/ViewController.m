//
//  ViewController.m
//  SNUIKit
//
//  Created by snlo on 2018/5/7.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "ViewController.h"

#import "SNUIKit.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//	pod trunk push SNUIKit.podspec --verbose --allow-warnings --use-libraries
	
    NSLog(@"%@",self.sn_navigationController);
    
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
