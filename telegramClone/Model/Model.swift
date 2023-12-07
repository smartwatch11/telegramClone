//
//  Model.swift
//  telegramClone
//
//  Created by Egor Rybin on 18.06.2023.
//

import Foundation
import UIKit

enum AuthResponse{
    case success, noVerify, error
}

struct Slides {
    var id: Int
    var text: String
    var image: UIImage
}


struct LoginField{
    var email: String
    var password: String
}


struct ResponseCode {
    var code: Int
}

struct CurrentUser {
    var id: String
    var email: String
}
