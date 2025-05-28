//
//  HackerTextView.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 27.05.2025.
//

import SwiftUI
//.interpolate, speed: 0.01
struct HackerTextView: View {
    ///Config
    var text: String
    var trigger: Bool
    var transition: ContentTransition = .interpolate
    var duration: CGFloat = 1.0
    var speed: CGFloat = 0.1
    /// View Properties
    @State private var animatedText: String = ""
    @State private var randomCharacters: [Character] = {
        let string = "abcdefghijklmnopgrstuvwxyzABCDEFGHIJKLMNOPORSTUWVXYZ0123456789-?/#$@%!^&*()_+-=[]{}|<>"
        let characters =  Array(string)
        
        return characters
    }()
    @State private var animationID: String = UUID().uuidString
    
    @EnvironmentObject var localization: LocalizationManager
    var body: some View {
        Text(LocalizedStringKey(animatedText))
            .fontDesign(.monospaced)
            .truncationMode(.tail)
            .contentTransition(transition)
            .animation(.easeIn(duration: 0.1), value: animatedText)
            .onAppear{
                guard animatedText.isEmpty else {return}
                setRandomCharacters()
                animateText()
            }
            .customOnChange(value: trigger) { newValue in
                animateText()
            }
            .customOnChange(value: text) { newValue in
                animatedText = text
                setRandomCharacters()
                animationID = UUID().uuidString
                animateText()
            }
            .environment(\.locale, .init(identifier: localization.currentLanguage))
    }
    
    private func animateText(){
        let currentID = animationID
        for index in text.indices{
            let delay = CGFloat.random(in: 0...duration)
            var timerDuration: CGFloat = 0
            let timer = Timer.scheduledTimer(withTimeInterval: speed, repeats: true){ timer in
                if currentID != animationID{
                    timer.invalidate()
                } else {
                    timerDuration += speed
                    if timerDuration >= delay{
                        if text.indices.contains(index){
                            let actualCharacter = text[index]
                            replaceCharacter(at: index, character: actualCharacter)
                        }
                        timer.invalidate()
                    } else {
                        guard let randomCharacter = randomCharacters.randomElement() else { return }
                        replaceCharacter(at: index, character: randomCharacter)
                    }
                }
            }
            timer.fire()
        }
    }
    
    private func setRandomCharacters(){
        animatedText = text
        for index in animatedText.indices{
            guard let randomCharacters = randomCharacters.randomElement() else { return }
            replaceCharacter(at: index, character: randomCharacters)
        }
    }
    
    ///Changes Characters at given index
    func replaceCharacter(at index: String.Index, character: Character){
        guard animatedText.indices.contains(index) else { return }
        let indexCharacter = String(animatedText[index])
        
        if indexCharacter.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
            animatedText.replaceSubrange(index...index, with: String(character))
        }
    }
}


fileprivate extension View {
    @ViewBuilder
    func customOnChange<T: Equatable>(value: T, result: @escaping (T) -> ()) -> some View {
        if #available(iOS 17, *){
            self
                .onChange(of: value) { oldValue, newValue in
                    result(newValue)
                }
        } else {
            self
                .onChange(of: value, perform: { value in
                    result(value)
                })
        }
    }
}
