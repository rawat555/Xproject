//
//  LeaderBoard.m
//  Cocos2DSimpleGame
//
//  Created by thinksysuser on 13/12/12.
//  Copyright (c) 2012 Razeware LLC. All rights reserved.
//
#import <GameKit/GameKit.h>
#import <UIKit/UIKit.h>
#import "LeaderBoard.h"
#import "cocos2d.h"
#import "BackGroundLayer.h"
#import "HelloWorldLayer.h"
#import "WeaponInfo.h"
#import <sqlite3.h>

@implementation LeaderBoard

- (id)init
{
    if ((self = [super init]))
    {
        
        UIView* glView = (UIView*) [[CCDirector sharedDirector] view];
        back = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [back setFrame:CGRectMake(20,30,40, 30)];
        [back setTitle:@"<-" forState:normal];
        [back addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
        [back setAlpha:0.5];
        [glView addSubview:back];
        
        UIView* glView1 = (UIView*) [[CCDirector sharedDirector] view];
        listweapon = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [listweapon setFrame:CGRectMake(20,70,70, 30)];
        [listweapon setTitle:@"weapon" forState:normal];
        [listweapon addTarget:self action:@selector(weaponInfo:) forControlEvents:UIControlEventTouchUpInside];
        [listweapon setAlpha:0.5];
        [glView1 addSubview:listweapon];

        
        BackGroundLayer *backgroundlayer = [BackGroundLayer node];
        [self addChild:backgroundlayer z:0];
   
    }
    return self;
}

-(void) Back:(id) sender
{
    
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFlipX transitionWithDuration:1 scene:[HelloWorldLayer node]]];
    
}


-(void) weaponInfo:(id) sender
{
    back.hidden = YES;
    listweapon.hidden = YES;
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInB transitionWithDuration:1 scene:[WeaponInfo node]]];
    
}


@end
