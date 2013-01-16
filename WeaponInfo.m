//
//  WeaponInfo.m
//  Cocos2DSimpleGame
//
//  Created by thinksysuser on 14/12/12.
//  Copyright (c) 2012 Razeware LLC. All rights reserved.
//

#import <GameKit/GameKit.h>
#import <UIKit/UIKit.h>
#import "WeaponInfo.h"
#import "LeaderBoard.h"

@implementation WeaponInfo

- (id)init

    {if ((self = [super initWithColor:ccc4(255, 255, 255, 255)]))
    {
        
      
//        BackGroundLayer *backgroundlayer1 = [BackGroundLayer node];
//        [self addChild:backgroundlayer1 z:0];
        

        UIView* glView1 = (UIView*) [[CCDirector sharedDirector] view];
        backToleaderbord = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [backToleaderbord setFrame:CGRectMake(10,10,70, 30)];
        [backToleaderbord setTitle:@"<-" forState:normal];
        [backToleaderbord addTarget:self action:@selector(backToLeaderbordm:) forControlEvents:UIControlEventTouchUpInside];
        [backToleaderbord setAlpha:0.5];
        [glView1 addSubview:backToleaderbord];
        
           CGSize winSize = [[CCDirector sharedDirector] winSize];
      weaponInformationList = [[CCLabelTTF labelWithString:@"WEAPON INVENTORY" fontName:@"Arial" fontSize:25.0 dimensions:CGSizeMake(370, 50) hAlignment:UITextAlignmentCenter]retain];
      weaponInformationList.position = ccp(winSize.width/2,winSize.height-(weaponInformationList.contentSize.height/2));
        [ weaponInformationList setColor:ccBLACK];
        [self addChild:   weaponInformationList];

        
        
        weaponNameLabel= [[CCLabelTTF labelWithString:@"Weapon !" fontName:@"Arial" fontSize:15.0 dimensions:CGSizeMake(320, 50) hAlignment:UITextAlignmentCenter]retain];
          weaponNameLabel.position = ccp(150,250);
         [weaponNameLabel setColor:ccBLACK];
          [self addChild:weaponNameLabel];
        
        weaponID= [[CCLabelTTF labelWithString:@"WeaponID" fontName:@"Arial" fontSize:15.0 dimensions:CGSizeMake(320, 50) hAlignment:UITextAlignmentCenter]retain];
        weaponID.position = ccp(60,250);
         [ weaponID setColor:ccBLACK];
        [self addChild:weaponID];

        
        
        weaponRange= [[CCLabelTTF labelWithString:@"Range" fontName:@"Arial" fontSize:15.0 dimensions:CGSizeMake(320, 50) hAlignment:UITextAlignmentCenter]retain];
       weaponRange.position = ccp(230,250);
        
         [ weaponRange setColor:ccBLACK];
        [self addChild: weaponRange];
        
        
       weaponType= [[CCLabelTTF labelWithString:@"Type" fontName:@"Arial" fontSize:15.0 dimensions:CGSizeMake(320, 50) hAlignment:UITextAlignmentCenter]retain];
        weaponType.position = ccp(290,250);
        
         [ weaponType setColor:ccBLACK];
        [self addChild:  weaponType];
        
        
        ammunitionID= [[CCLabelTTF labelWithString:@"AmmuitionID" fontName:@"Arial" fontSize:15.0 dimensions:CGSizeMake(370, 50) hAlignment:UITextAlignmentCenter]retain];
        ammunitionID.position = ccp(400,250);
        [ ammunitionID setColor:ccBLACK];
        [self addChild:   ammunitionID];
        
        
        row1 = [[CCLabelTTF labelWithString:@"R&Blue001     KipatBarzel    5 KM    Defence Amu001" fontName:@"Arial" fontSize:15.0 dimensions:CGSizeMake(370, 50) hAlignment:UITextAlignmentCenter]retain];
        row1.position = ccp(210,240);
        [ ammunitionID setColor:ccBLACK];
        [self addChild:     row1];
        
        
        row2 = [[CCLabelTTF labelWithString:@"R&Blue002     ConnenBall    10 KM    Defence Amu002" fontName:@"Arial" fontSize:15.0 dimensions:CGSizeMake(370, 50) hAlignment:UITextAlignmentCenter]retain];
        row2.position = ccp(210,200);
        [   row2 setColor:ccBLACK];
        [self addChild:    row2];
        
        row3 = [[CCLabelTTF labelWithString:@"R&Blue003     superLaser    20 KM    Defence Amu003" fontName:@"Arial" fontSize:15.0 dimensions:CGSizeMake(370, 50) hAlignment:UITextAlignmentCenter]retain];
        row3.position = ccp(210,160);
        [   row3 setColor:ccBLACK];
        [self addChild:    row3];
        
        row4 = [[CCLabelTTF labelWithString:@"R&Blue004    DustPie    30 KM    Defence Amu004" fontName:@"Arial" fontSize:15.0 dimensions:CGSizeMake(370, 50) hAlignment:UITextAlignmentCenter]retain];
        row4.position = ccp(210,120);
        [   row4 setColor:ccBLACK];
        
        [self addChild:    row4];
        
        
        row5 = [[CCLabelTTF labelWithString:@"R&Blue005     3Shoot    50 KM    Defence   Amu005" fontName:@"Arial" fontSize:15.0 dimensions:CGSizeMake(370, 50) hAlignment:UITextAlignmentCenter]retain];
        row5.position = ccp(210,80);
        [   row5 setColor:ccBLACK];
        [self addChild:    row5];
        
        
      
        
      

        }
    return self;

}

-(void) backToLeaderbordm:(id) sender
{
    
    backToleaderbord.hidden = YES;
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInT transitionWithDuration:1 scene:[LeaderBoard node]]];
    
}



@end
