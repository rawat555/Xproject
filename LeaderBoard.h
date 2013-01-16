//
//  LeaderBoard.h
//  Cocos2DSimpleGame
//
//  Created by thinksysuser on 13/12/12.
//  Copyright (c) 2012 Razeware LLC. All rights reserved.
//
#import <GameKit/GameKit.h>
#import <UIKit/UIKit.h>
#import "CCLayer.h"
#import "cocos2d.h"
#import "HelloWorldLayer.h"
#import "BackGroundLayer.h"
#import "WeaponInfo.h"
#import <sqlite3.h>


@interface LeaderBoard : CCScene
{
    UIButton * back;
    UIButton *listweapon;
    CCSprite *img;
    sqlite3 *db;
    NSString *databasePath;
    
}

@end
