//
//  ViewController.m
//  DemoForGCD
//
//  Created by Goggles on 2022/5/27.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/// 同步执行并发队列
- (void)syncConcurrent{
    NSLog(@"currentThread----%@",[NSThread currentThread]);
    NSLog(@"syncConcurrent--begin");
    
    //创建并发队列
    dispatch_queue_t queue = dispatch_queue_create("testQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_sync(queue, ^{
        //模拟耗时操作
        [NSThread sleepForTimeInterval:2];
        NSLog(@"1----%@",[NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        //模拟耗时操作
        [NSThread sleepForTimeInterval:2];
        NSLog(@"2----%@",[NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        //模拟耗时操作
        [NSThread sleepForTimeInterval:2];
        NSLog(@"3----%@",[NSThread currentThread]);
    });
    
    NSLog(@"syncConcurrent---end");
    
    
}

/// 异步并发
- (void)asyncConcurrent{
    NSLog(@"currentThread===%@",[NSThread currentThread]);
    NSLog(@"asyncConcurrent--begin");
    
    //创建并发队列
    dispatch_queue_t queue = dispatch_queue_create("testQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        //模拟耗时操作
        [NSThread sleepForTimeInterval:2];
        NSLog(@"1----%@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        //模拟耗时操作
        [NSThread sleepForTimeInterval:2];
        NSLog(@"2----%@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        //模拟耗时操作
        [NSThread sleepForTimeInterval:2];
        NSLog(@"3----%@",[NSThread currentThread]);
    });
    
    NSLog(@"asyncConcurrent---end");

}


/// 同步串行
- (void)syncSerial{
    NSLog(@"currentThread===%@",[NSThread currentThread]);
    NSLog(@"syncSerial--begin");
    
    //创建并发队列
    dispatch_queue_t queue = dispatch_queue_create("testQueue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_sync(queue, ^{
        //模拟耗时操作
        [NSThread sleepForTimeInterval:2];
        NSLog(@"1----%@",[NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        //模拟耗时操作
        [NSThread sleepForTimeInterval:2];
        NSLog(@"2----%@",[NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        //模拟耗时操作
        [NSThread sleepForTimeInterval:2];
        NSLog(@"3----%@",[NSThread currentThread]);
    });
    
    NSLog(@"syncSerial---end");

}

/// 异步串行
- (void)asyncSerial{
    NSLog(@"currentThread===%@",[NSThread currentThread]);
    NSLog(@"asyncSerial--begin");
    
    //创建并发队列
    dispatch_queue_t queue = dispatch_queue_create("testQueue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
        //模拟耗时操作
        [NSThread sleepForTimeInterval:2];
        NSLog(@"1----%@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        //模拟耗时操作
        [NSThread sleepForTimeInterval:2];
        NSLog(@"2----%@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        //模拟耗时操作
        [NSThread sleepForTimeInterval:2];
        NSLog(@"3----%@",[NSThread currentThread]);
    });
    
    NSLog(@"asyncSerial---end");

}

/// 同步主队列
- (void)syncMain{
    NSLog(@"currentThread===%@",[NSThread currentThread]);
    NSLog(@"syncMain--begin");
    
    //获取主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_sync(queue, ^{
        //模拟耗时操作
        [NSThread sleepForTimeInterval:2];
        NSLog(@"1----%@",[NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        //模拟耗时操作
        [NSThread sleepForTimeInterval:2];
        NSLog(@"2----%@",[NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        //模拟耗时操作
        [NSThread sleepForTimeInterval:2];
        NSLog(@"3----%@",[NSThread currentThread]);
    });
    
    NSLog(@"syncMain---end");

}

/// 其他线程执行同步执行+主队列
- (void)test{
    [NSThread detachNewThreadSelector:@selector(syncMain) toTarget:self withObject:nil];
}

/// 异步执行+主队列
- (void)asyncMain{
    NSLog(@"currentThread===%@",[NSThread currentThread]);
    NSLog(@"asyncMain--begin");
    
    //获取主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_async(queue, ^{
        //模拟耗时操作
        [NSThread sleepForTimeInterval:2];
        NSLog(@"1----%@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        //模拟耗时操作
        [NSThread sleepForTimeInterval:2];
        NSLog(@"2----%@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        //模拟耗时操作
        [NSThread sleepForTimeInterval:2];
        NSLog(@"3----%@",[NSThread currentThread]);
    });
    
    NSLog(@"asyncMain---end");
}
@end
