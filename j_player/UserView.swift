//
//  UserView.swift
//  j_player
//
//  Created by Byungkil Min on 2020/08/09.
//  Copyright © 2020 Byungkil Min. All rights reserved.
//

import SwiftUI

struct UserView: View {
    let userMode: UserMode
    
    var body: some View {
        ZStack(alignment: .leading) {
            AvatarView(image: userMode.image)
            NameView(name: userMode.name, age: userMode.age, hobby: userMode.hobby)
        }
        .shadow(radius: 12.0)
        .cornerRadius(12.0)
    }
    
    
}


struct UserView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        UserView(userMode: UserMode(name:"민병길",hobby:"독서",image:Image("kitty"),age:42))
        
    }
}
