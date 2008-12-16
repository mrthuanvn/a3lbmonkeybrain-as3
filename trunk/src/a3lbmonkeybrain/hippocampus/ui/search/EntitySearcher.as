package a3lbmonkeybrain.hippocampus.ui.search
{
	import a3lbmonkeybrain.brainstem.relate.Equality;
	import a3lbmonkeybrain.brainstem.relate.OrderSort;
	import a3lbmonkeybrain.brainstem.strings.clean;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Menu;
	import mx.controls.TextInput;
	import mx.core.IDataRenderer;
	import mx.events.CollectionEvent;
	import mx.events.FlexEvent;
	import mx.events.MenuEvent;
	import mx.managers.PopUpManager;
	import mx.rpc.AbstractOperation;
	import mx.rpc.IResponder;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	[Bindable]
	[Event(name = "dataChange", type = "mx.events.FlexEvent")]
	[Event(name = "valueCommit", type = "mx.events.FlexEvent")]
	public final class EntitySearcher extends EventDispatcher implements IDataRenderer
	{
		public static const DEFAULT_SEARCH_DELAY:uint = 2500;
		private const results:ArrayCollection = new ArrayCollection();
		private const searchResponder:IResponder = new Responder(onSearchResult, onSearchFault);
		private const searchTimer:Timer = new Timer(DEFAULT_SEARCH_DELAY);
		private var _data:Object;
		public var arguments:Array;
		public var labelField:String;
		public var labelFunction:Function;
		private var _operation:AbstractOperation;
		private var _textInput:TextInput;
		private var lastSearch:String = "";
		private var menu:Menu;
		public function EntitySearcher()
		{
			super();
			results.sort = OrderSort.uniqueSort;
			results.addEventListener(CollectionEvent.COLLECTION_CHANGE, onResultsChange);
			searchTimer.addEventListener(TimerEvent.TIMER, onSearchTimer);
		}
		[Bindable(event = "dataChange")]
		public function get data():Object
		{
			return _data;	
		}
		public function set data(value:Object):void
		{
			if (!Equality.equal(_data, value))
			{
				_data = value;
				dispatchEvent(new FlexEvent(FlexEvent.DATA_CHANGE));
			}
		}
		[Bindable(event = "operationChange")]
		public function get operation():AbstractOperation
		{
			return _operation;
		}
		public function set operation(value:AbstractOperation):void
		{
			if (_operation != value)
			{
				_operation = value;
				startSearch();
				dispatchEvent(new Event("operationChange"));
			}
		}
		[Bindable(event = "searchDelayChange")]
		public function get searchDelay():uint
		{
			return searchTimer.delay;
		}
		public function set searchDelay(value:uint):void
		{
			if (searchTimer.delay != value)
			{
				searchTimer.delay = value;
				searchTimer.reset();
				startSearch();
				dispatchEvent(new Event("searchDelayChange"));
			}
		}
		public function set textInput(value:TextInput):void
		{
			if (_textInput != value)
			{
				if (_textInput != null)
				{
					_textInput.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
					_textInput.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
					_textInput.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown, true);
				}
				_textInput = value;
				results.removeAll();
				if (_textInput == null)
				{
					searchTimer.stop();
				}
				else
				{
					_textInput.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
					_textInput.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
					_textInput.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown, true);
					startSearch();
				}
			}
		}
		private function closeMenu():void
		{
			if (menu != null)
			{
				menu.hide();
				PopUpManager.removePopUp(menu);
		    	menu = null;
		 	}
		}
	    private function onAddedToStage(event:Event):void
	    {
	    	startSearch();
	    	if (results.length > 0)
	    		openMenu();
	    }
		private function onKeyDown(event:KeyboardEvent):void
		{
			switch (event.keyCode)
			{
				case Keyboard.DOWN :
				{
					event.stopImmediatePropagation();
					if (menu != null)
						menu.selectedIndex++;
					break;
				}
				case Keyboard.UP :
				{
					event.stopImmediatePropagation();
					if (menu != null)
						menu.selectedIndex--;
					break;
				}
				case Keyboard.ENTER :
				{
					if (menu != null && menu.selectedIndex >= 0)
					{
						data = menu.selectedItem;
						if (data != null)
						{
							event.stopImmediatePropagation();
							closeMenu();
							dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
						}
					}
					break;
				}
			}
		}
	    private function onMenuChange(event:MenuEvent):void
	    {
	    	if (event.menu == menu)
		    	data = menu.selectedItem;
		    else
		    	IEventDispatcher(event.currentTarget).removeEventListener(event.type, onMenuChange)
	    }
	    private function onMenuItemClick(event:MenuEvent):void
	    {
	    	if (event.menu == menu)
	    	{
		    	data = menu.selectedItem;
		    	dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
		    }
		    else
		    {
		    	IEventDispatcher(event.currentTarget).removeEventListener(event.type, onMenuItemClick)
		    }
	    }
	    private function onRemovedFromStage(event:Event):void
	    {
	    	closeMenu();
	    }
	    private function onResultsChange(event:CollectionEvent):void
	    {
	    	if (menu != null)
	    		menu.hide();
	    	if (results.length == 0)
	    		menu = null;
	    	else
	    		openMenu();
	    }
	    private function onSearchFault(event:FaultEvent, token:Object = null):void
	    {
	    	results.removeAll();
			closeMenu();
	    	trace("[SEARCH ERROR]", event.fault);
	    }
	    private function onSearchResult(event:ResultEvent, token:Object = null):void
	    {
	    	const disrupt:Boolean = menu == null || menu.selectedItem < 0;
	    	if (event.result is ArrayCollection && ArrayCollection(event.result).length > 0)
	    	{
		    	if (disrupt)
		    	{
			    	with (results)
			    	{
				    	source = ArrayCollection(event.result).source;
				    	refresh();
				    }
			    }
			    else
			    {
			    	for each (var result:Object in results)
			    	{
				    	with (results)
				    	{
				    		if (!contains(result))
				    			addItem(result);
				    	}
			    	}
			    }
			}
			else if (disrupt)
			{
				results.removeAll();
				closeMenu();
			}
	    }
		private function onSearchTimer(event:TimerEvent):void
		{
			if (_textInput == null || _textInput.stage == null || _operation == null)
			{
				searchTimer.stop();
				return;
			}
			const search:String = clean(_textInput.text).toLowerCase();
			if (search.length > 0 && (lastSearch == null || lastSearch.substr(0, search.length) != search))
			{
				lastSearch = search;
				try
				{
					if (this.arguments == null)
						_operation.arguments = [search];
					else
						_operation.arguments = this.arguments;
					_operation.send().addResponder(searchResponder);
				}
				catch (e:Error)
				{
					trace("[WARNING]", e.name + ": " + e.message);
				}
			}
		}
		private function openMenu():void
		{
			if (menu == null)
	    		menu = EntitySearchMenu.createMenu(_textInput, results, false);
    		menu.labelField = labelField;
    		menu.labelFunction = labelFunction;
    		var pos:Point = new Point(0, _textInput.height);
    		pos = _textInput.localToGlobal(pos);
    		menu.show(pos.x, pos.y);
    		menu.addEventListener(MenuEvent.CHANGE, onMenuChange, false, 0, true);
    		menu.addEventListener(MenuEvent.ITEM_CLICK, onMenuItemClick, false, 0, true);
		}
		private function startSearch():void
		{
			if (!searchTimer.running && searchTimer.delay > 0 && _textInput != null && _operation != null)
				searchTimer.start();
		}
	}
}