package
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	public class Txt extends Sprite
	{
		public function Txt()
		{
			var txt:TextField=new TextField();
			txt.autoSize=TextFieldAutoSize.LEFT;
			txt.text="Hello World!";
			this.addChild(txt);
			txt.x=-txt.width/2;
			txt.y=-txt.height/2;
		}
	}
}