package runci.targets;

import runci.System.*;
import runci.Config.*;

class Macro {
	static public function run(args:Array<String>) {
		runCommand("haxe", ["compile-macro.hxml"].concat(args));

		changeDirectory(displayDir);
		haxelibInstallGit("Simn", "haxeserver");
		runCommand("haxe", ["build.hxml"]);

		changeDirectory(sourcemapsDir);
		runCommand("haxe", ["run.hxml"]);

		changeDirectory(nullSafetyDir);
		infoMsg("No-target null safety:");
		runCommand("haxe", ["test.hxml"]);
		infoMsg("Js-es6 null safety:");
		runCommand("haxe", ["test-js-es6.hxml"]);

		changeDirectory(getMiscSubDir());
		runCommand("haxe", ["compile.hxml"]);

		changeDirectory(getMiscSubDir("resolution"));
		runCommand("haxe", ["run.hxml"]);

		changeDirectory(sysDir);
		runSysTest("haxe", ["compile-macro.hxml"].concat(args));

		switch Sys.systemName() {
			case 'Linux':
				changeDirectory(getMiscSubDir('compiler_loops'));
				runCommand("haxe", ["run.hxml"]);
			case _: // TODO
		}

		changeDirectory(threadsDir);
		runCommand("haxe", ["build.hxml", "--interp"]);
	}
}
