//
//  NetworkReachability.swift
//  MRMovie
//
//  Created by User on 5/24/24.
//

import UIKit
import Alamofire

class NetworkReachability {
    
    static let shared = NetworkReachability()
    let reachabilityManager = NetworkReachabilityManager(host: "www.google.com")
    
    private lazy var offlineAlertController: UIAlertController = {
        let offlineAlertController = UIAlertController(title: "Notice", message: "The Internet Connection appears to be offline", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                }
        offlineAlertController.addAction(okAction)
        return offlineAlertController
    }()
    
    func showOfflineAlert() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let rootViewController = windowScene.windows.first?.rootViewController
            rootViewController?.present(offlineAlertController, animated: true, completion: nil)
        }
    }
    
    func dismissOfflineAlert() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let rootViewController = windowScene.windows.first?.rootViewController
            rootViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    func startNetworkMonitoring() {
        reachabilityManager?.startListening { status in
            switch status {
            case .notReachable:
                self.showOfflineAlert()
            case .reachable(.cellular):
                self.dismissOfflineAlert()
            case .reachable(.ethernetOrWiFi):
                self.dismissOfflineAlert()
            case .unknown:
                print("Unknown network state")
            }
        }
    }
}
