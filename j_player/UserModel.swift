//
//  UserModel.swift
//  j_player
//
//  Created by Byungkil Min on 2020/08/09.
//  Copyright © 2020 Byungkil Min. All rights reserved.
//

import SwiftUI

struct UserMode {
    var id = UUID()
    
    var name: String
    var hobby: String
    var image: Image
    var age: Int
    
    init(name: String, hobby: String, image: Image, age: Int) {
        
        self.name = name
        self.hobby = hobby
        self.image = image
        self.age = age
    }
    

}

var um = UserMode(name:"민병길",hobby:"독서",image:Image("kitty"),age:42)


