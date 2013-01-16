//
//  Hublayer.m
//  Cocos2DSimpleGame
//
//  Created by thinksysuser on 13/12/12.
//  Copyright (c) 2012 Razeware LLC. All rights reserved.
//

#import "Hublayer.h"

@implementation Hublayer

-(id)init
{
    self = [super init];
    if (self != nil)
    {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        lebelEnergy1 = [[CCLabelTTF labelWithString:@"." fontName:@"Arial" fontSize:32.0 dimensions:CGSizeMake(320, 50) hAlignment:UITextAlignmentRight]retain];
        
        
        lebelEnergy1.position = ccp(winSize.width/2,winSize.height-(lebelEnergy1.contentSize.height/2));
        
        
        [self addChild:lebelEnergy1];
    }
    return self;
}
@end
