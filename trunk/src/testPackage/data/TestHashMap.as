package testPackage.data
{
	import com.canaan.lib.base.data.hashMap.HashMap;
	
	import flash.display.Sprite;
	
	public class TestHashMap extends Sprite
	{
		public function TestHashMap()
		{
			var hashMap:HashMap = new HashMap();
			trace(hashMap.has("key1"));
			trace(hashMap.get("key1"));
			trace(hashMap.size);
			
			hashMap.put("key1", "value1");
			trace(hashMap.get("key1"));
			trace(hashMap.size);
			
			hashMap.put("key1", "value2");
			trace(hashMap.get("key1"));
			trace(hashMap.size);
			
			hashMap.put("key2", "value");
			trace(hashMap.get("key2"));
			trace(hashMap.size);
			
			hashMap.remove("key1");
			hashMap.remove("key2");
			
			trace(hashMap.get("key1"));
			trace(hashMap.get("key2"));
			trace(hashMap.size);
		}
	}
}