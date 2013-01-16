//
//  BackGroundLayer.m
//  Cocos2DSimpleGame
//
//  Created by thinksysuser on 14/12/12.
//  Copyright (c) 2012 Razeware LLC. All rights reserved.
//

#import "BackGroundLayer.h"
#import "cocos2d.h"

@implementation BackGroundLayer

-(id)init
{
    self = [super init];
    if(self != nil)
    {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        CCSprite *bacgroundImage = [CCSprite spriteWithFile:@"Background.jpeg"];
        [bacgroundImage setPosition:CGPointMake(winSize.width/2, winSize.height/2)];
        [self addChild:bacgroundImage z:0 tag:0];
        
    }
    return self;
}

@end
