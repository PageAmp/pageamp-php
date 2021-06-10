package pageamp;

import js.Syntax;

using StringTools;
using pageamp.lib.DomTools;


class PhpClient {

	public static function main() {
		var doc = DomTools.domDefaultDoc();
		var pageProps = Syntax.code('window.pageampProps');
		Client.load(doc, pageProps);
	}

}
