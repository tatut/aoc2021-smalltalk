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
	"find lowest risk path from start to end"
	| openSet cameFrom gScore fScore gs fs |
	
	openSet := OrderedCollection with: start. 
	cameFrom := Dictionary new.
	gScore := Dictionary new.
	gScore at: start put: 0.
	fScore := Dictionary new.
	fScore at: start put: 0. "start is not entered, so has zero cost"
	
	gs := [ :p | gScore at: p ifAbsent: 9999999 ].
	fs := [ :p | fScore at: p ifAbsent: 9999999 ].
	
	[ openSet isEmpty ] whileFalse: [ 
		| current |
		openSet sort: [ :a :b | (fs value: a) < (fs value: b) ].
		current := openSet removeFirst.
		current = goal 
			ifTrue: [
				| path prev |
				path := OrderedCollection with: current.
			   prev := cameFrom at: current ifAbsent: nil.
			   [ prev isNotNil ] whileTrue: [ 
					path addFirst: prev.
					prev := cameFrom at: prev ifAbsent: nil.
				].
      			^ path ]
			ifFalse: [ 
				(self neighborsAt: current) do: [ :neighbor |
					| tentative_gScore |
					tentative_gScore := (gs value: current) + (self riskAt: neighbor).
					tentative_gScore < (gs value: neighbor)
						ifTrue: [ 
							 "This path to neighbor is better than any previous one. Record it!"
		                cameFrom at: neighbor put: current.
		                gScore at: neighbor put: tentative_gScore.
		                fScore at: neighbor put: tentative_gScore + (self riskAt: neighbor).
		                (openSet includes: neighbor) ifFalse: [ openSet add: neighbor ].
						] 
				].
			].
	].
	NotFound signal: 'No path found.'


]

{ #category : #accessing }
Day15 >> neighborsAt: point [
	| len |
	len := input extent .
	^ point fourNeighbors select: [ :p | (p x between: 1 and: len x) & (p y between: 1 and: len y) ]
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

{ #category : #printing }
Day15 >> printPath: path [
	1 to: input rowCount do: [ :y |
		Transcript cr.
		1 to: input columnCount do: [ :x |
			(path includes: x@y)
				ifTrue: [ Transcript show: '*' ]
				ifFalse: [ Transcript show: (input at: y at: x) asString]
		]
	].
	
]

{ #category : #accessing }
Day15 >> riskAt: aPoint [
	^ input at: aPoint y at: aPoint x.
]

{ #category : #'as yet unclassified' }
Day15 >> riskForBestPath [
	^ self pathRisk: (self lowestRiskPathFrom: 1@1 to: (input extent))

]
