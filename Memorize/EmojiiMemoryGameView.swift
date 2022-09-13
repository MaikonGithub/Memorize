//
//  EmojiiMemoryGameView.swift
//  Memorize
//
//  Created by Maikon Ferreira on 03/12/21.
//

import SwiftUI

struct EmojiiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiiMemoryGame
    
    var body: some View {
        VStack {
            Grid(viewModel.cards) { card in
                CardView(Card: card).onTapGesture {
                    withAnimation(.linear) {
                        viewModel.choose(card: card)
                    }
                }
                .padding(5)
            }
            .padding()
            .foregroundColor(Color.blue)
            Button(action: {
                withAnimation(.easeInOut){
                    self.viewModel.resetGame()
                }
            }, label: { Text("NEW GAME") })
        }
    }
}

struct CardView: View {
    var Card: MemoryGame<String>.Card
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = Card.bonusTimeRemaining
        withAnimation(.linear(duration: Card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if Card.FaceUp || !Card.Matched {
            ZStack {
                if Card.isConsumingBonusTime {
                    Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-Card.bonusTimeRemaining*360-90), clockwise: true)
                        .padding(5.5).opacity(0.4)
                        .onAppear {
                            self.startBonusTimeAnimation()
                        }
                } else {
                    Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90), clockwise: true)
                        .padding(5.5).opacity(0.4)
                }
                
                Text(Card.Content)
                    .font(Font.system(size: fontSize(for: size)))
                
                
                
                
                
            }
            .cardify(FaceUp: Card.FaceUp)
            .transition(AnyTransition.scale)
        }
    }
    
    //MARK: - Drawing Constants
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
}
















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiiMemoryGameView(viewModel: game)
        
            .previewInterfaceOrientation(.portrait)
    }
}
