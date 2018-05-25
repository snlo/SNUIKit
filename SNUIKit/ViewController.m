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
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *viewCenter;

@property (weak, nonatomic) IBOutlet UISlider *R;
@property (weak, nonatomic) IBOutlet UISlider *G;
@property (weak, nonatomic) IBOutlet UISlider *B;
@property (weak, nonatomic) IBOutlet UISlider *A;

@property (weak, nonatomic) IBOutlet UILabel *labelR;
@property (weak, nonatomic) IBOutlet UILabel *labelG;
@property (weak, nonatomic) IBOutlet UILabel *labelB;
@property (weak, nonatomic) IBOutlet UILabel *labelA;
@property (weak, nonatomic) IBOutlet UILabel *labelGr;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//	pod trunk push SNUIKit.podspec --verbose --allow-warnings --use-libraries
	
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] init];
    [self.view addGestureRecognizer:tap];
    
    @weakify(self);
    [tap.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        @strongify(self);
//        CGPoint point = [x locationInView:self.view];
//        self.sn_navigationBarColor = [self.view sn_colorOfPoint:CGPointMake(0, 0)];
    }];
    
    self.view.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"rrrrrr"].CGImage);
    self.sn_navigationBarColor = [UIColor whiteColor];
    
    
    
    
    
    
    
    
    
    
    
    [[self.R rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(__kindof UIControl * _Nullable x) {
        self.sn_navigationController.navigationBar.sn_overlay.backgroundColor = [UIColor colorWithRed:self.R.value/255.0f green:self.G.value/255.0f blue:self.B.value/255.0f alpha:self.A.value * 1.0f];
        self.labelR.text = SNString(@"R:%f",self.R.value);
    }];
    [[self.G rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(__kindof UIControl * _Nullable x) {
        self.sn_navigationController.navigationBar.sn_overlay.backgroundColor = [UIColor colorWithRed:self.R.value/255.0f green:self.G.value/255.0f blue:self.B.value/255.0f alpha:self.A.value * 1.0f];
        self.labelG.text = SNString(@"G:%f",self.G.value);
    }];
    [[self.B rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(__kindof UIControl * _Nullable x) {
        self.sn_navigationController.navigationBar.sn_overlay.backgroundColor = [UIColor colorWithRed:self.R.value/255.0f green:self.G.value/255.0f blue:self.B.value/255.0f alpha:self.A.value * 1.0f];
        self.labelB.text = SNString(@"B:%f",self.B.value);
    }];
    [[self.A rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(__kindof UIControl * _Nullable x) {
        self.sn_navigationController.navigationBar.sn_overlay.backgroundColor = [UIColor colorWithRed:self.R.value/255.0f green:self.G.value/255.0f blue:self.B.value/255.0f alpha:self.A.value * 1.0f];
        self.labelA.text = SNString(@"A:%f",self.A.value);
    }];

    
    
    
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    
    
    
    
    
}

- (IBAction)handleButton:(UIButton *)sender {
    
    if (sender.selected) {
        sender.selected = NO;
//        [self sn_setNavigationbarHidden:YES animationComeBack:YES];
        self.sn_navigationController.navigationBar.hidden = YES;
    } else {
        sender.selected = YES;
//        [self sn_setNavigationbarHidden:NO animationComeBack:NO];
        self.sn_navigationController.navigationBar.hidden = NO;
    }

    
    
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}




@end
