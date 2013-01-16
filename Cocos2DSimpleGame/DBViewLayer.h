//
//  DBViewLayer.h
//  database
//
//  Created by thinksysuser on 11/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//
#import <GameKit/GameKit.h>
#import <sqlite3.h>
#import "HelloWorldLayer.h"
#import <UIKit/UIKit.h>
#import "cocos2d.h"

@interface DBViewLayer : CCLayerColor<UITextFieldDelegate>
{
    UITextField *nameField;
    UITextField *emailField;
    UITextField *passwordField;
    sqlite3 *db;
    NSString *databasePath;
    UIButton *submitButton;
    UIButton *playButton;
    
    UILabel *titleLabel;
    UILabel *nameLabel;
    UILabel *emailLabel;
    UILabel *passwordLabel;
    
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end

