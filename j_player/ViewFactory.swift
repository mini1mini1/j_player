//
//  ViewFactory.swift
//  j_player
//
//  Created by Byungkil Min on 2020/08/10.
//  Copyright © 2020 Byungkil Min. All rights reserved.
//

import SwiftUI

struct ViewFactory {
    static func button(_ name: String, renderingMode: Image.TemplateRenderingMode = .original) -> some View {
        Button(action: {}) {
            Image(name)
                .renderingMode(renderingMode)
        }
    }
}


