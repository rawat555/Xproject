//
//  MainLayer.m
//  Cocos2DSimpleGame
//
//  Created by thinksysuser on 14/12/12.
//  Copyright 2012 Razeware LLC. All rights reserved.
//

#import "MainLayer.h"
#import "DBViewLayer.h"
#import "FBViewController.h"


@implementation MainLayer

+(CCScene *)scene

{
    CCScene *scene  =[CCScene node];
    MainLayer *layer = [MainLayer node];
    [scene addChild:layer];
    
    return scene;
    
}

-(id)init{
   if (self = [super initWithColor:ccc4(255, 255, 255, 255)])
       
   {
       backgroundImage = [CCSprite spriteWithFile:@"Background.png"];
       backgroundImage.position = ccp(240,160);
       backgroundImage.opacity = 180;
       [self addChild:backgroundImage z:1];
       
       
       directLoginButton = [CCMenuItemImage itemWithNormalImage:@"directLoginButtonImage.png" selectedImage:@"directLoginButtonImage.png"
                                   target:self selector:@selector(doDirectLogin)];
       directLoginButton.position = ccp(-120,0);
       
       
       facebookLoginButton = [[CCMenuItem alloc]initWithTarget:self selector:@selector(doFacebookLogin)];
       facebookLoginButton = [CCMenuItemImage itemWithNormalImage:@"FaceBookButtonLogin.png" selectedImage:@"FaceBookButtonLogin.png"
                              target:self selector:@selector(doFacebookLogin)];
       facebookLoginButton.position = ccp(120,0);

       
       CCMenu *buttonMenu = [CCMenu menuWithItems:directLoginButton,facebookLoginButton, nil];       
       [self addChild:buttonMenu z:2];
       
   }
    
    return  self;
}

-(void)doDirectLogin
{
    directLoginButton.visible = NO;
    facebookLoginButton.visible = NO;
    
    [[CCDirector sharedDirector]replaceScene:[DBViewLayer node]];
}

-(void)doFacebookLogin
{
    backgroundImage.visible = NO;
    directLoginButton.visible = NO;
    facebookLoginButton.visible = NO;
    
    [[CCDirector sharedDirector]replaceScene:[FBViewController node]];
}



@end
