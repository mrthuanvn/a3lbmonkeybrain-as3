package a3lbmonkeybrain.calculia.ui.mathml
{
	import flash.events.Event;
	import flash.text.FontStyle;
	
	import mx.containers.Box;
	import mx.containers.BoxDirection;
	import mx.events.FlexEvent;
	
	import a3lbmonkeybrain.brainstem.resolve.XMLResolver;
	import a3lbmonkeybrain.brainstem.w3c.mathml.MathML;
	import a3lbmonkeybrain.brainstem.w3c.mathml.MathMLError;

	public class MathMLComponent extends Box
	{
		private var _operatorStyleResolver:XMLResolver;
		public function MathMLComponent(data:XML = null, operatorStyleResolver:XMLResolver = null)
		{
			super();
			addEventListener(FlexEvent.DATA_CHANGE, invalidateData);
			setStyle("horizontalAlign", "left");
			setStyle("horizontalGap", 0);
			setStyle("verticalAlign", "middle");
			setStyle("verticalGap", 0);
			this.data = data;
			this.operatorStyleResolver = operatorStyleResolver;
		}
		public function get errorStyle():OperatorStyle
		{
			const style:OperatorStyle = new OperatorStyle();
			style.colorString = getStyle("errorColor") ? Number(getStyle("errorColor")).toString(16) : "#FF0000";
			style.value = errorString ? errorString : "[ERROR]";
			return style;
		}
		public function get spaceStyle():OperatorStyle
		{
			const style:OperatorStyle = new OperatorStyle();
			style.value = " ";
			return style;
		}
		public function get operatorStyleResolver():XMLResolver
		{
			return _operatorStyleResolver;
		}
		public function set operatorStyleResolver(value:XMLResolver):void
		{
			if (_operatorStyleResolver != value)
			{
				_operatorStyleResolver = value;
				if (data is XML)
					invalidateData();
			}
		}
		protected final function addMathMLLabel(style:OperatorStyle, value:String = "value"):MathMLLabel
		{
			const text:String = style[value];
			if (text == null)
				return null;
			const label:MathMLLabel = new MathMLLabel();
			label.initialize();
			label.setStyle("color", style.color);
			if (style.fontFamily != null)
				label.setStyle("fontFamily", style.fontFamily);
			if (style.fontStyle != null)
			{
				label.setStyle("fontStyle",
					(style.fontStyle == FontStyle.BOLD_ITALIC || style.fontStyle == FontStyle.ITALIC)
					? "italic" : "regular");
				label.setStyle("fontWeight",
					(style.fontStyle == FontStyle.BOLD || style.fontStyle == FontStyle.BOLD_ITALIC)
					? "bold" : "regular");
			}
			label.htmlText = text;
			label.validateNow();
			addChild(label);
			return label;
		}
		protected final function addMathMLComponent(xml:XML):MathMLComponent
		{
			const component:MathMLComponent = new MathMLComponent(xml, _operatorStyleResolver);
			component.initialize();
			addChild(component);
			return component;
		}
		protected final function invalidateData(event:Event = null):void
		{
			if (stage == null)
			{
				addEventListener(Event.ADDED_TO_STAGE, validateData, false, int.MAX_VALUE);
			}
			else
			{
				addEventListener(Event.RENDER, validateData, false, int.MAX_VALUE);
				stage.invalidate();
			}
		}
		protected function renderApply(style:OperatorStyle):void
		{
			const nArgs:int = XML(data).children().length() - 1;
			if (nArgs < 1)
			{
				addMathMLLabel(errorStyle);
				return;
			}
			var operationStyle:OperatorStyle
				= _operatorStyleResolver.resolveXML(XML(data).children()[0]) as OperatorStyle;
			if (operationStyle == null)
				operationStyle = errorStyle;
			else if (operationStyle.value == null)
				operationStyle.value = XML(data).localName().toString();
			const dynamicOperator:Boolean = XML(data).children()[0].name() == MathML.APPLY;
			if (dynamicOperator)
				operationStyle.form = OperatorStyleForm.PREFIX;
			var argXML:XML = XML(data).copy();
			delete argXML.children()[0];
			switch (operationStyle.form)
			{
				case OperatorStyleForm.FENCE :
				{
					renderStructure(operationStyle, argXML);
					break;
				}
				case OperatorStyleForm.POSTFIX :
				{
					if (nArgs == 1)
						addMathMLComponent(argXML.children()[0]);
					else
						renderStructure(style, argXML);
					addMathMLComponent(XML(data).children()[0]);
					break;
				}
				case OperatorStyleForm.INFIX :
				{
					if (nArgs == 1)
					{
						addMathMLComponent(XML(data).children()[0]);
						addMathMLComponent(argXML.children()[0]);
					}
					else
					{
						if (subexpressionsRequireFence(data as XML))
							addMathMLLabel(style, "lValue");
						for (var i:int = 0; i < nArgs; ++i)
						{
							if (i != 0)
								addMathMLComponent(XML(data).children()[0]);
							addMathMLComponent(argXML.children()[i]);
						}
						if (subexpressionsRequireFence(data as XML))
							addMathMLLabel(style, "rValue");
					}
					break;
				}
				case OperatorStyleForm.PREFIX :
				{
					addMathMLComponent(XML(data).children()[0]);
					if (nArgs == 1 && !dynamicOperator)
						addMathMLComponent(argXML.children()[0]);
					else
						renderStructure(style, argXML);
					break;
				}
				default :
				{
					throw new MathMLError("No style for element: " + XML(data).children()[0]);
				}
			}
		}
		protected function renderData():void
		{
			removeAllChildren();
			if (data is XML && _operatorStyleResolver != null)
			{
				const style:OperatorStyle = operatorStyleResolver.resolveXML(data as XML) as OperatorStyle;
				if (style == null)
				{
					direction = BoxDirection.HORIZONTAL;
					addMathMLLabel(errorStyle);
				}
				else
				{
					direction = OperatorStyleDir.isVertical(style.dir) ? BoxDirection.VERTICAL
						: BoxDirection.HORIZONTAL;
					if (QName(XML(data).name()).uri == MathML.NAMESPACE.uri)
					{
						switch (XML(data).name().toString())
						{
							case MathML.APPLY.toString() :
							{
								renderApply(style);
								return;
							}
							case MathML.CI.toString() :
							case MathML.CN.toString() :
							{
								style.value = XML(data).text();
								addMathMLLabel(style);
								return;
							}
							case MathML.CSYMBOL.toString() :
							{
								if (style.value == null)
									style.value = XML(data).text();
								addMathMLLabel(style);
								return;
							}
							case MathML.BVAR.toString() :
							case MathML.CONDITION.toString() :
							case MathML.DECLARE.toString() :
							case MathML.LIST.toString() :
							case MathML.MATH.toString() :
							case MathML.OTHERWISE.toString() :
							case MathML.PIECE.toString() :
							case MathML.SET.toString() :
							case MathML.VECTOR.toString() :
							{
								renderStructure(style, data as XML);
								return;
							}
							case MathML.PIECEWISE.toString() :
							{
								direction = BoxDirection.HORIZONTAL;
								addMathMLLabel(style, "lValue");
								style.lValue = null;
								const piecewise:MathMLComponent = new MathMLComponent();
								piecewise.operatorStyleResolver = _operatorStyleResolver;
								piecewise.direction = BoxDirection.VERTICAL;
								piecewise.renderStructure(style, data as XML);
								addChild(piecewise);
								addMathMLLabel(style, "rValue");
								return;
							}
							default :
							{
								if (style.value == null)
									style.value = XML(data).localName().toString();
							}
						}
					}
					if (XML(data).children().length() > 0)
						renderStructure(style, data as XML);
					else
						addMathMLLabel(style);
				}
			}
		}
		protected function renderStructure(style:OperatorStyle, xml:XML):void
		{
			if (style.form == OperatorStyleForm.FENCE)
				var lField:MathMLLabel = addMathMLLabel(style, "lValue");
			const n:int = xml.children().length();
			for (var i:int = 0; i < n; ++i)
			{
				if (i != 0)
					addMathMLLabel(style, "separator");
				addMathMLComponent(xml.children()[i]);
			}
			validateNow();
			if (style.form == OperatorStyleForm.FENCE)
				var rField:MathMLLabel = addMathMLLabel(style, "rValue");
			/*
			if (lField != null)
			{
				if (direction == BoxDirection.VERTICAL)
					lField.width = width;// / lField.width;
				else
					lField.height = height;// / lField.height;
			}
			if (rField != null)
			{
				if (direction == BoxDirection.VERTICAL)
					rField.width = width;// / rField.width;
				else
					rField.height = height;// / rField.height;
			}
			*/
		}
		protected function subexpressionsRequireFence(xml:XML):Boolean
		{
			if (xml.parent().name() == MathML.APPLY)
				return !OperatorStyle(_operatorStyleResolver.resolveXML(xml.parent().children()[0])).reln;
			return false;
		}
		private function validateData(event:Event):void
		{
			removeEventListener(event.type, validateData);
			renderData();
		}
	}
}