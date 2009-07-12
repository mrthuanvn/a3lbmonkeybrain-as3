package a3lbmonkeybrain.hippocampus.ui.search
{
	import a3lbmonkeybrain.visualcortex.menus.MenuDataItem;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import mx.controls.Menu;
	import mx.core.EventPriority;
	import mx.core.FlexGlobals;
	import mx.core.UIComponent;
	import mx.core.UIComponentGlobals;
	import mx.core.mx_internal;
	import mx.effects.Tween;
	import mx.events.MenuEvent;
	import mx.managers.PopUpManager;

	use namespace mx_internal;
	
	/**
	 * Duration of the opening animation, in milliseconds.
	 */
	[Style(name = "openDuration", type = "uint")]
	/**
	 * Popup menu for an entity search.
	 * 
	 * @author T. Michael Keesey
	 * @see EntitySearcher
	 */
	public final class EntitySearchMenu extends Menu
	{		
		/**
		 * Creates a new instance.
		 */
		public function EntitySearchMenu()
		{
			super();
		}
		[Bindable(event = "selectedIndexChange")]
		/**
		 * @inheritDoc 
		 */		
		override public function get selectedIndex():int
		{
			return super.selectedIndex;
		}
		/**
		 * @private
		 */		
		override public function set selectedIndex(value:int):void
		{
			if (super.selectedIndex != value)
			{
				super.selectedIndex = value;
				dispatchEvent(new Event("selectedIndexChange"));
			}
		}
	    /**
	     * Creates a new instance and pops it up.
	     *  
	     * @param parent
	     * 		The parent for the popup window.
	     * @param menuDataProvider
	     * 		The data provider for the new menu.
	     * @param showRoot
	     * 		If <code>true</code>, shows the root data object of the data provider.
	     * @return
	     * 		New instance of <code>EntitySearchMenu</code>.
	     * @see #dataProvider
	     * @see #popUpMenu()
	     */
	    public static function createMenu(parent:DisplayObjectContainer, menuDataProvider:Object,
	    	showRoot:Boolean = true):EntitySearchMenu
	    {
	        var menu:EntitySearchMenu = new EntitySearchMenu();
	        menu.tabEnabled = false;
	        menu.owner = DisplayObjectContainer(FlexGlobals.topLevelApplication);
	        menu.showRoot = showRoot;
	        popUpMenu(menu, parent, menuDataProvider);
	        return menu;
	    }
	    /**
	     * @private
	     */
	    private function isMouseOverMenu(event:MouseEvent):Boolean
	    {
	        var target:DisplayObject = DisplayObject(event.target);
	        while (target)
	        {
	            if (target is Menu)
	                return true;
	            target = target.parent;
	        }
	
	        return false;
	    }
	    /**
	     * @private
	     */
	    private static function menuHideHandler(event:MenuEvent):void
	    {
	        const menu:EntitySearchMenu = EntitySearchMenu(event.currentTarget);
	        if (!event.isDefaultPrevented() && event.menu == menu)
	        {
	            PopUpManager.removePopUp(menu);
	            menu.removeEventListener(MenuEvent.MENU_HIDE, menuHideHandler);
	        }
	    }
	    /**
	     * @private
	     */
	    private function mouseDownOutsideHandler(event:MouseEvent):void
	    {
	        if (!isMouseOverMenu(event))
	            hideAllMenus();
	    }
	    /**
	     * Pops up a menu.
	     *  
	     * @param menu
	     * 		Menu to pop up.
	     * @param parent
	     * 		The parent for the popup window.
	     * @param menuDataProvider
	     * 		The data provider for the new menu.
	     */
	    public static function popUpMenu(menu:EntitySearchMenu, parent:DisplayObjectContainer,
	    	menuDataProvider:Object = null):void
	    {
	        menu.parentDisplayObject = parent ?parent : DisplayObject(FlexGlobals.topLevelApplication);
	        if (menuDataProvider == null)
	            menuDataProvider = new MenuDataItem();
	        menu.supposedToLoseFocus = true;
	        menu.dataProvider = menuDataProvider;
	    }
	    /**
	     * @inheritDoc
	     */
	    override public function show(xShow:Object = null, yShow:Object = null):void
	    {
	        if (collection && collection.length == 0)
	            return;
	        if (parentMenu && !parentMenu.visible)
	            return;
	        if (visible)
	            return;
	        if (parentDisplayObject && parent != parentDisplayObject)
	        {
	            PopUpManager.addPopUp(this, parentDisplayObject, false);
	            addEventListener(MenuEvent.MENU_HIDE, menuHideHandler, false, EventPriority.DEFAULT_HANDLER);
	        }
	        const menuEvent:MenuEvent = new MenuEvent(MenuEvent.MENU_SHOW);
	        menuEvent.menu = this;
	        menuEvent.menuBar = sourceMenuBar;
	        getRootMenu().dispatchEvent(menuEvent);
	        systemManager.activate(this);
	        if (xShow !== null && !isNaN(Number(xShow)))
	            x = Number(xShow);
	        if (yShow !== null && !isNaN(Number(yShow)))
	            y = Number(yShow);
	        if (this != getRootMenu())
	        {
	            var shift:Number = x + width - screen.width;
	            if (shift > 0)
	                x = Math.max(x - shift, 0);
	            shift = y + height - screen.height;
	            if (shift > 0)
	                y = Math.max(y - shift, 0);
	        }
	        UIComponentGlobals.layoutManager.validateClient(this, true);
	        setActualSize(getExplicitOrMeasuredWidth(), getExplicitOrMeasuredHeight());
	        cacheAsBitmap = true;
	        const duration:Number = getStyle("openDuration");
	        if (duration != 0)
	        {
		        scrollRect = new Rectangle(0, 0, unscaledWidth, 0);
		        visible = true;
		        UIComponentGlobals.layoutManager.validateNow();
		        UIComponent.suspendBackgroundProcessing();
		        popupTween = new Tween(this, [0,0], [unscaledWidth,unscaledHeight], duration);
	        }
	        else 
	        {
				UIComponentGlobals.layoutManager.validateNow();
				visible = true;
	        }
	        //focusManager.setFocus(this);
	        //supposedToLoseFocus = true;
	        systemManager.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownOutsideHandler, false, 0,
	        	true);
	    }
	}
}