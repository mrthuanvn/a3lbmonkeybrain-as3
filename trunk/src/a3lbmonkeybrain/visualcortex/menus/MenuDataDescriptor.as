package a3lbmonkeybrain.visualcortex.menus
{
	import mx.collections.ArrayCollection;
	import mx.collections.ICollectionView;
	import mx.controls.menuClasses.IMenuDataDescriptor;

	public final class MenuDataDescriptor implements IMenuDataDescriptor
	{
		public function MenuDataDescriptor()
		{
			super();
		}
		public function addChildAt(parent:Object, newChild:Object, index:int, model:Object=null):Boolean
		{
			try
			{
				if (parent == null)
				{
					if (model.length <= index)
						model[length] = newChild;
					else 
						model[index] = newChild;
					return true;
				}
				if (MenuDataItem(parent).children == null)
					MenuDataItem(parent).children.removeAll();
				if (MenuDataItem(parent).children.length <= index)
					MenuDataItem(parent).children.addItem(newChild);
				else
					MenuDataItem(parent).children[index] = newChild;
			}
			catch (e:Error)
			{
				return false;
			}
			return true;
		}
		public function getChildren(node:Object, model:Object=null):ICollectionView
		{
			return MenuDataItem(node).children;
		}
		public function getData(node:Object, model:Object=null):Object
		{
			return node;
		}
		public function getGroupName(node:Object):String
		{
			return MenuDataItem(node).groupName;
		}
		public function getType(node:Object):String
		{
			return MenuDataItem(node).type;
		}
		public function hasChildren(node:Object, model:Object=null):Boolean
		{
			return isBranch(node, model) && MenuDataItem(node).children.length > 0;
		}
		public function isBranch(node:Object, model:Object=null):Boolean
		{
			return MenuDataItem(node).children != null;
		}
		public function isEnabled(node:Object):Boolean
		{
			return MenuDataItem(node).enabled;
		}
		public function isToggled(node:Object):Boolean
		{
			return MenuDataItem(node).toggled;
		}
		public function removeChildAt(parent:Object, child:Object, index:int, model:Object=null):Boolean
		{
			try
			{
				if (parent == null)
				{
					if (model[index] == child)
					{
						delete model[index];
						return true;
					}
				}
				else if (MenuDataItem(parent).children && MenuDataItem(parent).children[index] == child)
				{
					MenuDataItem(parent).children.removeItemAt(index);
					return true;
				}
			}
			catch (e:Error)
			{
				return false;
			}
			return false;
		}
		public function setEnabled(node:Object, value:Boolean):void
		{
			MenuDataItem(node).enabled = value;
		}
		public function setToggled(node:Object, value:Boolean):void
		{
			MenuDataItem(node).toggled = value;
		}
	}
}