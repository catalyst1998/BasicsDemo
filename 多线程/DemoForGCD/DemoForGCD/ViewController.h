//
//  ViewController.h
//  DemoForGCD
//
//  Created by Goggles on 2022/5/27.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (void)syncConcurrent;
- (void)asyncConcurrent;
- (void)syncSerial;
- (void)asyncSerial;
- (void)syncMain;
- (void)test;
- (void)asyncMain;
- (void)communication;
- (void)changePriority;
- (void)after;
- (void)group;
- (void)barrier;
- (void)apply;
- (void)testDataConflict;
- (void)semaphoreSync;

- (void)semaphore;


@end

