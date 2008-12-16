package a3lbmonkeybrain.hippocampus.text
{
	import a3lbmonkeybrain.brainstem.core.findClassName;
	import a3lbmonkeybrain.brainstem.metadata.MetadataUtil;
	import a3lbmonkeybrain.brainstem.strings.camelToSpaced;
	import a3lbmonkeybrain.brainstem.strings.en.findIndefiniteArticle;
	import a3lbmonkeybrain.brainstem.strings.en.pluralize;
	
	import flash.utils.describeType;
	
	public final class Description
	{
		public function Description()
		{
			super();
			throw new TypeError();
		}
		private static function findDefaultLabel(entityOrClass:Object, labelType:String = "title",
			format:String = "text"):String
		{
			const label:String = formDefaultLabel(camelToSpaced(
				findClassName(entityOrClass)), labelType);
			return format == Format.HTML_TEXT ? label : Format.htmlTextToText(label);
		}
		public static function findLabel(entity:Object, labelType:String = "title",
			format:String = "text"):String
		{
			if (entity == null)
				return "";
			const type:XML = describeType(entity);
			const labels:XMLList = type.metadata.(@name == "Label");
			if (labels.length() > 0)
			{
				var htmlText:String = MetadataUtil.fixXMLTextValue(
					MetadataUtil.getArgValue(labels[0] as XML, labelType,
					labelType == LabelType.TITLE) as String);
				if (htmlText == null || htmlText.length == 0)
				{
					htmlText = formDefaultLabel(findLabel(entity, LabelType.TITLE, Format.HTML_TEXT),
						labelType);
				}
				if (htmlText != null && htmlText.length > 0)
					return format == Format.HTML_TEXT ? htmlText : Format.htmlTextToText(htmlText);
			}
			return findDefaultLabel(entity, labelType, format);
		}
		public static function findLabelForClass(entityClass:Class, labelType:String = "title",
			format:String = "text"):String
		{
			try
			{
				return findLabel(new entityClass(), labelType, format);
			}
			catch (e:Error)
			{
				trace("[WARNING]", e.name + ": " + e.message);
			}
			return findDefaultLabel(entityClass, labelType, format);
		}
		public static function findText(entity:Object, format:String = "text"):String
		{
			if (entity == null)
				return "";
			const type:XML = describeType(entity);
			const descriptions:XMLList = type.metadata.(@name == "Description");
			if (descriptions.length() > 0)
			{
				const htmlText:String = MetadataUtil.fixXMLTextValue(
					MetadataUtil.getArgValue(descriptions[0] as XML, "htmlText", true) as String);
				return format == Format.HTML_TEXT ? htmlText : Format.htmlTextToText(htmlText);
			}
			return "";
		}
		public static function findTextForClass(entityClass:Class, format:String = "text"):String
		{
			try
			{
				return findText(new entityClass(), format);
			}
			catch (e:Error)
			{
				trace("[WARNING]", e.name + ": " + e.message);
			}
			return "";
		}
		private static function formDefaultLabel(defaultValue:String, type:String):String
		{
			switch (type)
			{
				case LabelType.PLURAL :
				{
					return pluralize(Format.htmlTextToText(defaultValue));
				}
				case LabelType.WITH_ARTICLE :
				{
					return findIndefiniteArticle(Format.htmlTextToText(defaultValue))
						+ " " + defaultValue;
				}
			}
			return defaultValue;
		}
		public static function processTokens(s:String, entityOrClass:Object, format:String = "text"):String
		{
			if (entityOrClass is Class)
				entityOrClass = new entityOrClass();
			return s.replace(/%withArticle/g, findLabel(entityOrClass, LabelType.WITH_ARTICLE, format))
				.replace(/%title/g, findLabel(entityOrClass, LabelType.TITLE, format))
				.replace(/%plural/g, findLabel(entityOrClass, LabelType.PLURAL, format));
		}
	}
}