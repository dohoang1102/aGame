//
//  GameMenuLayer.m
//  aGame
//
//  Created by yang.zhou on 8/15/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameMenuLayer.h"
#import "GamingLayer.h"

@implementation GameMenuLayer
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameMenuLayer *layer = [GameMenuLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		
		// create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Hi, here is not hello world" fontName:@"Marker Felt" fontSize:32];
        
		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        
		// position the label on the center of the screen
		label.position =  ccp( size.width /2 , size.height/2-50 );
        label.tag = 111;
		// add the label as a child to this Layer
		[self addChild: label];
	
        //create a button to change sence
        CCLabelTTF *label1 = [CCLabelTTF labelWithString:@"start blink" fontName:@"Marker Felt" fontSize:12];
        CCMenuItemLabel *menuLabel1 = [CCMenuItemLabel itemWithLabel:label1
                                                              target:self selector:@selector(startBlink:)];
        
        CCLabelTTF *label2 = [CCLabelTTF labelWithString:@"stop blink" fontName:@"Marker Felt" fontSize:12];
        CCMenuItemLabel *menuLabel2 = [CCMenuItemLabel itemWithLabel:label2
                                                              target:self selector:@selector(stopBlink:)];        
        
        CCLabelTTF *label3 = [CCLabelTTF labelWithString:@"transfer" fontName:@"Marker Felt" fontSize:12];
        CCMenuItemLabel *menuLabel3 = [CCMenuItemLabel itemWithLabel:label3
                                                              target:self selector:@selector(transferToGameSence:)];
        
        CCMenu *mainMenu = [CCMenu menuWithItems: menuLabel1,menuLabel2,menuLabel3, nil];
        [mainMenu alignItemsVerticallyWithPadding:5];
        [self addChild:mainMenu];
    }
	return self;
}

- (void) transferToGameSence:(CCMenuItem *)menuItem
{
    //CCTransitionFade *trans = [CCTransitionFade transitionWithDuration:1 scene:[GamingLayer scene] withColor:ccWHITE];
    //CCTransitionTurnOffTiles *trans = [CCTransitionTurnOffTiles transitionWithDuration:1 scene:[GamingLayer scene]];
    CCTransitionSplitCols *trans = [CCTransitionSplitCols transitionWithDuration:2 scene:[GamingLayer scene]];
    [[CCDirector sharedDirector] pushScene:[GamingLayer scene]];
    [[CCDirector sharedDirector] replaceScene:trans];
}


-(void) scheduleUpdates
{
    [self schedule:@selector(updateTenTimesPerSecond:)interval:0.1f];
}

-(void) updateTenTimesPerSecond:(ccTime)delta {
    NSLog(@"ten...");
    
}
- (void) startBlink:(CCMenuItem *)menuItem
{
    
    NSLog(@"start blink");
    
    CCLabelTTF *label = (CCLabelTTF *)[self getChildByTag:111];    
    CCAction *blink = [CCBlink actionWithDuration:10 blinks:20];
    blink.tag = 234;
    [label runAction:blink];
    [self scheduleUpdates];
    
}

- (void) stopBlink:(CCMenuItem *)menuItem
{
    NSLog(@"stop blink");
    CCLabelTTF *label = (CCLabelTTF *)[self getChildByTag:111];
    [label stopActionByTag:234];
    [self unschedule:@selector(updateTenTimesPerSecond:)];
    
}
// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
