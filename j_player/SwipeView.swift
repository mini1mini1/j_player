//
//  SwipeView.swift
//  j_player
//
//  Created by Byunggil Min on 2020/08/19.
//  Copyright © 2020 Byungkil Min. All rights reserved.
//

import SwiftUI

struct SwipeView: View {
    @State private var offset: CGFloat = 0
    @State private var index = 0
    
    var users_ori = [UserMode(name:"민병길",hobby:"독서",image:Image("kitty"),age:42),
    UserMode(name:"민병현",hobby:"낚시",image:Image("flower"),age:40)]
    
    var users = [UserMode]()
    
    init() {
        for ele in users_ori {
        
        users.append(ele)
        }
    }
    
    
    
    
    
    
    
    let spacing: CGFloat = 10

    var body: some View {
        GeometryReader { geometry in
            return ScrollView(.horizontal, showsIndicators: true) {
                HStack(spacing: self.spacing) {
                    ForEach(self.users, id: \.id) { user in
                        UserView(userMode: user)
                            .frame(width: geometry.size.width)
                    }
                }
            }
            .content.offset(x: self.offset)
            .frame(width: geometry.size.width, alignment: .leading)
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        self.offset = value.translation.width - geometry.size.width * CGFloat(self.index)
                    })
                    .onEnded({ value in
                        if -value.predictedEndTranslation.width > geometry.size.width / 2, self.index < self.users.count - 1 {
                            self.index += 1
                        }
                        if value.predictedEndTranslation.width > geometry.size.width / 2, self.index > 0 {
                            self.index -= 1
                        }
                        withAnimation { self.offset = -(geometry.size.width + self.spacing) * CGFloat(self.index) }
                    })
            )
        }
    }
}

struct SwipeView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeView()
    }
}
