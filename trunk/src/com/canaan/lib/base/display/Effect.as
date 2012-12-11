package com.canaan.lib.base.display
{
	import flash.filters.ColorMatrixFilter;

	public class Effect
	{
		public static const GRAY_FILTER:ColorMatrixFilter = new ColorMatrixFilter([	
				0.3086,	0.6094, 0.0820, 0,	0,
				0.3086, 0.6094, 0.0820, 0,	0,
				0.3086, 0.6094, 0.0820, 0,	0,
				0,		0,		0,		1,	0
		]);
	}
}