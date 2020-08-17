//
//  BottomBarView.swift
//  j_player
//
//  Created by Byungkil Min on 2020/08/10.
//  Copyright © 2020 Byungkil Min. All rights reserved.
//

import SwiftUI

struct BottomBarView: View {
    var body: some View {
        HStack {
            ViewFactory.button("back_icon", renderingMode: .template)
                .foregroundColor(.orange)
                .background(
                    GeometryReader { geometry in
                        Circle()
                            .offset(x: 2.5)
                            .foregroundColor(.white)
                            .shadow(color: .gray, radius: 12)
                            .frame(width: geometry.size.width * 1.5, height: geometry.size.height * 1.5)
                    }
            )
            Spacer()
            ViewFactory.button("close_icon", renderingMode: .template)
                .foregroundColor(.red)
                .background(
                    GeometryReader { geometry in
                        Circle().foregroundColor(.white)
                            .frame(width: geometry.size.width * 2, height: geometry.size.height * 2)
                            .shadow(color: .gray, radius: 12)
                    }
            )
            Spacer()
            ViewFactory.button("approve_icon", renderingMode: .template)
                .foregroundColor(.green)
                .background(
                    GeometryReader { geometry in
                        Circle()
                            .foregroundColor(.white)
                            .shadow(color: .gray, radius: 12)
                            .frame(width: geometry.size.width * 2, height: geometry.size.height * 2)
                    }
            )
            Spacer()
            ViewFactory.button("boost_icon", renderingMode: .template)
                .foregroundColor(.purple)
                .background(
                    GeometryReader { geometry in
                        Circle()
                            .foregroundColor(.white)
                            .shadow(color: .gray, radius: 12)
                            .frame(width: geometry.size.width * 1.5, height: geometry.size.height * 1.5)
                    }
            )
        }
        .padding([.leading, .trailing])
    }
}

struct BottomBarView_Previews: PreviewProvider {
    static var previews: some View {
        BottomBarView()
    }
}
