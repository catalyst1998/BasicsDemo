//
//  ViewController.m
//  DemoForGCD
//
//  Created by Goggles on 2022/5/27.
//

#import "ViewController.h"

@interface ViewController ()

@end

/// <#Description#>
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
        [self once];
    });
    
    dispatch_async(queue, ^{
        //模拟耗时操作
        [NSThread sleepForTimeInterval:2];
        NSLog(@"2----%@",[NSThread currentThread]);
        [self once];
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


- (void)communication{
    //获取全局队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //获取主队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    //异步执行耗时操作
    dispatch_async(queue, ^{
        //耗时操作
        [NSThread sleepForTimeInterval:2];
        NSLog(@"1---%@",[NSThread currentThread]);
        
        //回到主线程
        dispatch_async(mainQueue, ^{
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2--%@",[NSThread currentThread]);
        });
    });
}

- (void)changePriority{
    //创建串行队列
    dispatch_queue_t queue = dispatch_queue_create("test", nil);
    
    //想改成后台优先级
    dispatch_queue_t targetQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    
    //更改优先级
    dispatch_set_target_queue(queue, targetQueue);
}


- (void)after{
    NSLog(@"currentThread===%@",[NSThread currentThread]);
    NSLog(@"after--begin");
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0*NSEC_PER_SEC)), dispatch_get_main_queue(),^{
        NSLog(@"after--%@",[NSThread currentThread]);
    });
}


/// dispatch_once
- (void)once{
    
//    static BOOL flags = NO;
//    if(flags == NO){
//        NSLog(@"initialize1---%@",[NSThread currentThread]);
//        flags == YES;
//    }
    
    
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        NSLog(@"initialize2---%@",[NSThread currentThread]);
    });
}

- (void)group{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"block1----%@",[NSThread currentThread]);
    });
    
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"block2----%@",[NSThread currentThread]);
    });
    
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"block3----%@",[NSThread currentThread]);
    });
    
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//        NSLog(@"done----%@",[NSThread currentThread]);
//    });
    dispatch_group_wait(group,DISPATCH_TIME_FOREVER);
    
    NSLog(@"111");
    
//    dispatch_release(group);
}

- (void)barrier{
    dispatch_queue_t queue = dispatch_queue_create("testQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"1---%@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"2---%@",[NSThread currentThread]);
    });
    
    dispatch_barrier_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"barrier---%@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"3---%@",[NSThread currentThread]);
    });
    
  
}

- (void)apply{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    NSLog(@"apply--begin");
    dispatch_apply(6, queue, ^(size_t iteration) {
        NSLog(@"%zd --- %@",iteration,[NSThread currentThread]);
    });
    NSLog(@"apply--end");
}


- (void)testDataConflict{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for(int i=0; i<100;i++){
        dispatch_async(queue, ^{
            [array addObject:[NSNumber numberWithInt:i]];
        });
    }
    
}


- (void)semaphoreSync{
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"semaphore---begin");

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

    __block int number = 0;
    dispatch_async(queue, ^{
        // 追加任务 1
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        
        number = 100;
        
        dispatch_semaphore_signal(semaphore);
    });

    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"semaphore---end,number = %zd",number);
}

- (void)semaphore{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    for(int i=0; i<100;i++){
        dispatch_async(queue, ^{
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            [array addObject:[NSNumber numberWithInt:i]];
            NSLog(@"add");
            dispatch_semaphore_signal(semaphore);
        });
    }
}
@end
