import UIKit

class MapLocationViewController: UIViewController, UISplitViewControllerDelegate {
    
 
    private var lastSeguedToMapViewController: MapViewController?
    

    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool{
        if let viewController = secondaryViewController as? MapViewController {
            if viewController.hospitalName == nil {
                return true
            }
        }
        return false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if splitViewController?.preferredDisplayMode != .primaryOverlay {
            splitViewController?.preferredDisplayMode = .primaryOverlay
        }
    }
    

    

    @IBAction func changeLocation(_ sender: Any) {
   
        if let mapViewController = splitViewDetailMapViewController {
            if mapViewController.hospitalName != (sender as? UIButton)?.currentTitle {
                     performSegue(withIdentifier: "Choose Location", sender: sender)
            }
            else if let mapViewController = lastSeguedToMapViewController {
                 navigationController?.pushViewController(mapViewController, animated: true)
            }
        } else {
            performSegue(withIdentifier: "Choose Location", sender: sender)
            
        }
    }
    
    private var splitViewDetailMapViewController: MapViewController? {
        return splitViewController?.viewControllers.last as? MapViewController
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Location" {
            if let hospitalName = (sender as? UIButton)?.currentTitle {
                if let mapViewController = segue.destination as? MapViewController {
                    mapViewController.hospitalName = hospitalName
                    UserDefaults.standard.set(hospitalName, forKey: "Hospital")
                         lastSeguedToMapViewController = mapViewController
                }
            }
        }
    }
    
}
