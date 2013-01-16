//
//  MainLayer.h
//  Cocos2DSimpleGame
//
//  Created by thinksysuser on 14/12/12.
//  Copyright 2012 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import <UIKit/UIKit.h>

@interface MainLayer : CCLayerColor
{
    CCMenuItem *directLoginButton;
    CCMenuItem *facebookLoginButton;
    CCSprite *backgroundImage;
}
+(CCScene *)scene;
@end
