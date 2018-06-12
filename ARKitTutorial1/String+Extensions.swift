//
//  String+Extensions.swift
//  ARKitTutorial1
//
//  Created by Yogesh Kohli on 6/11/18.
//  Copyright © 2018 Yogesh Kohli. All rights reserved.
//

import UIKit

extension String {
    
    //Converts string to image so that emojis can be used as images
    func image() -> UIImage? {
        let size = CGSize(width: 30, height: 35)
        UIGraphicsBeginImageContextWithOptions(size, false, 0);
        UIColor.clear.set()
        let rect = CGRect(origin: CGPoint(), size: size)
        UIRectFill(CGRect(origin: CGPoint(), size: size))
        (self as NSString).draw(in: rect, withAttributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 30)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}
