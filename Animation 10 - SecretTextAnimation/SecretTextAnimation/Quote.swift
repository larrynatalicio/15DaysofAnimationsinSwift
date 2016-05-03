//
//  Quote.swift
//  SecretTextAnimation
//
//  Created by Larry Natalicio on 4/27/16.
//  Copyright © 2016 Larry Natalicio. All rights reserved.
//

import UIKit

class Quote {
    
    // MARK: - Properties
    
    var quote: String
    var author: String
    var image: UIImage
    
    // MARK: - Initializers
    
    init(quote: String, author: String, image: UIImage) {
        self.quote = quote
        self.author = author
        self.image = image
    }
}