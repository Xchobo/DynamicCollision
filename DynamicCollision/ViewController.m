//
//  ViewController.m
//  DynamicCollision
//
//  Created by Xchobo on 2014/4/2.
//  Copyright (c) 2014年 Xchobo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
<UICollisionBehaviorDelegate>
{
    UIImageView *rabbit1;
    UIImageView *rabbit2;
    UIImageView *grass;
    
    UIDynamicAnimator *animator;
    UIGravityBehavior *gravity;
    UICollisionBehavior *collision;
}

@end

@implementation ViewController

- (void)collisionBehavior:(UICollisionBehavior *)behavior endedContactForItem:(id <UIDynamicItem>)item withBoundaryIdentifier:(id <NSCopying>)identifier {
    NSLog(@"collisionBehavior=%@", item);
    NSString *identifierStr = [NSString stringWithFormat:@"%@", identifier];
    NSLog(@"s=%@", identifier);
    if ( [identifierStr isEqualToString:@"sasa"] ) {
        [grass setBackgroundColor:[UIColor colorWithRed:0.519 green:0.643 blue:0.472 alpha:1.000]];
        [UIView animateWithDuration:0.2 animations:^(void){
            [grass setBackgroundColor:[UIColor colorWithRed:0.666 green:0.830 blue:0.610 alpha:1.000]];
        }];
    }
}

- (void)createRibbitImage1 {
    rabbit1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rabbit.png"]];
    [rabbit1 setFrame:CGRectMake(160, 100, 67, 104)];
    [self.view addSubview:rabbit1];
}
- (void)createRibbitImage2 {
    rabbit2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rabbit.png"]];
    [rabbit2 setFrame:CGRectMake(160, 100, 67, 104)];
    [self.view addSubview:rabbit2];
}
- (void)createGrassImage {
    grass = [[UIImageView alloc] init];
    [grass setBackgroundColor:[UIColor colorWithRed:0.666 green:0.830 blue:0.610 alpha:1.000]];
    [grass setFrame:CGRectMake(0, 388, 329, 180)];
    [self.view addSubview:grass];
}

//Behavior
-(void)gravityBehavior{
    [self createRibbitImage1];
    
    // 建立動力學物件
    animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    // 互動行為
    gravity = [[UIGravityBehavior alloc] initWithItems:@[rabbit1]];

    // 增加行為（啟動）
    [animator addBehavior:gravity];
}

-(void)collisionBehavior{
    // 建立圖片元件
    [self createRibbitImage2];
    [self createGrassImage];

    // 建立動力學物件
    animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    NSArray *objects = @[rabbit2, grass];
    
    // 互動行為
    gravity = [[UIGravityBehavior alloc] initWithItems:objects];
    
    // 碰撞偵測
    collision = [[UICollisionBehavior alloc] initWithItems:objects];
    [collision setTranslatesReferenceBoundsIntoBoundary:YES]; //反彈
    
    //設定代理器
    [collision setCollisionDelegate:self];
    // 設定一條觸碰的界線
    [collision addBoundaryWithIdentifier:@"sasa" fromPoint:CGPointMake(0, 388) toPoint:CGPointMake(320, 388)];
    
    //行為參數
    UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:objects];
    [itemBehavior setElasticity:0.5];
    
    // 增加行為（啟動）
    [animator addBehavior:gravity];
    [animator addBehavior:collision];
    [animator addBehavior:itemBehavior];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    [self gravityBehavior];
    [self collisionBehavior];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
