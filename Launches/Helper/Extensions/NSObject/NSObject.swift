//
//  NSObject.swift
//  Launches
//
//  Created by Ömer Faruk Varoğlu on 2.06.2022.
//

import Foundation

extension NSObject {
    class var nameOfClass: String {
        return String(describing: self)
    }
}
