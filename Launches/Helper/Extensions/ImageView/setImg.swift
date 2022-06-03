//
//  setImg.swift
//  Launches
//
//  Created by Ömer Faruk Varoğlu on 2.06.2022.
//

import Foundation
import Kingfisher
import UIKit

func setImg(image: UIImageView?, imgLink: String) -> (){
    let url = URL(string: imgLink)
    
    image!.kf.indicatorType = .activity
    image!.kf.setImage(
        with: url,
        placeholder: UIImage(named: "starship"),
        options: [
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(1)),
            .cacheOriginalImage
        ])
}
func setImgWithCompletion(image: UIImageView?, imgLink: String, success: @escaping (_ isEmpty: Bool? )->()) -> (){
    //    let url = URL(string: imgLink)
    let url : String = imgLink
    let urlStr : String = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    let convertedURL : URL = URL(string: urlStr)!
    print(convertedURL)
    
    image!.kf.indicatorType = .activity
    image!.kf.setImage(
        with: convertedURL,
        placeholder: nil,
        options: [
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(1)),
            .cacheOriginalImage
        ])
}
