Class {
	#name : #Day15,
	#superclass : #DayInput,
	#category : #AoC2021
}

{ #category : #parsing }
Day15 class >> parseInput: lines [
	^ DayInput parseLinesToArray2D: lines 
]

{ #category : #'as yet unclassified' }
Day15 >> lowestRiskPathFrom: start to: goal [ 
	^ (Day15ArrayPath withInput: input) findPathFrom: start to: goal


]

{ #category : #solutions }
Day15 >> part1 [
 	^ self riskForBestPath 

	
]

{ #category : #solutions }
Day15 >> part2 [
	| largeInput cols rows |
	cols := input columnCount .
	rows := input rowCount .
	largeInput := Array2D rows: rows * 5 columns: cols * 5.
	
	0 to: 4 do: [ :r |
		0 to: 4 do: [ :c |
			| x y |
 			x := c * cols + 1. "start x to copy to"
			y := r * rows + 1. "start y to copy to"
			largeInput 
				atRows:  y to: (y + rows - 1) 
				columns: x to: (x + cols - 1)
				put: (input collect: [ :v | 
					| val |
					val := v + r + c.
					val > 9 ifTrue: [ val % 9 ] ifFalse: [val]
				]).
					 ]].
	input := largeInput.
	
 	^ self riskForBestPath
]

{ #category : #'as yet unclassified' }
Day15 >> pathRisk: aPath [
	^ (aPath allButFirst collect: [ :p | self riskAt: p ]) sum
]

{ #category : #accessing }
Day15 >> riskAt: aPoint [
	^ input at: aPoint y at: aPoint x.
]

{ #category : #'as yet unclassified' }
Day15 >> riskForBestPath [
	^ self pathRisk: (self lowestRiskPathFrom: 1@1 to: (input extent))

]
