package
{
	import com.canaan.lib.base.utils.CSVUtil;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class TestCsvUtil extends Sprite
	{
		private var urlLoader:URLLoader;
		private var obj:Object;
		
		public function TestCsvUtil()
		{
			urlLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, onComplete);
			urlLoader.load(new URLRequest("assets/test.csv"));
			
			stage.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onComplete(event:Event):void {
			obj = CSVUtil.CSVToObject(urlLoader.data);
			obj[1]["\",Name,\""] = ",,,,\"\"\"\"";
		}
		
		private function onClick(event:MouseEvent):void {
			var file:FileReference = new FileReference();
			var str:String = CSVUtil.ObjectToCSV(obj, ["Id", "\",Name,\""]);
			file.save(str, "test2.csv");
		}
	}
}