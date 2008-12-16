package a3lbmonkeybrain.motorcortex.effects
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.filters.BlurFilter;

	/**
	 * Default implementation for a movie clip that implements <code>Blurrable</code>
	 *  
	 * @author T. Michael Keesey
	 * @see Blurrable
	 */
	public class BlurrableClip extends MovieClip implements Blurrable
	{
		/**
		 * Value of <code>blurQuality</code>.
		 * 
		 * @see #blurQuality
		 */
		protected var _blurQuality:int = 1;
		/**
		 * Value of <code>blurX</code>.
		 * 
		 * @see #blurX 
		 */
		protected var _blurX:uint;
		/**
		 * Value of <code>blurY</code>.
		 * 
		 * @see #blurY 
		 */
		protected var _blurY:uint;
		/**
		 * Creates a new instance. 
		 */
		public function BlurrableClip()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, updateBlur);
			addEventListener(Event.RENDER, updateBlur);
		}
		/**
		 * The quality of the motion blur.
		 * 
		 * @defaultValue 1
		 * @see flash.filters.BlurFilter#quality
		 */
		public function get blurQuality():int
		{
			return _blurQuality;
		}
		/**
		 * @private
		 */		
		public function set blurQuality(value:int):void
		{
			if (_blurQuality != value)
			{
				_blurQuality = value;
				if (stage != null)
					stage.invalidate();
			}
		}
		/**
		 * Simultaneously sets <code>blurX</code> and <code>blurY</code>.
		 * 
		 * @see #blurX
		 * @see #blurY
		 */
		public function set blur(value:uint):void
		{
			blurX = value;
			blurY = value;
		}
		/**
		 * @inheritDoc
		 */
		public function set blurX(value:uint):void
		{
			if (_blurX != value)
			{
				_blurX = value;
				if (stage != null)
					stage.invalidate();
			}
		}
		/**
		 * @inheritDoc
		 */
		public function set blurY(value:uint):void
		{
			if (_blurY != value)
			{
				_blurY = value;
				if (stage != null)
					stage.invalidate();
			}
		}
		/**
		 * Updates the blur filter.
		 *  
		 * @param event
		 * 		<code>Event.ADDED_TO_STAGE</code> or <code>Event.RENDER</code> event.
		 * @see flash.display.DisplayObject#event:addedToStage
		 * @see flash.display.DisplayObject#event:render
		 * @see flash.events.Event#ADDED_TO_STAGE
		 * @see flash.events.Event#RENDER
		 */
		protected function updateBlur(event:Event):void
		{
			if (_blurX == 0 && _blurY == 0)
				filters = [];
			else
				filters = [new BlurFilter(_blurX, _blurY, _blurQuality)];
		}
	}
}