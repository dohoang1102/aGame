//
//  GamingLayer.m
//  aGame
//
//  Created by yang.zhou on 8/16/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GamingLayer.h"
#import "MiaoPlayer.h"
#import "LoadingScene.h"

@implementation GamingLayer
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
	// 'layer' is an autorelease object.
	GamingLayer *layer = [GamingLayer node];
    
	// add layer as a child to scene
	[scene addChild: layer];
    
	// return the scene
	return scene;
}

- (id) init
{
    if( (self=[super init])) {
        
		// create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Here is the game scene" fontName:@"Marker Felt" fontSize:12];
        
		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        
		// position the label on the center of the screen
		label.position =  ccp( size.width /2 , size.height/2-50 );
        
		// add the label as a child to this Layer
		[self addChild: label];
        //CCSprite *player = [CCSprite spriteWithFile:@"pusheencat.png"];
        MiaoPlayer *player = [MiaoPlayer node];
        player.tag = 10;
        [player setPosition:CGPointMake(size.width/2, size.height/2)];
        [self addChild: player];
        
        CCLabelTTF *label1 = [CCLabelTTF labelWithString:@"Move Left" fontName:@"Marker Felt" fontSize:12];
        CCMenuItemLabel *menuLabel1 = [CCMenuItemLabel itemWithLabel:label1
                                                              target:self selector:@selector(moveLeft:)];
        
        CCLabelTTF *label2 = [CCLabelTTF labelWithString:@"Move Right" fontName:@"Marker Felt" fontSize:12];
        CCMenuItemLabel *menuLabel2 = [CCMenuItemLabel itemWithLabel:label2
                                                              target:self selector:@selector(moveRight:)];
        
        CCLabelTTF *label3 = [CCLabelTTF labelWithString:@"Stop Action" fontName:@"Marker Felt" fontSize:12];
        CCMenuItemLabel *menuLabel3 = [CCMenuItemLabel itemWithLabel:label3
                                                              target:self selector:@selector(testAction:)];
        
        CCMenu *mainMenu = [CCMenu menuWithItems: menuLabel1,menuLabel2,menuLabel3, nil];
        [mainMenu alignItemsVerticallyWithPadding:5];
        [mainMenu setPosition:CGPointMake(50, 250)];
        [self addChild:mainMenu];
        CCSprite *leftControlSprite = [CCSprite spriteWithFile:@"left.png"];
        CCMenuItemSprite *leftController = [CCMenuItemSprite itemFromNormalSprite:leftControlSprite
                                                                   selectedSprite:nil
                                                                           target:self
                                                                         selector:@selector(leftTouched:)];
        
        CCSprite *rightControlSprite = [CCSprite spriteWithFile:@"right.png"];
        CCMenuItemSprite *rightController = [CCMenuItemSprite itemFromNormalSprite:rightControlSprite
                                                                    selectedSprite:nil
                                                                            target:self
                                                                          selector:@selector(rightTouched:)];
        
        CCMenu *controlMenu = [CCMenu menuWithItems:leftController, rightController, nil];
        [controlMenu alignItemsHorizontallyWithPadding:3];
        [controlMenu setPosition:CGPointMake(100, 50)];
        [self addChild:controlMenu];
        self.isTouchEnabled = YES;
    }
	return self;
}

- (void)leftTouched:(CCMenuItem *)menuItem
{
    MiaoPlayer *player = (MiaoPlayer *)[self getChildByTag:10];
    [player easeMove:left speed:5 duration:1];
    
}
- (void)rightTouched:(CCMenuItem *)menuItem
{
    MiaoPlayer *player = (MiaoPlayer *)[self getChildByTag:10];
    [player easeMove:right speed:5 duration:1];
    
    
}
- (void)moveLeft:(CCMenuItem *)menuItem
{
    [self updatePlayerPositionLeft];
}
- (void)moveRight:(CCMenuItem *)menuItem
{
    [self updatePlayerPositionRight];
}
- (void)testAction:(CCMenuItem *)menuItem
{
    [self unscheduleAllSelectors];
}

-(void) updatePlayerPositionLeft
{
    [self schedule:@selector(updatePlayerPositionLeftTenTimesPerSecond:)interval:0.1f];
}

-(void) updatePlayerPositionLeftTenTimesPerSecond:(ccTime)delta {
    CCSprite *player = (CCSprite *)[self getChildByTag:10];
    float x = player.position.x;
    if (player.position.x>600) {
        x = 0;
    }
    
    [player setPosition:CGPointMake(x+1, player.position.y)];
}

-(void) updatePlayerPositionRight
{
    [self schedule:@selector(updatePlayerPositionRightTenTimesPerSecond:)interval:0.1f];
}

-(void) updatePlayerPositionRightTenTimesPerSecond:(ccTime)delta {
    CCSprite *player = (CCSprite *)[self getChildByTag:10];
    float x = player.position.x;
    if (player.position.x>600) {
        x = 0;
    }
    
    [player setPosition:CGPointMake(x-1, player.position.y)];
}


-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	BOOL useLoadingScene = YES;
	if (useLoadingScene)
	{
		[[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:TargetSceneFirst]];
	}
}

- (CGPoint) locationFromTouches: (NSSet *)touches
{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView: [touch view]];
    return [[CCDirector sharedDirector] convertToGL:touchLocation];
}


@end