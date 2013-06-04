package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class HelloWorld extends Sprite
	{
		private var optionsXML:XML;
		private var xmlLoader:URLLoader;
		
		private var txt:Txt;
		
		private var num:int;
		private var u:Number;
		
		private var bmd:BitmapData;
		private var xyArr:Array;
		
		public function HelloWorld()
		{
			xmlLoader=new URLLoader();
			xmlLoader.addEventListener(Event.COMPLETE,loadXMLComplete);
			xmlLoader.load(new URLRequest("xml/options.xml"));
		}
		private function loadXMLComplete(...args):void{
			
			optionsXML=new XML(xmlLoader.data);
			
			num=int(optionsXML.num[0].toString());
			u=Number(optionsXML.u[0].toString());
			
			bmd=new BitmapData(this.loaderInfo.width,this.loaderInfo.height,true,0x00000000);
			this.addChild(new Bitmap(bmd));
			
			this.addChild(txt=new Txt());
			//txt.cacheAsBitmap=true;
			txt.mouseEnabled=txt.mouseChildren=false;
			
			xyArr=new Array(num);
			var i:int=num;
			while(--i>=0){
				xyArr[i]=[this.mouseX,this.mouseY];
			}
			
			this.addEventListener(Event.ENTER_FRAME,enterFrame);
			
		}
		private function enterFrame(...args):void{
			
			txt.x=this.mouseX;
			txt.y=this.mouseY;
			
			var m:Matrix=txt.transform.matrix;
			var ctf:ColorTransform=new ColorTransform();
			bmd.fillRect(bmd.rect,0x00000000);
			
			var i:int=num;
			while(--i>=0){
				
				m.a=m.d=1+i/num;
				m.tx=xyArr[i][0];
				m.ty=xyArr[i][1];
				
				ctf.alphaMultiplier=1-i/num;
				
				bmd.draw(txt,m,ctf);
				
				if(i>0){
					xyArr[i][0]+=(xyArr[i-1][0]-xyArr[i][0])*u;
					xyArr[i][1]+=(xyArr[i-1][1]-xyArr[i][1])*u;
				}else{
					xyArr[i][0]=this.mouseX;
					xyArr[i][1]=this.mouseY;
				}
				
			}
			
		}
	}
}