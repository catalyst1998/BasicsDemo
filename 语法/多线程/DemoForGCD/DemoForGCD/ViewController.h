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


@end

