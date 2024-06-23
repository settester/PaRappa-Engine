package game.backend;

import flixel.sound.FlxSound;
import flixel.FlxG;
import flixel.graphics.FlxGraphic;

class Assets {
	public static var currentLevel:String;

	public static function withoutLibrary(path:String):String {
		var splitted = path.split(':');
		return splitted[1] ?? splitted[0];
	}

	// #region GETTING ASSETS




	public static function path(key:String):String {
		if (currentLevel != null) {
			var levelPath = '$currentLevel:assets/$currentLevel/$key';
			if (openfl.Assets.exists(levelPath)) return levelPath;

			// handling runtime added assets
			#if (debug && sys)
			levelPath = 'assets/$currentLevel/$key';
			if (sys.FileSystem.exists(levelPath)) return levelPath;
			#end
		}
		return 'shared:assets/shared/$key';
	}

	public static function image(key:String):FlxGraphic {
		for (ext in [
			'png',
			'jpg', 'jpeg'
		]) {
			var graphic = returnGraphic(path('images/$key.$ext'));
			if (graphic != null) return graphic;
		}
		return null;
	}

	public static function music(key:String):FlxSound {
		for(ext in [
			#if web
			'mp3'
			#else
			'ogg',
			'wav'
			#end
		]) {
			var sound = returnSound(path('music/$key.$ext'));
			if (sound != null) return sound;
		}
		return null;
	}

	public static function sound(key:String):FlxSound {
		for(ext in [
			#if web
			'mp3'
			#else
			'ogg',
			'wav'
			#end
		]) {
			var sound = returnSound(path('sounds/$key.$ext'));
			if (sound != null) return sound;
		}
		return null;
	}

	// #region INTERNAL FUNCTIONS




	static function returnGraphic(path:String):FlxGraphic {
		if (openfl.Assets.exists(path)) return FlxG.bitmap.add(path);
		// handling runtime added assets
		#if (debug && sys)
		path = withoutLibrary(path);
		if (sys.FileSystem.exists(path)) {
			var bitmap = openfl.display.BitmapData.fromFile(path);
			return FlxG.bitmap.add(bitmap);
		}
		#end
		return null;
	}

	static function returnSound(path:String):FlxSound {
		if (openfl.Assets.exists(path)) return FlxG.sound.load(path);
		// handling runtime added assets
		#if (debug && sys)
		path = withoutLibrary(path);
		if (sys.FileSystem.exists(path)) {
			var sound = openfl.media.Sound.fromFile(path);
			return FlxG.sound.load(sound);
		}
		#end
		return null;
	}
}