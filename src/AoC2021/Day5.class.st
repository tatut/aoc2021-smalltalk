Class {
	#name : #Day5,
	#superclass : #DayInput,
	#category : #AoC2021
}

{ #category : #parsing }
Day5 class >> parseLine: aString [
   | points |
	points := (aString splitOn: ' -> ') 
	  collect: [ :p | 
		| coords |
		 coords := (p splitOn: $,) collect: [ :n | n asNumber ].
		 Point x: (coords at: 1) y: (coords at: 2)
		 ].
	^ Line from: (points at: 1) to: (points at: 2)
]

{ #category : #solutions }
Day5 >> part1 [
	| pointOccurances |
	pointOccurances := Dictionary new.
	
   input select: [ :line | (line isVertical | line isHorizontal) ] thenDo: [ :line |
	  line points do: [ :p | 
		pointOccurances at: p update: [ :c | c + 1 ] initial: 1 ]
	].

   ^ (pointOccurances select: [ :c | c > 1 ]) size
]

{ #category : #solutions }
Day5 >> part2 [
	| pointOccurances |
	pointOccurances := Dictionary new.
	
   input do: [ :line |
	  line points do: [ :p | 
		pointOccurances at: p update: [ :c | c + 1 ] initial: 1 ]
	].

   ^ (pointOccurances select: [ :c | c > 1 ]) size
]

{ #category : #printing }
Day5 >> printDiagram [		
		"print diagram like in the puzzle description"	
	| ps maxx maxy dg |
	dg := [ 0 to: maxy do: [ :y |
		0 to: maxx do: [ :x |
			| c |
			c := ps at: x@y ifAbsent: [ $. ].
			Transcript show: c asString.].
		Transcript cr.	 ].
		Transcript cr; cr.].
		
	ps := Dictionary new.
	maxx := 0.
	maxy := 0.
	input do: [ :line |
		line points do: [ :p |
			maxx := maxx max: p x.
			maxy := maxy max: p y.
			ps at: p update: [ :c | c + 1 ] initial: 1.
 			].
	   dg value 
	].

]
