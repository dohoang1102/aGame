//
//  MiaoPlayer.m
//  aGame
//
//  Created by yang.zhou on 8/17/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MiaoPlayer.h"
#import "Constants.h"

@implementation MiaoPlayer
- (id)init
{
    self = [super init];
    if(self!=nil){
        CCSprite *player = [CCSprite spriteWithFile:@"pusheencat.png"];
        [self addChild:player];
    }
    return self;
}

- (void)easeMove:(moveDirection)direction speed:(NSInteger)speed duration:(NSInteger)duration
{


    CCLOG(@"move: %u, speed: %d, duration: %d", direction, speed, duration);
    CCEaseInOut* ease = nil;
    switch (direction) {
        case left:
            CCLOG(@"move left");            
            CCMoveTo* moveLeft = [CCMoveTo actionWithDuration:duration position:CGPointMake(self.position.x-30, self.position.y)];
            ease = [CCEaseInOut actionWithAction:moveLeft rate: speed];

            break;
        case right:
            CCLOG(@"move right");
            CCMoveTo* moveRight = [CCMoveTo actionWithDuration:duration position:CGPointMake(self.position.x+30, self.position.y)];
            ease = [CCEaseInOut actionWithAction:moveRight rate:speed];

        default:
            break;
            
    }
    CCShaky3D *shake = [CCShaky3D actionWithRange:5 shakeZ:YES grid:ccg(1, 1) duration:1];
    CCRotateBy *rotationBy = [CCRotateBy actionWithDuration:2 angle:360];
    CCSequence * sequence = [CCSequence actions:ease, shake, nil];
    [self runAction:sequence];
}


@end
