package a3lbmonkeybrain.calculia.ui.mathml
{
	import mx.resources.IResourceBundle;
	
	import a3lbmonkeybrain.brainstem.resolve.UnresolvableXML;
	import a3lbmonkeybrain.brainstem.resolve.XMLResolver;
	import a3lbmonkeybrain.brainstem.w3c.mathml.MathML;

	public final class ResourceBundleOperatorStyleResolver implements XMLResolver
	{
		private var resourceBundle:IResourceBundle;
		private var baseStyle:OperatorStyle = null;
		public function ResourceBundleOperatorStyleResolver(resourceBundle:IResourceBundle)
		{
			super();
			this.resourceBundle = resourceBundle;
			baseStyle = createStyleForKey("default");
		}
		private function createStyleForKey(key:String):OperatorStyle
		{
			const style:OperatorStyle = new OperatorStyle(baseStyle);
			style.colorString = getString(key, "color");
			style.dir = getString(key, "dir");
			style.fontFamily = getString(key, "fontFamily");
			style.fontStyle = getString(key, "fontStyle");
			style.form = getString(key, "form");
			style.lValue = getString(key, "lValue");
			style.reln = getBoolean(key, "reln");
			style.rValue = getString(key, "rValue");
			style.separator = getString(key, "separator");
			style.value = getString(key, "value");
			return style;
		}
		private function getBoolean(key:String, attribute:String):Boolean
		{
			const fullKey:String = key + "." + attribute;
			if (resourceBundle.content.hasOwnProperty(fullKey))
				return resourceBundle.content[fullKey] == "true";
			return false;
		}
		private function getNumber(key:String, attribute:String):Number
		{
			const fullKey:String = key + "." + attribute;
			if (resourceBundle.content.hasOwnProperty(fullKey))
				return parseFloat(resourceBundle.content[fullKey]);
			return 0.0;
		}
		private function getString(key:String, attribute:String):String
		{
			const fullKey:String = key + "." + attribute;
			if (resourceBundle.content.hasOwnProperty(fullKey))
				return String(resourceBundle.content[fullKey]);
			return null;
		}
		public function resolveXML(xml:XML):Object
		{
			if (QName(xml.name()).uri == MathML.NAMESPACE.uri)
				return createStyleForKey(xml.localName().toString());
			return new UnresolvableXML(xml);
		}
	}
}