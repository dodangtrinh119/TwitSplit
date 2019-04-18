//
//  TưitSplitStrategy.swift
//  TwitSplit-Zalora
//
//  Created by Đăng Trình on 4/17/19.
//  Copyright © 2019 Dang Trinh. All rights reserved.
//

import UIKit

struct TwitSplitResult {
    
    var errorMessage: String?
    var result:[String] = []
    
    func isSplitSuccess() -> Bool {
        if errorMessage == nil {
            return true
        }
        return false
    }
    
}

//Use strategy pattern for easy extend, when we need another split just implementation TwitSplitStrategy procotol, no need to change so much.
protocol TwitSplitStrategy {
    
    func splitMessage(message: String, limit: Int) -> TwitSplitResult
    
}


struct TwitSplitZalora: TwitSplitStrategy {
    
    func splitMessage(message: String, limit: Int) -> TwitSplitResult {
        
        var result = TwitSplitResult()
        // Remove redudant white space and lines
        let components = message.components(separatedBy: .whitespacesAndNewlines)
        let filterMessage = components.filter { !$0.isEmpty }.joined(separator: " ")
        
        // Return message if its length is less than or equal limit
        if (filterMessage.count <= limit) {
            result.result = [filterMessage]
            return result
        }
        
        let totalPartial: Int = (filterMessage.count / limit) + (filterMessage.count % limit > 0 ? 1 : 0)
        let words = filterMessage.components(separatedBy: .whitespacesAndNewlines)
        
        // Check error, if available words have length that greater than limit
        let errorWords = words.filter { return $0.count > limit }
        
        // Return error if the length is great than limit and contains non-whitespace
        if !errorWords.isEmpty {
            result.errorMessage = "The message contains a span of non-whitespace characters longer than \(limit) characters"
            return result
        }
        // Return message
        return tryToSplitToPart(wordArray: words, totalPart: totalPartial, limitChar: limit)

    }
    
    func tryToSplitToPart(wordArray: [String], totalPart: Int, limitChar: Int) -> TwitSplitResult {
        var splitResult = TwitSplitResult()
        var breakAt: Int = -1
        //init string
        for part in 0..<totalPart {
            var component: String = (part+1).description + "/" + totalPart.description + " "
            for wordIndex in 0..<wordArray.count {
                if wordIndex <= breakAt {
                    continue
                }
                
                if canAppendWithLimit(content: component, add: wordArray[wordIndex], limit: limitChar) {
                    component = component + wordArray[wordIndex] + " "
                }
                else {
                    break
                }
                breakAt = wordIndex;
            }
            splitResult.result.append(component)
        }
        if (breakAt < wordArray.count - 1) {
            splitResult.result.removeAll()
            splitResult = tryToSplitToPart(wordArray: wordArray, totalPart: totalPart + 1, limitChar: limitChar);
        }
        return splitResult
    }
    
    func canAppendWithLimit(content: String, add: String, limit: Int) -> Bool {
        let tempString = content + add + " "
        if tempString.count <= limit {
            return true
        }
        return false
    }
    
}
