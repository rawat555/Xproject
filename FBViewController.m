//
//  FBViewController.m
//  REDVs.BLUE
//
//  Created by thinksysuser on 13/12/12.
//
//

#import "FBViewController.h"
#import "HelloWorldLayer.h"

@interface FBViewController ()

@end

@implementation FBViewController


+(CCScene *) scene
{
    CCScene *scene = [CCScene node];
    FBViewController *layer = [FBViewController node];
    [scene addChild: layer];    
    return scene;
}

-(id)init
{
    if(self = [super initWithColor:ccc4(255, 255, 255, 255)])
    {
    
    //FACEBOOK USER NAME LABEL
    fbNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 100, 30)];
    fbNameLabel.transform = CGAffineTransformMakeRotation(M_PI * 90 / 180.0f);
    [[[[CCDirector sharedDirector]view]window]addSubview:fbNameLabel];

    //PLAY BUTTON IMPLEMENTATION        
    playButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [playButton addTarget:self action:@selector(playGame) forControlEvents:UIControlEventTouchUpInside];
    [playButton setTitle:@"Play" forState:UIControlStateNormal];
    playButton.transform = CGAffineTransformMakeRotation(M_PI * 90 / 180.0f);
    playButton.frame = CGRectMake(50, 350, 30, 100);
    
    [[[[CCDirector sharedDirector]view]window]addSubview:playButton];
    playButton.hidden = YES;
    
    
    session = [[FBSession sessionForApplication:@"302111556562061" secret:@"087b2a79adaa03810d79c7730b40546d" delegate:self]retain];
    
    button = [[[FBLoginButton alloc]init]autorelease];
    button.transform = CGAffineTransformMakeRotation(M_PI * 90 / 180.0f);
    [button setFrame:CGRectMake(240, 160, 30, 100)];
    [[[[CCDirector sharedDirector]view]window]addSubview:button];
    }
    return self;
    
}



-(void)playGame
{
    [playButton setHidden:YES];
    [playButton release];
    [fbNameLabel setHidden:YES];
    [fbNameLabel release];
    [button setHidden:YES];
    [button release];
    
    [[CCDirector sharedDirector]replaceScene:[HelloWorldLayer node]];
}


-(void)askPermission : (id)target
{
    FBPermissionDialog *dialog = [[[FBPermissionDialog alloc]init]autorelease];
    dialog.permission = @"status_update";
    [dialog show];
}


-(void)session : (FBSession *)session didLogin:(FBUID)uid
{
    NSString *fql = [NSString stringWithFormat:@"select uid,name from user where uid == %lld",uid];
    
    NSDictionary *params = [NSDictionary dictionaryWithObject:fql forKey:@"query"];
    [[FBRequest requestWithDelegate:self]call:@"facebook.fql.query" params:params];
}


-(void)request:(FBRequest *)request didLoad:(id)result
{
    NSArray *users = result;
    NSDictionary *user = [users objectAtIndex:0];
    NSString *name = [user objectForKey:@"name"];
    
    //Display name here
    fbNameLabel.text = name;
    button.hidden  = YES;
    playButton.hidden = NO;
}



- (void)dealloc
{
    [super dealloc];
}


@end
