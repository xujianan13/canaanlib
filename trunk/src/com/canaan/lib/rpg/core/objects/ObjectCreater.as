package com.canaan.lib.rpg.core.objects
{
	import com.canaan.lib.base.core.ObjectPool;
	import com.canaan.lib.rpg.core.constants.ObjectCategory;
	import com.canaan.lib.rpg.core.model.objects.AbstractObjectVo;

	public class ObjectCreater
	{
		public static function createObject(objectVo:AbstractObjectVo):AbstractObject {
			var object:AbstractObject;
			var objectClass:Class = getObjectClass(objectVo);
			if (objectClass != null) {
				object = ObjectPool.getObject(objectClass) as AbstractObject;
				object.vo = objectVo;
			}
			return object;
		}
		
		private static function getObjectClass(objectVo:AbstractObjectVo):Class {
			var clazz:Class;
			switch (objectVo.category) {
				case ObjectCategory.PLAYER:
					clazz = PlayerObject;
					break; 
				case ObjectCategory.NPC:
					clazz = NpcObject;
					break;
				case ObjectCategory.MONSTER:
					clazz = MonsterObject;
					break;
				case ObjectCategory.PET:
					clazz = PetObject;
					break;
				case ObjectCategory.DROP_GOODS:
					clazz = DropGoodsObject;
					break;
				case ObjectCategory.TRANSFER_POINT:
					clazz = TransferPointObject;
					break;
			}
			return clazz;
		}
	}
}