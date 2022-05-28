//
//  MBProgAnimate.swift
//  Financial_Calc_II
//
//  Created by a-robota on 4/27/22.
//

// for MBProgressHUD --> to show and hide animations
// --> set for any instance for UIViewController




import Foundation
import MBProgressHUD

// MARK Protocols for UIViewController [show/hide loading animiation]

protocol MBProgAnimate where Self: UIViewController {
    
    func showLoadingAnimation()
    func hideLoadingAnimation()
}

extension MBProgAnimate {
    func showLoadingAnimation(){
        print("MBProgress: loading animation")
        DispatchQueue.main.async {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
    }
    
    
    func hideLoadingAnimation() {
        print("MBProgress: hiding animation")
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
}



