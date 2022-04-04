//
//  CommonExtensions.swift
//  VM Directory
//
//  Created by Prasad on 02/04/22.
//

import UIKit

extension UIViewController {
    func setUpNavigationBar(title: String,
                            isBackButtonEnabled: Bool = false) {
        navigationController?.navigationBar.isHidden = false
        
        self.title = title
        navigationController?.navigationBar.backgroundColor = Theme.primaryBrandColor.rawValue.getColorForString()
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Theme.primaryTextColor.rawValue.getColorForString()]
        navigationController?.navigationBar.tintColor = Theme.primaryTextColor.rawValue.getColorForString()
        
        if isBackButtonEnabled {
            let backButton = UIBarButtonItem()
            backButton.title = "Back"
            navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        }
    }
}

extension String {
    func getColorForString() -> UIColor {
        hexStringToUIColor(hex: self)
    }
    
    func hexStringToUIColor(hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}


extension UIView {
    
    func makeCircle() {
        layer.cornerRadius = frame.width/2
        layer.borderWidth = 2
        layer.borderColor = UIColor.black.cgColor
    }

    func dropShadow() {
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 3)
        layer.masksToBounds = false
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 1
        layer.rasterizationScale = UIScreen.main.scale
        layer.shouldRasterize = true
    }
}

extension UILabel {
    func applyBrandColor() {
        textColor = Theme.primaryBrandColor.rawValue.getColorForString()
    }
}

extension UIImageView {
    public func imageFromServerURL(urlString: String, defaultImage : String? = "user_placeholder") {
        if let di = defaultImage {
            self.image = UIImage(named: di)
        }
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }
}
