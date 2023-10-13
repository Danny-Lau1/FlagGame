//
//  ContentView.swift
//  Flag Game
//
//  Created by Danny Lau on 10/6/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var totalScore = 0
    
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled() // make the flags random everytime
    
    @State var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [.blue, .red], startPoint:.top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack{
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                Spacer()
                VStack (spacing: 30){
                    VStack{
                        Text("Tap the flag of")
                            .foregroundColor(.black)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .foregroundColor(.black)
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3){ number in
                        Button {
                            flagTapped(number: number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .shadow(radius: 10)
                        }
                    }
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                            .padding(.vertical, 20)
                            .background(.regularMaterial)
                            .clipShape(.rect(cornerRadius: 20))
                Spacer()
                Text("Score: \(totalScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQuestion)
        }message: {
            Text("Your Score is \(totalScore)")
        }
        
    }
    // we need a function that tell us if we tapped the correct flag. this function will accpet the 'number' in the ForEach. It reads the number (0, 1, or 2) and checks if it matches the var correctAnswer (0, 1, or 2)
    
    func flagTapped(number: Int){
        // number comes
        if number == correctAnswer{
            scoreTitle = "You are right!"
            totalScore += 1
        } else{
            scoreTitle = "You are wrong."
        }
        showingScore = true
    }
    
    // used to restart the game
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
