import UIKit
import WebKit


class WebController: UIViewController, WKUIDelegate {
    
    private var webView: WKWebView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string:"https://sundhedsdroner.dk/index.php?page=the-project")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
}
