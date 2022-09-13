//
//  Cardify.swift
//  Memorize
//
//  Created by Maikon Ferreira on 03/12/21.
//

import SwiftUI

struct Cardify: ViewModifier, Animatable {
    var rotation: Double
    
    init(FaceUp: Bool) {
        rotation = FaceUp ? 0 : 180
    }
    
    var FaceUp: Bool {
        rotation < 90
    }
    
    var animatableData: Double {
        get { return rotation }
        set { rotation = newValue }
    }
   
    func body(content: Content) -> some View {
        ZStack {
            if FaceUp {
                RoundedRectangle(cornerRadius: cornerRadious).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadious).stroke(lineWidth: edgeLineWidth)
                content
            
        } else {
            RoundedRectangle(cornerRadius: 10.0).fill(Color.blue)
        }
    }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0,1,0))
}
           
  private let cornerRadious: CGFloat = 10.0
  private let edgeLineWidth: CGFloat = 5
    
}

extension View {
    func cardify(FaceUp: Bool) -> some View {
        self.modifier(Cardify(FaceUp: FaceUp))
    }
}



    
