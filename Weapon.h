//
//  Weapon.h
//  Cocos2DSimpleGame
//
//  Created by thinksysuser on 13/12/12.
//  Copyright (c) 2012 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import <sqlite3.h>

@interface Weapon : NSObject
{
    
    sqlite3 *db;
    NSString *databasePath;
}
-(id)display;
@end
