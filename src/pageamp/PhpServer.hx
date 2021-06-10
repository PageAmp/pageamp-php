package pageamp;

import php.Global;
import php.Lib;
import php.Syntax;

using StringTools;


class PhpServer {

	public static function main() {
		var root:String = Syntax.code("$_SERVER['DOCUMENT_ROOT']");
		var domain:String = Syntax.code("$_SERVER['HTTP_HOST']");
		var uri:String = Syntax.code("$_SERVER['REQUEST_URI']").split('?')[0];
		//TODO GET/POST params
		var query:String = Syntax.code(
			"isset($_SERVER['QUERY_STRING']) ? $_SERVER['QUERY_STRING'] : NULL");
		uri.endsWith('/') ? uri = uri.substr(0, uri.length - 1) : null;
		var re = ~/^[^\.]+\.(.+)$/;
		var ext = re.match(uri) ? re.matched(1) : null;
		if (ext == null) {
			/*if (Global.file_exists(root + uri + '.html')) {
				uri = uri + '.html';
			} else*/ if (Global.is_dir(root + uri)) {
				uri = uri + '/index.html';
			} else {
				uri = uri + '.html';
			}
		}
		try {
			var page = Server.load(root, uri, domain, true);
			Syntax.code("header('Content-type: text/html')");
			Lib.print(page.doc.toString());
		} catch (ex:Dynamic) {
			Syntax.code("header('Content-type: text/plain')");
			Lib.print('' + ex);
		}
	}

}
