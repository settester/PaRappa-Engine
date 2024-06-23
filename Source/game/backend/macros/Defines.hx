package game.backend.macros;

class Defines {
	public static macro function run():Array<haxe.macro.Expr.Field> {
		var defines = haxe.Json.parse(sys.io.File.getContent('defines.json'));

		for (flag in Reflect.fields(defines)) {
			var value = Std.string(Reflect.field(defines, flag));
			haxe.macro.Compiler.define(flag, value);
		}

		return haxe.macro.Context.getBuildFields();
	}
}