//
//  HelloWorldLayer.h
//  Cocos2DSimpleGame
//
//  Created by Ray Wenderlich on 11/13/12.
//  Copyright Razeware LLC 2012. All rights reserved.
//


#import <GameKit/GameKit.h>
#import <UIKit/UIKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Hublayer.h"
#import "LeaderBoard.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayerColor
{
    
    UIButton *btn;
    UIButton *btn2;
    UIButton *btn3;
    UIButton *btn4;
    UIButton *btn5;
    UIButton *btn1;
    CGPoint loc;
    CCParticleExplosion *explode;
    CCParticleExplosion *explode1;
    NSMutableArray * _monsters;
    NSMutableArray * _projectiles;  
    int _monstersDestroyed;
    CCSprite *player;
    CCSprite *bomb;
    CCTMXTiledMap *theMap;
    CCTMXLayer *bgLayer;
    int EnergyLevel;
    CCLabelTTF *lebelEnergy;
    CCSprite *first_Aid_Kit;               // FOR CREATING FIRST AID KIT IMAGE
    NSMutableArray *first_Aid_Kit_Array;   // FOR CREATING FIRST AID KIT ARRAY
   
}
-(void)gameLogic:(ccTime)dt;
// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;
-(void)updateEnergy:(int)el;
@end
