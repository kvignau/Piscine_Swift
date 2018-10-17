print("allColors -> ")
for color in Color.allColors {
    print(color)
}
print("\nallValues -> ")
for value in Value.allValues
{
    print(value)
}

let Three = Value.Three
let Spade = Color.Spade
let Ace = Value.Ace
let Queen = Value.Queen

let rawSpade = Color.Spade.rawValue
let rawKing = Value.King.rawValue

print("\nThe \(Three) of \(Spade) is weaker than the \(Ace) and the \(Queen).\nAs we can see the raw values are string type for Color -> \(rawSpade) and int type for Value -> \(rawKing)")