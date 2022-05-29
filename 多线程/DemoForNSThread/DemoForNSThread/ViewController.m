//
//  ViewController.m
//  DemoForNSThread
//
//  Created by Goggles on 2022/5/29.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong,readwrite)UIButton *button1;
@property (nonatomic,strong,readwrite)UIButton *button2;
@property (nonatomic,strong,readwrite)UIButton *button3;
@property (nonatomic,strong,readwrite)UIButton *button4;
@property (nonatomic,strong,readwrite)UIButton *button5;

@property (nonatomic,strong,readwrite)UIImageView *imageView;

@property (nonatomic,assign)NSUInteger ticketCount;
@property (nonatomic,strong)NSThread *ticketSaleWinodw1;
@property (nonatomic,strong)NSThread *ticketSaleWinodw2;


@end

@implementation ViewController

#pragma mark -
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.button1 = [[UIButton alloc] initWithFrame:CGRectMake(120, 100, self.view.frame.size.width/3, 40)];
    [self.button1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.button1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [self.button1 setTitle:@"先创建后使用" forState:UIControlStateNormal];
    [self.button1 addTarget:self action:@selector(test1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button1];
    
    self.button2 = [[UIButton alloc] initWithFrame:CGRectMake(120, 200, self.view.frame.size.width/3, 40)];
    [self.button2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.button2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [self.button2 setTitle:@"创建自动启动" forState:UIControlStateNormal];
    [self.button2 addTarget:self action:@selector(test2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button2];
    
    self.button3 = [[UIButton alloc] initWithFrame:CGRectMake(120, 300, self.view.frame.size.width/3, 40)];
    [self.button3 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.button3 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [self.button3 setTitle:@"下载网络图片" forState:UIControlStateNormal];
    [self.button3 addTarget:self action:@selector(downloadImgOnThread) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button3];
    
    self.button4 = [[UIButton alloc] initWithFrame:CGRectMake(120, 400, self.view.frame.size.width/3, 40)];
    [self.button4 setTitle:@"非线程安全" forState:UIControlStateNormal];
    [self.button4 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.button4 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [self.button4 addTarget:self action:@selector(noSafeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button4];
    
    self.button5 = [[UIButton alloc] initWithFrame:CGRectMake(120, 500, self.view.frame.size.width/3, 40)];
    [self.button5 setTitle:@"线程安全" forState:UIControlStateNormal];
    [self.button5 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.button5 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [self.button5 addTarget:self action:@selector(safeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button5];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 600, 200, 100)];
    self.imageView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.imageView];
}


#pragma mark - NSThread Create API

- (void)test1{
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    [thread start];
}

- (void)test2{
    [NSThread detachNewThreadSelector:@selector(run) toTarget:self withObject:nil];
}

- (void)test3{
    [NSThread performSelectorInBackground:@selector(run) withObject:nil];
}

- (void)run{
    [NSThread sleepForTimeInterval:2];
    NSLog(@"current thread----%@",[NSThread currentThread]);
}




#pragma mark - download image
- (void)downloadImgOnThread{
    [NSThread detachNewThreadSelector:@selector(downloadImg) toTarget:self withObject:nil];
}


- (void)downloadImg{
    NSLog(@"begin download----thread:%@",[NSThread currentThread]);
    
    NSURL *imgUrl = [NSURL URLWithString:@"https://pic.leetcode-cn.com/1646910868-wkWFEj-%E6%A6%82%E7%8E%87%E9%A2%98%E9%9D%A2%E8%AF%95%E7%AA%81%E5%87%BB.png?x-oss-process=image%2Fformat%2Cwebp"];
    
    NSData *imageData = [NSData dataWithContentsOfURL:imgUrl];
    
    UIImage *image = [UIImage imageWithData:imageData];
    
    [self performSelectorOnMainThread:@selector(refreshUI:) withObject:image waitUntilDone:YES];
}

- (void)refreshUI:(UIImage *)image{
    NSLog(@"update ui --- thread:%@",[NSThread currentThread]);
    
    self.imageView.image = image;
}


#pragma mark - 线程安全
- (void)noSafeClick{
    [self initTickerStatusNotSafe];
}

- (void)initTickerStatusNotSafe{
    self.ticketCount = 100;
    
    self.ticketSaleWinodw1 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicketNotSafe) object:nil];
    self.ticketSaleWinodw1.name = @"万能青年旅店";
    
    self.ticketSaleWinodw2 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicketNotSafe) object:nil];
    self.ticketSaleWinodw2.name = @"新裤子";
    
    [self.ticketSaleWinodw1 start];
    [self.ticketSaleWinodw2 start];
}

- (void)saleTicketNotSafe{
    while(1){
        if(self.ticketCount > 0){
            self.ticketCount --;
            NSLog(@"%@",[NSString stringWithFormat:@"剩余票数：%1lu 窗口：%@",(unsigned long)self.ticketCount,[NSThread currentThread].name]);
            [NSThread sleepForTimeInterval:0.2];
        }else{
            NSLog(@"sold out");
            break;
        }
    }
}

#pragma mark - 线程安全
- (void)safeClick{
    [self initTicketStatusSafe];
}

- (void)initTicketStatusSafe{
    self.ticketCount = 100;
    
    self.ticketSaleWinodw1 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicketSafe) object:nil];
    self.ticketSaleWinodw1.name = @"万能青年旅店";
    
    self.ticketSaleWinodw2 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicketSafe) object:nil];
    self.ticketSaleWinodw2.name = @"新裤子";
    
    [self.ticketSaleWinodw1 start];
    [self.ticketSaleWinodw2 start];
}

- (void)saleTicketSafe{
    while(1){
        @synchronized (self) {
            if(self.ticketCount > 0){
                self.ticketCount --;
                NSLog(@"%@",[NSString stringWithFormat:@"卖出：%@ 一张，剩余票：%d ",[NSThread currentThread].name,self.ticketCount]);
                [NSThread sleepForTimeInterval:0.2];
            
            }else{
                NSLog(@"sold out");
                break;
            }
        }
    }
}
@end
