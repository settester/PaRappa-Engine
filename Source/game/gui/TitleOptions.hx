package game.gui;

import flixel.ui.FlxButton;
import haxe.macro.Compiler;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.addons.display.FlxGridOverlay;
import flixel.FlxState;

class TitleOptions extends FlxState {
	final cellsX = Std.parseInt(Compiler.getDefine('horizontal_cells_quantity'));
	final cellsY = Std.parseInt(Compiler.getDefine('vertical_cells_quantity'));

	override function create() {
		var cellSize = Math.floor(FlxG.width / 16);

		var bg = FlxGridOverlay.create(cellSize, cellSize, -1, FlxG.height + Std.int(FlxG.height / cellsY), true, 0xFFF8BDA2, 0xFFC4E699);
		add(bg);

		var box = new FlxSprite().makeGraphic(FlxG.width - cellSize * 2, FlxG.height - cellSize * 2, 0xFFFF60F7);
		box.screenCenter();
		box.alpha = 0.7;
		add(box);

		var language = new FlxButton(box.x + 30, box.y + 40, 'LANGUAGE', () -> {
			trace('LANGUAGE: placeholder function');
		});
		language.setGraphicSize(150, 100);
		language.updateHitbox();
		add(language);
	}
}