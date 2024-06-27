//
//  RandomColorModifier.swift
//  HiStock
//
//  Created by 송우진 on 6/26/24.
//

import SwiftUI

struct RandomColorModifier: ViewModifier {
    func body(content: Content) -> some View {
        let randomColors = [
            Color.orange,
            Color.pink,
            Color.yellow,
            Color.green
        ]
        
        content
            .padding(.vertical, 6)
            .padding(.horizontal, 8)
            .background(randomColors.randomElement())
            .cornerRadius(5)
    }
}

extension View {
    func randomBackgroundColor() -> some View {
        self.modifier(RandomColorModifier())
    }
}

#Preview {
    Text("테스트")
        .randomBackgroundColor()
}
