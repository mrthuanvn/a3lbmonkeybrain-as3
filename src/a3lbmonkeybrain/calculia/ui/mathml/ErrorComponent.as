package a3lbmonkeybrain.calculia.ui.mathml
{
	import mx.controls.Label;

	public final class ErrorComponent extends Label
	{
		public function ErrorComponent(cause:Object)
		{
			super();
			setStyle("color", 0xFF0000);
			try
			{
				if (cause is Error)
					text = Error(cause).name;
				else
					text = String(cause);
			}
			catch (e:Error)
			{
				text = e.name;
			}
		}
	}
}