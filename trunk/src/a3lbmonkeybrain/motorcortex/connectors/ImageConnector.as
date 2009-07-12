package a3lbmonkeybrain.motorcortex.connectors
{
	import flash.display.DisplayObject;
	import mx.core.BitmapAsset;
	/**
	 * Connects two locators using a dynamically-created image.
	 * 
	 * @author T. Michael Keesey
	 * @see	a3lbmonkeybrain.motorcortex.locators.Locator
	 */
	public class ImageConnector extends SpriteConnector
	{
		/**
		 * @private 
		 */
		private var _imageClass:Class;
		/**
		 * The automatically-created image.
		 * 
		 * @see #imageClass
		 */
		protected var image:DisplayObject;
		/**
		 * Creates a new instance.
		 */
		public function ImageConnector()
		{
			super();
		}
		[Bindable]
		/**
		 * The class to use for generating the image. If set to <code>null</code>,
		 * removes any preexisting image. If set to a subclass of <code>BitmapAsset</code>,
		 * uses bitmap smoothing. Must be <code>null</code> or a subclass of <code>DisplayObject</code>.
		 * 
		 * @throws	ArgumentError
		 * 		If set to a class that is not a subclass of <code>DisplayObject</code>.
		 * @see #image
		 * @see	flash.display.DisplayObject
		 * @see	mx.core.BitmapAsset
		 */
		public final function get imageClass():Class
		{
			return _imageClass;
		}
		/**
		 * @private
		 */
		public final function set imageClass(value:Class):void
		{
			if (image != null)
				removeChild(image);
			_imageClass = value;
			if (_imageClass != null)
			{
				image = new _imageClass() as DisplayObject;
				if (image == null)
					throw new ArgumentError();
				if (image is BitmapAsset)
					BitmapAsset(image).smoothing = true;
				addChild(image);
			}
		}
	}
}