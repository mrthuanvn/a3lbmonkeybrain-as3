package a3lbmonkeybrain.brainstem.strings
{
	/**
	 * Converts a &quot;camel-humped&quot; name with a spaced name.
	 * <p>
	 * Conversion examples:
	 * </p>
	 * <table class="innertable">
	 * 	<tr>
	 * 		<th>Input</th>
	 * 		<th>Output</th>
	 * 	</tr>
	 * 	<tr>
	 * 		<td><code>&quot;DisplayObject&quot;</code></td>
	 * 		<td><code>&quot;Display Object&quot;</code></td>
	 * 	</tr>
	 * 	<tr>
	 * 		<td><code>&quot;URLRequest&quot;</code></td>
	 * 		<td><code>&quot;URL Request&quot;</code></td>
	 * 	</tr>
	 * 	<tr>
	 * 		<td><code>&quot;hasOwnProperty&quot;</code></td>
	 * 		<td><code>&quot;has Own Property&quot;</code></td>
	 * 	</tr>
	 * 	<tr>
	 * 		<td><code>&quot;name&quot;</code></td>
	 * 		<td><code>&quot;name&quot;</code></td>
	 * 	</tr>
	 * 	<tr>
	 * 		<td><code>&quot;URL&quot;</code></td>
	 * 		<td><code>&quot;URL&quot;</code></td>
	 * 	</tr>
	 * 	<tr>
	 * 		<td><code>&quot;12345&quot;</code></td>
	 * 		<td><code>&quot;12345&quot;</code></td>
	 * 	</tr>
	 * </table>
	 *  
	 * @param value
	 * 		&quot;Camel-humped&quot; string.
	 * @return 
	 * 		Spaced string.
	 */
	public function camelToSpaced(value:String):String
	{
		return value.replace(/([a-z])([A-Z])/g, "$1 $2").replace(/([A-Z])([A-Z][a-z])/g, "$1 $2");
	}
}
