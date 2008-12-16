package a3lbmonkeybrain.motorcortex.effects
{
	/**
	 * Interface for display objects with custom motion blur implementations. 
	 * 
	 * @author T. Michael Keesey
	 * @see MotionBlur
	 */
	public interface Blurrable
	{
		/**
		 * The horizontal amount of motion blur.
		 */
		function set blurX(value:uint):void;
		/**
		 * The vertical amount of motion blur.
		 */
		function set blurY(value:uint):void;
	}
}