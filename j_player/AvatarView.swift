//
//  AvatarView.swift
//  j_player
//
//  Created by Byungkil Min on 2020/08/09.
//  Copyright © 2020 Byungkil Min. All rights reserved.
//

import SwiftUI

struct AvatarView: View {
    let image: Image
    
    var body: some View {
        image
            .resizable()
            .overlay(
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [.clear, .black]),
                                         startPoint: .center, endPoint: .bottom))
                    .clipped()
        )
            .cornerRadius(12.0)
    }
}


