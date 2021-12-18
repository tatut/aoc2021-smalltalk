Class {
	#name : #Day18,
	#superclass : #DayInput,
	#instVars : [
		's',
		'p',
		'lastExplode'
	],
	#category : #AoC2021
}

{ #category : #parsing }
Day18 class >> parseInput: lines [
	^ lines 
]

{ #category : #solutions }
Day18 >> part1 [
	^ 
	((input collect: [:line | SnailfishNumber fromString: line])
	   reduce: [ :left :right | (left + right) reduce ]) magnitude
]

{ #category : #solutions }
Day18 >> part2 [
	| max |
	max := 0.
	input do: [ :a |
		input do: [ :b |
			a = b ifFalse: [ 
				| an bn |
				an := SnailfishNumber fromString: a.
				bn := SnailfishNumber fromString: b.
 			   max := max max: ((an + bn) reduce) magnitude.
			
				"need to parse again, as the numbers are horrible mutable things :P"
				an := SnailfishNumber fromString: a.
				bn := SnailfishNumber fromString: b.
				max := max max: ((bn + an) reduce) magnitude.
			]
		]].
	^ max

]
