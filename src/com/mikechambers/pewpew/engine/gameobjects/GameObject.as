﻿package com.mikechambers.pewpew.engine.gameobjects{	import com.mikechambers.pewpew.engine.TickManager;	import com.mikechambers.pewpew.engine.events.TickEvent;	import com.mikechambers.pewpew.engine.pools.IGameObjectPoolable;	import com.mikechambers.pewpew.memory.IMemoryManageable;		import flash.display.DisplayObject;	import flash.display.MovieClip;	import flash.events.Event;	import flash.filters.DropShadowFilter;	import flash.geom.Matrix;	import flash.geom.Point;	import flash.geom.Rectangle;			public class GameObject extends MovieClip implements IMemoryManageable, IGameObjectPoolable	{				protected var health:Number = 1;		protected var __target:DisplayObject;		protected var bounds:Rectangle;		protected var modifier:Number = 0;				protected var tickManager:TickManager;					public function GameObject()		{			super();								mouseEnabled = false;			mouseChildren = false;									var dropShadow:DropShadowFilter = new DropShadowFilter(5);			dropShadow.angle = 29;			dropShadow.strength = .5;			dropShadow.blurX = 3;			dropShadow.blurY = 3;			dropShadow.distance = 2;			filters = [dropShadow];						addEventListener(Event.ADDED_TO_STAGE, onStageAdded, false, 0, 																		true);			//cacheAsBitmapMatrix = new Matrix();			cacheAsBitmap = true;		}				public function initialize(bounds:Rectangle, 										target:DisplayObject = null, 										modifier:Number = 1):void		{			this.bounds = bounds;			__target = target;			this.modifier = modifier;				}				protected function onStageAdded(e:Event):void		{			if(!tickManager)			{				tickManager = TickManager.getInstance();			}						removeEventListener(Event.ADDED_TO_STAGE, onStageAdded);			addEventListener(Event.REMOVED_FROM_STAGE, onStageRemoved, false,																		0, true);		}				protected function onStageRemoved(e:Event):void		{			addEventListener(Event.ADDED_TO_STAGE, onStageAdded, false, 0, 																		true);			removeEventListener(Event.REMOVED_FROM_STAGE, onStageRemoved);																		}		protected function onTick(e:TickEvent):void		{		}						public function set target(v:DisplayObject):void		{			__target = v;		}				public function start():void		{			tickManager.addEventListener(TickEvent.TICK, onTick, false, 0, true);		}				public function pause():void		{			tickManager.removeEventListener(TickEvent.TICK, onTick);		}						protected function generateRandomBoundsPoint():Point		{			var p:Point = new Point();			p.x = Math.random() * bounds.width;			p.y = Math.random() * bounds.height;						return p;		}			public function dealloc():void		{						if(tickManager)			{								tickManager.removeEventListener(TickEvent.TICK, onTick);				tickManager = null;			}						removeEventListener(Event.ADDED_TO_STAGE, onStageAdded);			removeEventListener(Event.REMOVED_FROM_STAGE, onStageRemoved);		}			}}