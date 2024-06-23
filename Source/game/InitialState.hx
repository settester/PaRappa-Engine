package game;

import flixel.FlxG;
import flixel.FlxState;

class InitialState extends FlxState {
	override function create() {
		runGame();
	}

	function runGame() {
		FlxG.switchState(game.gui.TitleOptions.new);
	}
}