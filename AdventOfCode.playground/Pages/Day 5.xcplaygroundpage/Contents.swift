import Foundation

let filepath = Bundle.main.path(forResource: "input", ofType: "txt")
let contents = try! String(contentsOfFile: filepath!)

let seats = contents.split(separator: "\n")

var maxId = 0
var minId = 850
var filledSeats: [Int] = []
seats.forEach { seat in
    let row = valueUsingBinarySpace(input: seat.prefix(7), lowerChar: "F", upperChar: "B")
    let column = valueUsingBinarySpace(input: seat.suffix(3), lowerChar: "L", upperChar: "R")
    let id = row * 8 + column
    if id > maxId { maxId = id }
    if id < minId { minId = id }
    print(maxId)
    
    filledSeats.append(id)
}

filledSeats.sort()
var previousSeatId = filledSeats[0] - 1
filledSeats.forEach {
    if $0 != previousSeatId + 1 { print(previousSeatId+1) }
    previousSeatId = $0
}

func valueUsingBinarySpace(input: Substring, lowerChar: Character, upperChar: Character) -> Int{
    
    let numOptions = Int(pow(2.0, Double(input.count)))
    if let first = input.first {
        let isInUpperHalf = first == upperChar
        let value = isInUpperHalf ? numOptions/2 : 0
        return value + valueUsingBinarySpace(input: input.dropFirst(), lowerChar: lowerChar, upperChar: upperChar)
    }
    
    return 0
}
