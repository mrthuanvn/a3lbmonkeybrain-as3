package a3lbmonkeybrain.motorcortex.connectors
{
	import flash.display.Sprite;
	/**
	 * A sprite which connects two locators.
	 * 
	 * @author T. Michael Keesey
	 * @see	a3lbmonkeybrain.motorcortex.locators.Locator
	 */
	public class SpriteConnector extends Sprite implements DisplayObjectConnector
	{
		/**
		 * @private
		 */
		private var connector:DisplayObjectConnector;
		/**
		 * Creates a new instance.
		 */
		public function SpriteConnector()
		{
			super();
			connector = new DisplayObjectConnectorImpl(this);
		}
		/**
		 * @inheritDoc 
		 */
		public final function get maxStretch():Number
		{
			return connector.maxStretch;
		}
		/**
		 * @private
		 */
		public final function set maxStretch(value:Number):void
		{
			connector.maxStretch = value;
		}		
		/**
		 * @inheritDoc 
		 */
		public final function get pointA():Point
		{
			return connector.pointA;
		}
		/**
		 * @private
		 */
		public final function set pointA(value:Point):void
		{
			connector.pointA = value;
		}		
		/**
		 * @inheritDoc 
		 */
		public final function get pointB():Point
		{
			return connector.pointB;
		}
		/**
		 * @private
		 */
		public final function set pointB(value:Point):void
		{
			connector.pointB = value;
		}		
		/**
		 * @inheritDoc 
		 */
		public final function get targetA():Locator
		{
			return connector.targetA;
		}
		/**
		 * @private
		 */
		public final function set targetA(value:Locator):void
		{
			connector.targetA = value;
		}
		/**
		 * @inheritDoc 
		 */
		public final function get targetB():Locator
		{
			return connector.targetB;
		}
		/**
		 * @private
		 */
		public final function set targetB(value:Locator):void
		{
			connector.targetB = value;
		}		
	}
}