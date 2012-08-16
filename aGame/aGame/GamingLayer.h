//
//  GamingLayer.h
//  aGame
//
//  Created by yang.zhou on 8/16/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
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
