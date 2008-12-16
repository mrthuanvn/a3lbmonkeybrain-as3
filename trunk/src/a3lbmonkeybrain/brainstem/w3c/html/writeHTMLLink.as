package a3lbmonkeybrain.brainstem.w3c.html
{
	public function writeHTMLLink(text:String, uri:String, target:String = "_self"):String
	{
		XML.prettyPrinting = false;
		return XML(<a href={uri} target={target}><u>{text}</u></a>).toXMLString();
	}
}
