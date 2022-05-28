//
//  ViewController.m
//  DemoFor LazyLoad
//
//  Created by Goggles on 2022/5/11.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong) UIButton *button;
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) NSMutableArray *array;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.button.enabled = YES;
}
/*
 lazy load
 */
- (UILabel *)label{
    if(!_label){
        _label = [[UILabel alloc] initWithFrame:CGRectMake(50, 130, 60, 30)];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.backgroundColor = [UIColor blackColor];
        [self.view addSubview:_label];
    }
    return _label;
}

- (UIButton *)button{
    if(!_button){
        _button = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 100, 40)];
        _button.backgroundColor = [UIColor blueColor];
        [_button setTitle:@"confirm" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:_button];
    }
    return _button;
}

- (NSMutableArray *)array{
    if(!_array){
        _array = [[NSMutableArray alloc] initWithObjects:@"bbb",@"gdgsd",@"ios", nil];
        
    }
    return _array;
}

-(void)clickButton{
    self.label.text = [NSString stringWithFormat:@"%@",self.array[0]];
    
}
@end
