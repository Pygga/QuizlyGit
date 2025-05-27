//
//  CodeBlock.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 27.05.2025.
//
import SwiftUI

struct CodeBlock: View {
    let text: String
    
    var body: some View {
        if text.isEmpty == false {
            VStack(alignment: .leading) {
                Text(highlightSyntax(text))
                    .font(.system(.caption, design: .monospaced))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
            }
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(.systemGray4), lineWidth: 1)
            )
        }
    }
    
    private func highlightSyntax(_ code: String) -> AttributedString {
//        let keywords = ["git", "checkout", "branch", "commit", "merge", "stash", "push", "pull", "reset"]
        let syntaxRules: [(pattern: String, color: Color)] = [
            ( #"(git\s+\w+)"#, .blue ), // Команды git
            ( #"\B--\w+"#, .orange ), // Длинные флаги
            ( #"\B-\w"#, .purple ), // Короткие флаги
            ( #"<[^>]+>"#, .green ), // Параметры
            ( #"\b[0-9a-f]{7,40}\b"#, .red ),// Хеши коммитов
//            (#"https?://\S+"#, .blue.underline), // URL
            ( #""(?:\\"|[^"])*""#, .yellow ) // Строковые литералы
        ]
        var attributedString = AttributedString(code)
//        attributedString[start..<end].foregroundColor = colorScheme == .dark ? rule.color : rule.color.opacity(0.8)
//        for rule in syntaxRules {
//            let ranges = code.ranges(
//                of: rule.pattern,
//                options: .regularExpression,
//                locale: nil
//            )
//            
//            for range in ranges {
//                guard let attrRange = Range(range, in: attributedString) else { continue }
//                attributedString[attrRange].foregroundColor = rule.color
//            }
//        }
        
        for rule in syntaxRules {
            guard let regex = try? NSRegularExpression(pattern: rule.pattern) else { continue }
            
            let matches = regex.matches(
                in: code,
                range: NSRange(code.startIndex..., in: code)
            )
            
            for match in matches {
                guard let codeRange = Range(match.range, in: code) else { continue }
                
                let startOffset = code.distance(from: code.startIndex, to: codeRange.lowerBound)
                let endOffset = code.distance(from: code.startIndex, to: codeRange.upperBound)
                
                guard let start = attributedString.characters.index(
                    attributedString.startIndex,
                    offsetBy: startOffset,
                    limitedBy: attributedString.endIndex
                ),
                      let end = attributedString.characters.index(
                        start,
                        offsetBy: endOffset - startOffset,
                        limitedBy: attributedString.endIndex
                      ) else { continue }
                
                attributedString[start..<end].foregroundColor = rule.color
            }
        }
        return attributedString
    }
}
