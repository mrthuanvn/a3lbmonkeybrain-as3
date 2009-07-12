package a3lbmonkeybrain.motorcortex.connectors
{
	import a3lbmonkeybrain.motorcortex.locators.Locator;
	import a3lbmonkeybrain.motorcortex.locators.LocatorEventType;
	import a3lbmonkeybrain.motorcortex.refresh.Refreshable;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * Base implementation of <code>DisplayObjectConnector</code>.
	 * 
	 * @author T. Michael Keesey
	 * @see	DisplayObjectConnector
	 * @see	ImageConnector
	 * @see	MovieClipConnector
	 * @see	ShapeConnector
	 * @see	SpriteConnector
	 */
	internal class DisplayObjectConnectorImpl implements DisplayObjectConnector, Refreshable
	{
		/**
		 * @private 
		 */
		private var _maxStretch:Number = Number.POSITIVE_INFINITY;
		/**
		 * @private 
		 */
		private var _pointA:Point;
		/**
		 * @private 
		 */
		private var _pointB:Point;
		/**
		 * @private 
		 */
		private var _targetA:Locator;
		/**
		 * @private 
		 */
		private var _targetB:Locator;
		/**
		 * The display object which this object controls.
		 * 
		 * @private
		 */
		private var displayObject:DisplayObject;
		/**
		 * The angle from the origin to <code>pointA</code>, in radians.
		 * 
		 * @see	#pointA
		 * @see	#pointADistance
		 * @private
		 */
		private var pointAAngle:Number = 0.0;
		/**
		 * The distance from the origin to <code>pointA</code>, in pixels.
		 * 
		 * @see	#pointA
		 * @see	#pointAAngle
		 * @private
		 */
		private var pointADistance:Number = 0.0;
		/**
		 * The distance from the <code>pointA</code to <code>pointB</code>, in pixels.
		 * 
		 * @see	#pointA
		 * @see	#pointB
		 * @private
		 */
		private var pointsDistance:Number = 0.0;
		/**
		 * Flag telling whether a display refresh is needed.
		 *  
		 * @private
		 */
		private var refreshRequired:Boolean = false;
		/**
		 * A copy of <code>targetA.point</code>.
		 * 
		 * @see	#targetA
		 * @private
		 */
		private var targetPointA:Point;
		/**
		 * A copy of <code>targetB.point</code>.
		 * 
		 * @see	#targetB
		 * @private
		 */
		private var targetPointB:Point;
		/**
		 * Creates a new instance.
		 * 
		 * @param	displayObject
		 * 		Display object to control.
		 * @throws	ArgumentError
		 * 		If <code>displayObject</code> is null.
		 */
		public function DisplayObjectConnectorImpl(displayObject:DisplayObject)
		{
			super();
			if (displayObject == null)
				throw new ArgumentError();
			displayObject.visible = false;
			displayObject.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			displayObject.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			if (displayObject.stage != null)
				onAddedToStage();
		}
		[Bindable]
		/**
		 * @inheritDoc
		 */
		public function get maxStretch():Number
		{
			return _maxStretch;
		}
		/**
		 * @private
		 */
		public function set maxStretch(value:Number):void {
			if (isNaN(value))
				value = 1;
			else
				value = Math.max(1, Math.abs(value));
			if (_maxStretch != value)
			{
				_maxStretch = value;
				constrainStretch();
				requireRefresh();
			}
		}
		[Bindable]
		/**
		 * @inheritDoc
		 */
		public function get pointA():Point
		{
			if (_pointA != null)
				return _pointA.clone();
			return null;
		}
		/**
		 * @private
		 */
		public function set pointA(value:Point):void
		{
			if ((_pointA == null) ? (value != null) : !_pointA.equals(value))
			{
				_pointA = (value == null) ? null : value.clone();
				if (_pointA != null && _pointB != null && _pointA.equals(_pointB))
				{
					_pointA = null;
					throw new ArgumentError();
				}
				refreshPointData();
				requireRefresh();
			}
		}
		[Bindable]
		/**
		 * @inheritDoc
		 */
		public function get pointB():Point
		{
			if (_pointB != null)
				return _pointB.clone();
			return null;
		}
		/**
		 * @private
		 */
		public function set pointB(value:Point):void
		{
			if ((_pointB == null) ? (value != null) : !_pointB.equals(value))
			{
				_pointB = (value == null) ? null : value.clone();
				if (_pointA != null && _pointB != null && _pointA.equals(_pointB))
				{
					_pointB = null;
					throw new ArgumentError();
				}
				refreshPointData();
				requireRefresh();
			}
		}
		[Bindable]
		/**
		 * @inheritDoc
		 */
		public function get targetA():Locator
		{
			return _targetA;
		}
		/**
		 * @private
		 */
		public function set targetA(value:Locator):void
		{
			if (_targetA != value)
			{
				if (_targetA != null)
					_targetA.removeEventListener(LocatorEventType.MOVE, requireRefresh);
				_targetA = value;
				targetPointA = value.point.clone();
				if (_targetA != null)
					_targetA.addEventListener(LocatorEventType.MOVE, requireRefresh);
				requireRefresh();
			}
		}
		[Bindable]
		/**
		 * @inheritDoc
		 */
		public function get targetB():Locator
		{
			return _targetB;
		}
		/**
		 * @private
		 */
		public function set targetB(value:Locator):void {
			if (_targetB != value)
			{
				if (_targetB != null)
					_targetB.removeEventListener(LocatorEventType.MOVE, requireRefresh);
				_targetB = value;
				targetPointB = value.point.clone();
				if (_targetB != null)
					_targetB.addEventListener(LocatorEventType.MOVE, requireRefresh);
				requireRefresh();
			}
		}
		/**
		 * Constrains the scaling, according to <code>maxStretch</code>.
		 * 
		 * @see	#maxStretch
		 */
		protected final function constrainStretch():void
		{
			if (scaleX > _maxStretch)
			{
				scaleX = _maxStretch;
				scaleY = 1 / _maxStretch;
			}
			else if (scaleY > _maxStretch)
			{
				scaleY = _maxStretch;
				scaleX = 1 / _maxStretch;
			}
		}
		/**
		 * @private
		 */
		private function onAddedToStage(event:Event = null):void
		{
			displayObject.addEventListener(Event.RENDER, refresh);
		}
		/**
		 * @private
		 */
		private function onRemovedFromStage(event:Event):void
		{
			displayObject.removeEventListener(Event.RENDER, refresh);
		}
		/**
		 * @inheritDoc 
		 */
		public function refresh(event:Event = null):void
		{
			// Check if an update is needed and possible.
			if (refreshRequired && _pointA != null && _pointB != null && _targetA != null && _targetB != null)
			{
				// If the targets are the same, simply attach this clip (at point A) to the target.
				if (_targetA == _targetB)
				{
					x = _targetA.x - _pointA.x;
					y = _targetA.y - _pointA.y;
					return;
				}
				// Calculate distance.
				var targetDistance:Number = Point.distance(_targetA.point, _targetB.point);
				// If the targets are at the same position, simply attach this clip (at point A) to the target.
				if (targetDistance == 0)
				{
					x = _targetA.x - _pointA.x;
					y = _targetA.y - _pointA.y;
					return;
				}
				// Calculate target angle.
				var targetAngle:Number = Math.atan2(_targetB.y - _targetA.y, _targetB.x - _targetA.x);
				// Scale accordingly and constrain scaling.
				displayObject.scaleY = targetDistance / pointsDistance;
				displayObject.scaleX = 1 / displayObject.scaleY;
				constrainStretch();
				// Calculate the angle between the scaled points.
				var scaledPointsAngle:Number = Math.atan2(displayObject.scaleY * (_pointB.y - _pointA.y),
					displayObject.scaleX * (_pointB.x - _pointA.x));
				// Calculate and set the rotation in radians and then degrees.
				var r:Number = targetAngle - scaledPointsAngle;
				displayObject.rotation = r * 180 / Math.PI;
				// Calculate and set the position.
				displayObject.x = _targetA.x - Math.cos(r + pointAAngle)
					* displayObject.scaleX * pointADistance;
				displayObject.y = _targetA.y - Math.sin(r + pointAAngle)
					* displayObject.scaleY * pointADistance;
				// Update target point records.
				targetPointA = _targetA.point.clone();
				targetPointB = _targetB.point.clone();
			}
		}
		/**
		 * Updates calculated point data. 
		 * 
		 * @see	#pointA
		 * @see	#pointAAngle
		 * @see	#pointADistance
		 * @see	#pointB
		 * @see	#pointsDistance
		 * @private
		 */
		private function refreshPointData():void
		{
			if (_pointA != null && _pointB != null)
			{
				pointAAngle = Math.atan2(_pointA.y, _pointA.x);
				pointADistance = Point.distance(new Point(), _pointA);
				pointsDistance = Point.distance(_pointA, _pointB);
				displayObject.visible = true;
			}
			else displayObject.visible = false;
		}
		/**
		 * Flags this connector so that it updates the display during the next appropriate event.
		 * 
		 * @param event
		 * 		[optional] - Event triggering this method.
		 * @private
		 */
		private function requireRefresh(event:* = null):void
		{
			refreshRequired = true;
			if (displayObject.stage != null)
				displayObject.stage.invalidate();
		}
	}
}