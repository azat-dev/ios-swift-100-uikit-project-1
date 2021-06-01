//
//  Picture.swift
//  Project1
//
//  Created by Azat Kaiumov on 01.06.2021.
//

import UIKit

class Picture: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
