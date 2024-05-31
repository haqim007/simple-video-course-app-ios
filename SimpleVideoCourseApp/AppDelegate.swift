//
//  AppDelegate.swift
//  SimpleVideoCourseApp
//
//  Created by ADW Khaqim on 31/05/24.
//

import Foundation
import UIKit

class AppDelegate:
    NSObject, UIApplicationDelegate{
    
    static var orientationLock = UIInterfaceOrientationMask.portrait{
        didSet{
            if #available(iOS 16.0, *){
                UIApplication.shared.connectedScenes.forEach{scene in
                    if let windowscene = scene as? UIWindowScene{
                        windowscene.requestGeometryUpdate(.iOS(interfaceOrientations: orientationLock))
                    }
                }
                UIViewController.attemptRotationToDeviceOrientation()
            }else{
                if orientationLock == .landscape{
                    UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
                }else{
                    UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                }
            }
        }
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
}
