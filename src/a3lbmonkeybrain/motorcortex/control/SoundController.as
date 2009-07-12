package a3lbmonkeybrain.motorcortex.control
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.media.SoundMixer;
	import flash.utils.ByteArray;
	/**
	 * Dispatched when the value changes.
	 *
	 * @eventType flash.events.Event.CHANGE
	 * @see #value
	 */
	[Event(name="change",type="flash.events.Event")]
	/**
	 * Controls a numerical value, based on the current sound output.
	 * 
	 * @author T. Michael Keesey
	 */
	public class SoundController extends AbstractBeaconDrivenController
	{
		/**
		 * @private 
		 */
		private var _approachRatio:Number = 0.8;
		/**
		 * @private 
		 */
		private var _multiplier:Number = 1;
		/**
		 * @private 
		 */
		private var _spectrumHigh:uint = 511;
		/**
		 * @private 
		 */
		private var _spectrumLow:uint = 0;
		/**
		 * @private 
		 */
		private var _stretchFactor:uint = 0;
		/**
		 * @private 
		 */
		private var _useFFT:Boolean = false;
		/**
		 * @private 
		 */
		private var _value:Number = 0;
		/**
		 * Creates a new instance.
		 */
		public function SoundController()
		{
			super();
		}
		[Inspectable(defaultValue = 0.8)]
		/**
		 * This ratio is used to determine how quickly or smoothly <code>value</code> approaches its
		 * destination. Use 0 for jumpy-but-accurate motion and a value close to 1 for smooth-but-delayed motion. 
		 * <p>
		 * The value will be constrained to a value from 0 to 0.999.
		 * </p>
		 * 
		 * @default 0.8
		 * @see #value
		 */
		public final function get approachRatio():Number
		{
			return _approachRatio;
		}
		/**
		 * @private 
		 */
		public final function set approachRatio(value:Number):void
		{
			if (isNaN(value))
				value = 0;
			_approachRatio = Math.min(0.999, Math.max(0, value));
		}
		[Inspectable(defaultValue = 1)]
		/**
		 * The value of this controller is multiplied by this factor, but constrained.
		 * 
		 * @default 1
		 * @see #value
		 */
		public final function get multiplier():Number
		{
			return _multiplier;
		}
		/**
		 * @private 
		 */
		public final function set multiplier(value:Number):void
		{
			_multiplier = value;
		}
		[Inspectable(defaultValue = 511)]
		/**
		 * With <code>spectrumLow</code>, defines the range of the spectrum which is sampled.
		 * <p>
		 * This is a number from 0 to 511. If set lower than <code>spectrumLow</code>, then
		 * <code>spectrumLow</code> will be set to the same value. 
		 * </p>
		 * 
		 * @default 511
		 * @see #spectrumLow
		 */
		public final function get spectrumHigh():uint
		{
			return _spectrumHigh;
		}
		/**
		 * @private 
		 */
		public final function set spectrumHigh(value:uint):void
		{
			if (isNaN(value))
				value = 0;
			_spectrumHigh = Math.min(511, value);
			if (_spectrumLow > _spectrumHigh)
				_spectrumLow = _spectrumHigh;
		}
		[Inspectable(defaultValue = 0)]
		/**
		 * With <code>spectrumHigh</code>, defines the range of the spectrum which is sampled.
		 * <p>
		 * This is a number from 0 to 511. If set higher than <code>spectrumHigh</code>, then
		 * <code>spectrumHigh</code> will be set to the same value. 
		 * </p>
		 * 
		 * @default 0
		 * @see #spectrumHigh
		 */
		public final function get spectrumLow():uint
		{
			return _spectrumLow;
		}
		/**
		 * @private 
		 */
		public final function set spectrumLow(value:uint):void
		{
			if (isNaN(value))
				value = 0;
			_spectrumLow = Math.min(511, value);
			if (_spectrumHigh < _spectrumLow)
				_spectrumHigh = _spectrumLow;
		}
		[Inspectable(defaultValue=0)]
		/**
		 * The resolution of the sound samples. If you set this property to 0, data is sampled at 44.1 KHz;
		 * with a value of 1, data is sampled at 22.05 KHz; with a value of 2, data is sampled 11.025 KHz;
		 * and so on.
		 * 
		 * @default 0
		 * @see	flash.media.SoundMixer#computerSpectrum()
		 */
		public final function get stretchFactor():uint
		{
			return _stretchFactor;
		}
		/**
		 * @private 
		 */
		public final function set stretchFactor(value:uint):void
		{
			_stretchFactor = value;
		}
		[Inspectable(defaultValue=false)]
		/**
		 * If <code>true</code> runs a fast Fourier transform (FFT) on the sound data before computing the spectrum.
		 * Using a transform causes this controller's value to use a frequency spectrum instead of the raw sound
		 * wave. In the frequency spectrum, low frequencies are represented on the left and high frequencies are
		 * on the right.
		 * 
		 * @default false
		 * @see	flash.media.SoundMixer#computerSpectrum()
		 */
		public final function get useFFT():Boolean
		{
			return _useFFT;
		}
		/**
		 * @private 
		 */
		public final function set useFFT(value:Boolean):void
		{
			_useFFT = value;
		}
		[Bindable(event="change")]
		/**
		 * The value of this controller, from -1 to 1. 
		 */
		public final function get value():Number
		{
			return _value;
		}
		/**
		 * @inheritDoc 
		 */
		override public final function refresh(event:Event = null):void
		{
			if (_multiplier == 0)
			{
				setValue(0);
				return;
			}
			var bytes:ByteArray = new ByteArray();
			SoundMixer.computeSpectrum(bytes, _fftMode, _stretchFactor);
			// Quickly multiply by 4 (the size of a floating point number).
			bytes.position = _spectrumLow << 2;
			var n:int = _spectrumHigh - _spectrumLow + 1;
			var newValue:Number = 0;
			for (var i:int = 0; i < n; ++i)
			{
				newValue += bytes.readFloat();
			}
			newValue /= n;
			if (_multiplier == 1) setValue(value * _approachRatio + newValue * (1 - _approachRatio));
			else setValue(value * _approachRatio + Math.max(-1, Math.min(1, newValue * _multiplier))
				* (1 - _approachRatio));
		}
		/**
		 * Updates <code>value</code>.
		 * <p>
		 * In the interest of optimization, there is no automatic constraining of the value.
		 * It should be kept from -1 to 1, that is, -1 <= <code>value</code> <= 1.
		 * </p>
		 * 
		 * @param value
		 * 		New value for <code>value</code>.
		 */
		protected final function setValue(value:Number):void {
			if (_value != value)
			{
				_value = value;
				dispatchEvent(new Event(Event.CHANGE));
			}
		}
		/**
		 * @inheritDoc 
		 */
		override public function toString():String
		{
			return "[SoundController approachRatio=" + approachRatio
				+ " fftMode=" + fftMode
				+ " multiplier=" + multiplier
				+ " spectrumHigh=" + spectrumHigh
				+ " spectrumLow=" + spectrumLow
				+ " stretchFactor=" + stretchFactor + "]";
		}
	}
}