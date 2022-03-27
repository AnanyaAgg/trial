//
//  ContentView.swift
//  Guessing Game
//
//  Created by Ananya Aggarwal on 2/27/22.
//

import SwiftUI

var numberToGuess=0
var lowRange=0
var highRange=100
var totalGuesses=10
var guessesUsed=0

struct ContentView: View {
   @State var gameName="Guessing Game"
   @State var topText="hi"
   @State var guessCountLabel="5"
   @State var nextGuess="5"
   @State var buttonLabel="Submit"
   @State var gameOn=true

    var body: some View {
        VStack {
            Text(gameName)
                .font(.system(size: 50))
            Spacer()
            Text(topText)
                .font(.system(size: 40))
            Text(guessCountLabel)
                .font(.system(size: 40))
            Spacer()
            TextField("Next Guess", text: $nextGuess)
                .font(.system(size: 40))
            Spacer()
            Button(buttonLabel){
                if let l = Int(nextGuess){
                    processGuess(l)
                }
            }
                .font(.system(size: 40))
                .padding()
                           .background(.yellow)
                           .clipShape(Capsule())
            Spacer()
            
        }.onAppear(perform: initializeGame)
    }
    
    func processGuess(_ i:Int) {
        guessesUsed += 1
        if i == numberToGuess {
            processMatch()
        }else{
            processNoMatch(i)
        }
    }
    
    func updateGuessInfo() {
        guessCountLabel = "Tries Remaining: \(totalGuesses - guessesUsed)"
        topText = "What is x? \n \(lowRange) < x < \(highRange)"
    }
    
    func processMatch() {
        print("Match")
        topText = "You correctly guessed \(numberToGuess) in \(guessesUsed) attempts"
        nextGuess = ""
        guessCountLabel = ""
        buttonLabel = "Well done!"
    }
    
    func processNoMatch(_ i:Int) {
        print("No Match")
        if guessesUsed >= totalGuesses{
            processFailed()
            return
        }
        if i < numberToGuess {
            lowRange = i
        }else{
            highRange = i
        }
        updateGuessInfo()
    }
    
    func processFailed() {
        print("Finish All Attempts")
    }
    
    
    func generateRandomNumber() {
           numberToGuess = Int.random(in: lowRange ... highRange)
           print("Generated random number:",numberToGuess)
    }
    func initializeGame() {
           generateRandomNumber()
           lowRange=0
           highRange=100
           totalGuesses=10
           guessesUsed=0
           topText="Guess x\n \(lowRange) < x < \(highRange)"
           guessCountLabel=""
           nextGuess=""
           buttonLabel="Submit"
           gameOn=true
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
