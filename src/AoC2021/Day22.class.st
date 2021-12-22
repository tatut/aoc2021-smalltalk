Class {
	#name : #Day22,
	#superclass : #DayInput,
	#category : #AoC2021
}

{ #category : #parsing }
Day22 class >> parseInput: lines [
	^ lines collect: [ :line | Day22Step new fromString: line ]
]

{ #category : #solutions }
Day22 >> part1 [
	| on |
	"naive approach, just count all points"
   on := Set new.
	input do: [ :step |
		| points |
		points := step cuboid allPoints select: [ :p |
			((p at: 1) between: -50 and: 50) &
			((p at: 2) between: -50 and: 50) &
			((p at: 3) between: -50 and: 50) ].
		Transcript show: 'running step ', step asString;cr.
		step state = 1 
			ifTrue: [ on := on union: points ]
			ifFalse: [ on := on difference: points ]
	].
   ^ on size
]
