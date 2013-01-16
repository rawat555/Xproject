//
//  WeaponInfo.h
//  Cocos2DSimpleGame
//
//  Created by thinksysuser on 14/12/12.
//  Copyright (c) 2012 Razeware LLC. All rights reserved.
//
#import <GameKit/GameKit.h>
#import <UIKit/UIKit.h>
#import "CCScene.h"
#import "cocos2d.h"
#import "LeaderBoard.h"


@interface WeaponInfo : CCLayerColor

{
    CCLabelTTF *weaponNameLabel;
    CCLabelTTF *weaponID;
    CCLabelTTF *weaponRange;
    CCLabelTTF *weaponType;
    CCLabelTTF *ammunitionID;
    UIButton *backToleaderbord;
      CCLabelTTF *weaponInformationList;
        CCLabelTTF *row1;
        CCLabelTTF *row2;
        CCLabelTTF *row3;
        CCLabelTTF *row4;
        CCLabelTTF *row5;
  
    
    
}

@end
