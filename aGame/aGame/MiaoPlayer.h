//
//  MiaoPlayer.h
//  aGame
//
//  Created by yang.zhou on 8/17/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

typedef enum {left, right} moveDirection;
typedef enum {clockwise, counterclockwise} rotateDirction;

@interface MiaoPlayer : CCLayer {
    
}
- (void)easeMove:(moveDirection)direction speed:(NSInteger)speed duration:(NSInteger)duration;
@end
