Class {
	#name : #Day9,
	#superclass : #DayInput,
	#category : #AoC2021
}

{ #category : #parsing }
Day9 class >> parseInput: lines [
	^ lines collect: [ :line | line asArray collect: [ :c | c asString asNumber ] ] 
]

{ #category : #accessing }
Day9 >> at: aPoint [
	^ (input at: aPoint y) at: aPoint x
]

{ #category : #accessing }
Day9 >> basinAt: lowPoint [
	"find basin at low given point"		
	| basin points |
	points := OrderedCollection with: lowPoint.
	basin := Set new.
	
	"while we have points to check"
	[ points isNotEmpty ] whileTrue: [ 
	  | p |
	  p := points removeFirst.
	  basin add: p.
	  p fourNeighbors select: [ :x | ((self inBounds: x) & (basin includes: x) not)  ifTrue: [(self at: x) < 9] ifFalse: false ] thenDo: [ :x | points add: x ].
	].
	
	^ basin
]

{ #category : #'ensure bounds' }
Day9 >> inBounds: p [
	^ (p x between: 1 and: input first size) & (p y between: 1 and: input size)
]

{ #category : #'as yet unclassified' }
Day9 >> lowPoints [ 
 	| maxx maxy |
	maxx := input first size.
	maxy := input size.

   ^ OrderedCollection streamContents: [ :out |
		1 to: maxx do: [ :x |
			1 to: maxy do: [ :y |
				| here adjacent |
				here := self at: x@y.
				adjacent := (x@y) fourNeighbors select: [ :p | self inBounds: p ].
				((adjacent collect: [ :p | self at: p ]) allSatisfy: [ :a | a > here ]) ifTrue: [ out nextPut: x@y ].
			]
		]]

]

{ #category : #solutions }
Day9 >> part1 [
	"sum all lowest points (+1)"			
	^ (self lowPoints collect: [ :p | (self at: p) + 1 ]) sum
]

{ #category : #solutions }
Day9 >> part2 [
	^ ((((self lowPoints collect: [ :p | self basinAt: p ]) collect: #size) 
	     sort: [ :a :b | a > b ]) copyFrom: 1 to: 3) reduce: [ :a :b | a * b ]
]
