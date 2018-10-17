import Foundation

class Card: NSObject {
	var color: Color
	var value: Value

	init (c: Color, v: Value)
	{
		self.color = c
		self.value = v
	}

	override var description: String
	{
		return ("The card is a \(value) from \(color)")
	}

	override func isEqual(_ object: Any?) -> Bool
	{
		if (object is Card)
		{
			let card = object as! Card
			return (self.value == card.value) && (self.color == card.color)
		}
		return (false)
	}
}