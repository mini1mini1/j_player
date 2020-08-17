//
//  NavigationView.swift
//  j_player
//
//  Created by Byungkil Min on 2020/08/10.
//  Copyright © 2020 Byungkil Min. All rights reserved.
//

import SwiftUI

struct NavigationView: View {
    var body: some View {
        HStack {
            ViewFactory.button("profile_icon")
            Spacer()
            ViewFactory.button("fire_icon")
                .scaleEffect(2)
            Spacer()
            ViewFactory.button("chat_icon")
        }
    }
}

struct NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView()
    }
}
