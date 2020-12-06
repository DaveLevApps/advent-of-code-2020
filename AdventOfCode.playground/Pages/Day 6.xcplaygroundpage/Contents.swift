import Foundation

let filepath = Bundle.main.path(forResource: "input", ofType: "txt")
let contents = try! String(contentsOfFile: filepath!)

let lines = contents.split(separator: "\n", maxSplits: Int.max, omittingEmptySubsequences: false)

var groups: [String] = [""]
lines.forEach {
    if $0.isEmpty { return groups.append("") }
    if var last = groups.last {
        if !last.isEmpty { last += "\n" }
        groups[groups.count-1] = last + $0
    }
}


groups[0]
groups[1]
groups[2]
countCommonLettersBetweenLines(in: groups[0])
countCommonLettersBetweenLines(in: groups[1])
countCommonLettersBetweenLines(in: "w")


var totalUnique = 0
var totalCommon = 0
groups.forEach {
    totalUnique += countUniqueLetters(in: $0)
    totalCommon += countCommonLettersBetweenLines(in: $0)
}

totalUnique
totalCommon

func countUniqueLetters(in input: String) -> Int {
    let inputSet = Set(input.unicodeScalars)
    var count = 0
    inputSet.forEach {
        if CharacterSet.letters.contains($0) {
            count += 1
        }
    }
    return count
}

func countCommonLettersBetweenLines(in input: String) -> Int {
    if input.isEmpty { return 0 }
    
    let lines = input.split(separator: "\n")
    
    var allPossibleAnswers = Set("abcdefghijklmnopqrstuvwxyz")
    lines.forEach {
        allPossibleAnswers.formIntersection(Set($0))
    }
    
    return allPossibleAnswers.count
}
