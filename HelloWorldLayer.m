#import "HelloWorldLayer.h"
#import "SimpleAudioEngine.h"
//#import "GameOverLayer.h"
#import "IntroLayer.h"
#import "AppDelegate.h"
#import "Hublayer.h"
#import "Weapon.h"
#import "LeaderBoard.h"


@implementation HelloWorldLayer

+(CCScene *) scene
{
    CCScene *scene = [CCScene node];
    HelloWorldLayer *layer = [HelloWorldLayer node];
    [scene addChild: layer];
    
    return scene;
}

- (void) addMonster {
    
    CCSprite * monster = [CCSprite spriteWithFile:@"monster.png"];
    
    // Determine where to spawn the monster along the Y axis
    CGSize winSize = [CCDirector sharedDirector].winSize;
    int minY = monster.contentSize.height / 2;
    int maxY = winSize.height - monster.contentSize.height/2;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    
    // Create the monster slightly off-screen along the right edge,
    // and along a random position along the Y axis as calculated above
    monster.position = ccp(winSize.width + monster.contentSize.width/2, actualY);
    [self addChild:monster];
    
    // Determine speed of the monster
    int minDuration = 5;
    int maxDuration = 10.0;
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    // Create the actions
    CCMoveTo * actionMove = [CCMoveTo actionWithDuration:actualDuration position:ccp(-monster.contentSize.width/2, actualY)];
    CCCallBlockN * actionMoveDone = [CCCallBlockN actionWithBlock:^(CCNode *node) {
        [_monsters removeObject:node];
        [node removeFromParentAndCleanup:YES];
        
       // CCScene *gameOverScene = [GameOverLayer sceneWithWon:NO];
        //[[CCDirector sharedDirector] replaceScene:gameOverScene];
    }];
    [monster runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
    
    monster.tag = 1;
    [_monsters addObject:monster];
    
}

-(void)gameLogic:(ccTime)dt {
    [self addMonster];
}

- (id)init
{
    if ((self = [super init]))
    {

        Hublayer *hb = [Hublayer node];
        [self addChild:hb z:5];
        [[CCDirector sharedDirector] view];
        
        
        theMap = [CCTMXTiledMap tiledMapWithTMXFile:@"tanks.tmx"];
        
        [self addChild:theMap] ;
        
        bgLayer = [theMap layerNamed:@"Background"];
        player = [CCSprite spriteWithFile:@"3.png"];
        player.position = ccp(50,50);
        [self addChild:player z:4 ];
        
        Weapon *wp = [[Weapon alloc]init];
        [wp display];
        
        UIView* glView = (UIView*) [[CCDirector sharedDirector] view];
        btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn setFrame:CGRectMake(20,30,40, 30)];
        [btn addTarget:self action:@selector(moveBack:) forControlEvents:UIControlEventTouchUpInside];
        [btn setAlpha:0.5];
        [glView addSubview:btn];
    
        
        UIView *glView1 = (UIView*)[[CCDirector sharedDirector]view];
        btn1  =  [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn1 setFrame:CGRectMake(93,30,40,30)];
        [btn1 addTarget:self action:@selector(moveForward:) forControlEvents:UIControlEventTouchUpInside];
         [btn1 setAlpha:0.5];
        [glView1 addSubview:btn1];
        
        UIView* glView2 = (UIView*)[[CCDirector sharedDirector] view];
        btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn2 setFrame:CGRectMake(60,70,40, 30)];
        [btn2 addTarget:self action:@selector(moveDown:) forControlEvents:UIControlEventTouchUpInside];
         [btn2 setAlpha:0.5];
        [glView2 addSubview:btn2];
        
        UIView* glView3 = (UIView*)[[CCDirector sharedDirector] view];
        btn3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn3 setFrame:CGRectMake(58,2,40, 30)];
        [btn3 addTarget:self action:@selector(moveUP:) forControlEvents:UIControlEventTouchUpInside];
         [btn3 setAlpha:0.5];
        [glView3 addSubview:btn3];
        
        UIView* glView4 = (UIView*)[[CCDirector sharedDirector] view];
        btn4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn4 setFrame:CGRectMake(150,30,40,30)];
        [btn4 setTitle:@"weapon" forState:normal];
        [btn4 addTarget:self action:@selector(throwBomb:) forControlEvents:UIControlEventTouchUpInside];
         [btn4 setAlpha:0.5];
        [glView4 addSubview:btn4];
        
        UIView* glView5= (UIView*)[[CCDirector sharedDirector] view];
        btn5 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn5 setFrame:CGRectMake(200,30,40,30)];
        [btn5 setTitle:@"<-" forState:normal];
        [btn5 addTarget:self action:@selector(changeScene:) forControlEvents:UIControlEventTouchUpInside];
         [btn setAlpha:0.5];
        [glView5 addSubview:btn5];
      
        
        first_Aid_Kit_Array = [[NSMutableArray alloc]init]; // ALLOCATING MEMORY TO FAK ARRAY
       
        [self schedule:@selector(gameLogic:) interval:1.0];
        
        [self schedule:@selector(updateFirstAidKit) interval:5.0]; //CALLING

        [self setTouchEnabled:YES];
         EnergyLevel = 0;
        _monsters = [[NSMutableArray alloc] init];
        _projectiles = [[NSMutableArray alloc] init];

        [self schedule:@selector(update:)];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"background-music-aac.caf"];
        
    }
    return self;
}

-(void) changeScene : (id) sender
{
     btn.hidden = YES;
     btn1.hidden = YES;
     btn2.hidden = YES;
     btn3.hidden = YES;
     btn4.hidden = YES;
     btn5.hidden = YES;
    
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFlipX transitionWithDuration:1 scene:[LeaderBoard node]]];
    
}

-(void)explosion
{
    explode = [[CCParticleExplosion alloc] initWithTotalParticles:10];
    explode.texture = [[CCTextureCache sharedTextureCache] addImage:@"projectile-hd.png"];
    [self addChild: explode];
    explode.position = ccp(loc.x,loc.y);
}
-(void)explosion1
{
    explode1 = [[CCParticleExplosion alloc] initWithTotalParticles:250];
    explode1.texture = [[CCTextureCache sharedTextureCache] addImage:@"Fire1.png"];
   // explode1.duration = -1;
   // explode1.radialAccel = -50;
    explode1.radialAccelVar = 5;
  //  explode1.life = 1;
   // explode1.lifeVar = 1;
    explode1.speed = 160;
    explode1.speedVar = 20;

    [self addChild: explode1];
      explode1.autoRemoveOnFinish = YES;
    explode1.position = ccp(loc.x,loc.y);
}
//************Energy Level code*********************************
-(void)updateEnergy:(int)el
{
    
    EnergyLevel = el;
    printf("%d",EnergyLevel);
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    lebelEnergy = [[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",EnergyLevel] fontName:@"Arial" fontSize:32.0 dimensions:CGSizeMake(320, 50) hAlignment:UITextAlignmentCenter]retain];
  
    
    lebelEnergy.position = ccp(winSize.width/2,winSize.height-(lebelEnergy.contentSize.height/2));
   
   
    [self addChild:lebelEnergy];
    
    
}
-(void)create_FirstAidKit  //CREATING FIRST AID KIT
{
    first_Aid_Kit = [CCSprite spriteWithFile:@"FAK.jpeg"];
    first_Aid_Kit.position = ccp(arc4random() % 400, arc4random() % 300);
    [self addChild:first_Aid_Kit];
    
    first_Aid_Kit.tag = 4;
    [first_Aid_Kit_Array addObject:first_Aid_Kit];
}

-(void)updateFirstAidKit
{
    [self create_FirstAidKit];
   
    
    NSMutableArray *firstAidKitToRemove = [[NSMutableArray alloc]init];
    for(CCSprite *fak in first_Aid_Kit_Array)
    {
        if(CGRectIntersectsRect(player.boundingBox, fak.boundingBox))
        {
            
            EnergyLevel = EnergyLevel + 100;
            [lebelEnergy setString: [NSString stringWithFormat:@"%d",EnergyLevel]] ;
           

            [self updateEnergy:EnergyLevel];
            [firstAidKitToRemove addObject:fak];
        }
    }
    for (CCSprite *fak in firstAidKitToRemove)
    {
        [first_Aid_Kit_Array removeObject:fak];
        [self removeChild:fak cleanup:YES];
    }
}
//******************Energylevel code End***********************
-(void) moveForward : (id) sender
{
    [player runAction:[CCMoveTo actionWithDuration:0.05 position:ccp(player.position.x+10,player.position.y)]];
       
}
-(void) throwBomb : (id) sender
{
    
    
    
   bomb = [CCSprite spriteWithFile:@"bomb.png"];
    bomb.position = ccp(player.position.x,player.position.y);
   [self addChild:bomb];
    CCSprite *animate = [CCSprite spriteWithFile:@"3.png"];
    [animate setPosition:ccp(player.position.x, player.position.y)];
    [self addChild:animate];
    CCAnimation *bombAnimation = [CCAnimation animation];
    [bombAnimation addSpriteFrameWithFilename:@"4.png"];
     [bombAnimation addSpriteFrameWithFilename:@"5.png"];
     [bombAnimation addSpriteFrameWithFilename:@"6.png"];
     [bombAnimation addSpriteFrameWithFilename:@"7.png"];
     [bombAnimation addSpriteFrameWithFilename:@"8.png"];
     [bombAnimation addSpriteFrameWithFilename:@"9.png"];
     [bombAnimation addSpriteFrameWithFilename:@"10.png"];
     [bombAnimation addSpriteFrameWithFilename:@"3.png"];
    
    id robotAnimationAction =[CCSequence actions:[CCAnimate actionWithDuration:0.5 animation:bombAnimation restoreOriginalFrame:YES],nil];
   // [animate runAction:robotAnimationAction];
    
    id a1 = [CCJumpBy actionWithDuration:1 position:ccp(loc.x,loc.y) height:175 jumps:1];
    CCCallBlockN * actionMoveDone = [CCCallBlockN actionWithBlock:^(CCNode *node) {
        [_monsters removeObject:node];
        [node removeFromParentAndCleanup:YES];}];

     [bomb runAction:[CCSequence actions:robotAnimationAction,a1,[CCCallFuncN actionWithTarget:self selector:@selector(explosion1)],actionMoveDone, nil]];
}




-(void) moveBack : (id) sender
{

    
    [player runAction:[CCMoveTo actionWithDuration:0.05 position:ccp(player.position.x-10,player.position.y)]];
    
    
}
-(void) moveDown : (id) sender
{
    
    [player runAction:[CCMoveTo actionWithDuration:0.05 position:ccp(player.position.x,player.position.y-10)]];
   
    
}
-(void) moveUP : (id) sender
{
    
    [player runAction:[CCMoveTo actionWithDuration:0.05 position:ccp(player.position.x,player.position.y+10)]];
}


- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // Choose one of the touches to work with
    UITouch *touch = [touches anyObject];
    CGPoint location = [self convertTouchToNodeSpace:touch];
    
    loc = ccp(location.x,location.y);
    NSLog(@"%f,%f",loc.x,loc.y);

    // Set up initial location of projectile
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CCSprite *projectile = [CCSprite spriteWithFile:@"projectile.png"
                                               rect:CGRectMake(0, 0, 20, 20)];
    projectile.position = ccp(player.position.x,player.position.y);
    
    // Determine offset of location to projectile
    CGPoint offset = ccpSub(location, projectile.position);
    
    // Bail out if you are shooting down or backwards
    if (offset.x <= 0) return;
    
    // Ok to add now - we've double checked position
    [self addChild:projectile];
    
    int realX = winSize.width + (projectile.contentSize.width/2);
    float ratio = (float) offset.y / (float) offset.x;
    int realY = (realX * ratio) + projectile.position.y;
    CGPoint realDest = ccp(realX, realY);
    
    // Determine the length of how far you're shooting
    int offRealX = realX - projectile.position.x;
    int offRealY = realY - projectile.position.y;
    float length = sqrtf((offRealX*offRealX)+(offRealY*offRealY));
    float velocity = 480/1; // 480pixels/1sec
    float realMoveDuration = length/velocity;
    
    // Move projectile to actual endpoint
    [projectile runAction:
     [CCSequence actions:
      [CCMoveTo actionWithDuration:realMoveDuration position:realDest],
      [CCCallBlockN actionWithBlock:^(CCNode *node) {
         [_projectiles removeObject:node];
         [node removeFromParentAndCleanup:YES];
    }],
      nil]];
    
    projectile.tag = 2;
    [_projectiles addObject:projectile];
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"pew-pew-lei.caf"];
}

- (void)update:(ccTime)dt {
    
    NSMutableArray *projectilesToDelete = [[NSMutableArray alloc] init];
    for (CCSprite *projectile in _projectiles) {
        
        NSMutableArray *monstersToDelete = [[NSMutableArray alloc] init];
        for (CCSprite *monster in _monsters) {
            
            if (CGRectIntersectsRect(projectile.boundingBox, monster.boundingBox))
            {
               // [self explosion];
                
               
                [monstersToDelete addObject:monster];
            }
        }
        
        for (CCSprite *monster in monstersToDelete) {
            [_monsters removeObject:monster];
            [self removeChild:monster cleanup:YES];
            
            _monstersDestroyed++;
//            if (_monstersDestroyed > 30) {
//                CCScene *gameOverScene = [GameOverLayer sceneWithWon:YES];
//                [[CCDirector sharedDirector] replaceScene:gameOverScene];
//            }
        }
        
        if (monstersToDelete.count > 0) {
            [projectilesToDelete addObject:projectile];
        }
        [monstersToDelete release];
    }
    
    for (CCSprite *projectile in projectilesToDelete) {
        [_projectiles removeObject:projectile];
        [self removeChild:projectile cleanup:YES];
    }
    [projectilesToDelete release];
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{

    [_monsters release];
    _monsters = nil;
    [_projectiles release];
    _projectiles = nil;
    [first_Aid_Kit_Array release];
    first_Aid_Kit_Array = nil;
    [super dealloc];
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    [[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    [[app navController] dismissModalViewControllerAnimated:YES];
}
@end
