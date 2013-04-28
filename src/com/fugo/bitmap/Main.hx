package com.fugo.bitmap;

import com.eclecticdesignstudio.spritesheet.AnimatedSprite;
import com.eclecticdesignstudio.spritesheet.data.BehaviorData;
import com.eclecticdesignstudio.spritesheet.importers.BitmapImporter;
import com.eclecticdesignstudio.spritesheet.Spritesheet;
import nme.Assets;
import nme.display.Sprite;
import nme.events.Event;
import nme.events.KeyboardEvent;
import nme.Lib;
import nme.ui.Keyboard;

/**
 * ...
 * @author Fugo
 */

class Main extends Sprite 
{
	var inited:Bool;
	var lastTime:Int = 0;
	var animated:AnimatedSprite;
	
	function resize(e) 
	{
		if (!inited) init();
		// else (resize or orientation change)
	}
	
	function init() 
	{
		if (inited) return;
		inited = true;
		
		var spritesheet:Spritesheet = BitmapImporter.create(Assets.getBitmapData("img/kit_from_firefox.png"), 3, 9, 56, 80);
		spritesheet.addBehavior(new BehaviorData("stand", [0, 1, 2], true));
		spritesheet.addBehavior(new BehaviorData("down", [3, 4, 5], false,15));
		spritesheet.addBehavior(new BehaviorData("jump", [6, 7, 8], false,15));
		spritesheet.addBehavior(new BehaviorData("hit", [9, 10, 11], false,15));
		spritesheet.addBehavior(new BehaviorData("punch", [12, 13, 14], false,5));
		spritesheet.addBehavior(new BehaviorData("kick", [15, 16, 17], false,15));
		spritesheet.addBehavior(new BehaviorData("flypunch", [18, 19, 20], false,10));
		spritesheet.addBehavior(new BehaviorData("flykick", [21, 22, 23], false,10));
		spritesheet.addBehavior(new BehaviorData("dizzy", [24, 25, 26], true));
		
		animated = new AnimatedSprite(spritesheet, true);
		animated.showBehaviors(["down","jump","hit","punch"]);
		
		addChild(animated);
		animated.x = stage.stageWidth / 2-animated.width/2;
		animated.y = stage.stageHeight / 2-animated.height/2;
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
		stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		trace("keys:1,2,3,4,5,6,7,8,9,0");
	}

	public function onEnterFrame(e:Event):Void
	{
		var delta = Lib.getTimer()- lastTime;
		animated.update(delta);
		lastTime = Lib.getTimer();
	}

	public function onKeyUp(e:KeyboardEvent):Void
	{
		if (e.keyCode == Keyboard.NUMBER_1) {
			animated.showBehavior("stand");
			trace("stand");
		}
		if (e.keyCode == Keyboard.NUMBER_2) {
			animated.showBehavior("down");
			trace("down");
		}
		if (e.keyCode == Keyboard.NUMBER_3) {
			animated.showBehavior("jump");
			trace("jump");
		}
		if (e.keyCode == Keyboard.NUMBER_4) {
			animated.showBehavior("hit");
			trace("hit");
		}
		if (e.keyCode == Keyboard.NUMBER_5) {
			animated.showBehavior("punch");
			trace("punch");
		}
		if (e.keyCode == Keyboard.NUMBER_6) {
			animated.showBehavior("kick");
			trace("kick");
		}
		if (e.keyCode == Keyboard.NUMBER_7) {
			animated.showBehavior("flypunch");
			trace("flypunch");
		}
		if (e.keyCode == Keyboard.NUMBER_8) {
			animated.showBehavior("flykick");
			trace("flykick");
		}
		if (e.keyCode == Keyboard.NUMBER_9) {
			animated.showBehavior("dizzy");
			trace("dizzy");
		}
		if (e.keyCode == Keyboard.NUMBER_0) {
			animated.showBehaviors(["down","jump","hit","punch"]);
			trace("down,jump,hit,punch");
		}
	}
	public function new() 
	{
		super();	
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
	}
	
	public static function main() 
	{
		// static entry point
		Lib.current.stage.align = nme.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = nme.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}
}
