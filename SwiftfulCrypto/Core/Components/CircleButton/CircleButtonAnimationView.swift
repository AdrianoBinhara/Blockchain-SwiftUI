//
//  CircleButtonAnimationView.swift
//  SwiftfulCrypto
//
//  Created by adriano dlucca on 11/05/24.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    
    @Binding var animate: Bool
    
    var body: some View {
    
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0.0 : 1.0)
            .transaction { transaction in
                transaction.animation = animate ? Animation.easeOut(duration: 1.0) : .none
            }
            .onAppear{
                animate.toggle()
            }
    }
}

#Preview {
    CircleButtonAnimationView(animate: .constant(false))
        .foregroundColor(.red)
        .frame(width: 100,height: 100)
}
