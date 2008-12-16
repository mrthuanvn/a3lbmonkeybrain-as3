package a3lbmonkeybrain.motorcortex.effects
{
	import a3lbmonkeybrain.brainstem.math.closestPowerOf2;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	
	/**
	 * Creates motion blur on a display object.
	 * 
	 * @author T. Michael Keesey
	 * @see flash.filters.BlurFilter
	 */
	public final class MotionBlur
	{
		private var blurFactor:Number;
		private var displayObject:DisplayObject;
		private var displayObjectIsBlurrable:Boolean;
		private var filters:Array /* .<BitmapFilter> */;
		private var quality:uint;
		private var prevBlurX:uint;
		private var prevBlurY:uint;
		private var prevX:Number;
		private var prevY:Number;
		private var optimized:Boolean;
		/**
		 * Creates a new instance.
		 * 
		 * @param displayObject
		 * 		The display object to blur. If it implements <code>Blurrable</code>, then the properties of that
		 * 		interface are used. Otherwise, if it has any current filters, they are stored and the blur filter is
		 * 		placed over them.
		 * @param blurFactor
		 * 		The amount to blur, per pixel of motion per frame.
		 * @param optimized
		 * 		If <code>true</code>, only uses powers of two for blur amounts.
		 * @param quality
		 * 		The quality of the blur. If <code>displayObject</code> implements <code>Blurrable</code>, then this
		 * 		will be ignored.
		 * @see Blurrable
		 * @see flash.filters.BlurFilter#quality
		 */
		public function MotionBlur(displayObject:DisplayObject, blurFactor:Number = 1, optimized:Boolean = true,
			quality:uint = 1)
		{
			super();
			if (blurFactor != 0)
			{
				this.blurFactor = blurFactor;
				this.displayObject = displayObject;
				this.optimized = optimized;
				this.quality = quality;
				displayObjectIsBlurrable = displayObject is Blurrable;
				filters = (displayObject.filters && !displayObjectIsBlurrable) ? displayObject.filters : [];
				prevX = displayObject.x;
				prevY = displayObject.y;
				displayObject.addEventListener(Event.ENTER_FRAME, updateDisplayObject, false, int.MIN_VALUE);
			}
		}
		/**
		 * Disposes of this object, making it ready for garbage collection once all references are removed.
		 */
		public function dispose():void
		{
			if (displayObject != null)
			{
				displayObject.removeEventListener(Event.ENTER_FRAME, updateDisplayObject);
				displayObject = null;
				filters = null;
			}
		}
		/**
		 * @private
		 */
		private function updateDisplayObject(event:Event):void
		{
			if (displayObject.visible && displayObject.stage != null)
			{
				const currX:Number = displayObject.x;
				const currY:Number = displayObject.y;
				var blurX:uint = Math.abs(blurFactor * (currX - prevX));
				var blurY:uint = Math.abs(blurFactor * (currY - prevY));
				if (optimized)
				{
					blurX = closestPowerOf2(blurX);
					blurY = closestPowerOf2(blurY);
				}
				if (blurX != prevBlurX || blurY != prevBlurY)
				{
					if (displayObjectIsBlurrable)
					{
						Blurrable(displayObject).blurX = blurX;
						Blurrable(displayObject).blurY = blurY;
					}
					else if (blurX == 0 && blurY == 0)
					{
						displayObject.filters = filters;
					}
					else
					{
						const blurFilter:BlurFilter = new BlurFilter(blurX, blurY, quality);
						displayObject.filters = filters.concat(blurFilter);
					}
					prevBlurX = blurX;
					prevBlurY = blurY;
				}
				prevX = currX;
				prevY = currY;
			}
		}
	}
}