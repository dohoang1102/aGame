//
//  GamingLayer.h
//  aGame
//
//  Created by zhouyang on 12-8-23.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GamingLayer : CCLayer {
    
}
+(CCScene *) scene;
- (CGPoint) locationFromTouches: (NSSet *)touches;
- (void) updatePlayerPositionLeft;
- (void) updatePlayerPositionRight;
@end
