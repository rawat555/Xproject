//
//  FBViewController.h
//  REDVs.BLUE
//
//  Created by thinksysuser on 13/12/12.
//
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import "cocos2d.h"

@interface FBViewController : CCLayerColor<FBSessionDelegate, FBRequestDelegate>
{
    FBSession *session;
    UILabel *fbNameLabel;    
    UIButton *playButton;
    FBLoginButton *button;
}
+(CCScene *) scene;
@end
