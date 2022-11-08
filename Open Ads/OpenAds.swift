//
//  OpenAds.swift
//  PhotoEditorForPassport
//
//  Created by Pawan iOS on 04/11/2022.
//

import Foundation
import UIKit
import GoogleMobileAds


class OpenAds: NSObject {
    
    static var openAdsClass  = OpenAds()
    
    var appOpenAd: GADAppOpenAd?
    var appOpenBool = false
    
    func requestAppOpenAd() {
        let controller = self
        let apUnitId = UserDefaults().bool(forKey: "isTesting") ? "ca-app-pub-3940256099942544/5662855259" : "ca-app-pub-3940256099942544/5662855259"
        let request = GADRequest()
        GADAppOpenAd.load(withAdUnitID: apUnitId,
                          request: request,
                          orientation: UIInterfaceOrientation.portrait,
                          completionHandler: { (appOpenAdIn, _) in
            self.appOpenAd = appOpenAdIn
            self.appOpenAd?.fullScreenContentDelegate = controller as? GADFullScreenContentDelegate
            print("Ad is ready")
        })
    }
    
    func tryToPresentAd() {
        
        if let gOpenAd = self.appOpenAd {
            gOpenAd.present(fromRootViewController: UIApplication.topViewController() ?? UIViewController())
        } else {
            self.requestAppOpenAd()
        }
    }
    
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        requestAppOpenAd()
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        requestAppOpenAd()
    }
    
}
