Class {
	#name : #Day11,
	#superclass : #DayInput,
	#category : #AoC2021
}

{ #category : #parsing }
Day11 class >> parseInput: lines [
	"parse to 100 item array"
	| input |
	input := Array2D new: 10.
	1 to: 10 do: [ :y |
		| line |
		line := lines at: y.
		1 to: 10 do: [ :x |
			input at: x at: y put: (line at: x) asString asNumber 
		]	
	].
	^ input
]

{ #category : #accessing }
Day11 >> at: aPoint update: aBlock [
	"update value at point"
	input at: aPoint x at: aPoint y put: (aBlock value: (input at: aPoint x at: aPoint y))
]

{ #category : #accessing }
Day11 >> atPoint: aPoint [
	"get energy level at point"
	^ input at: aPoint x at: aPoint y
]

{ #category : #accessing }
Day11 >> neighborsAt: aPoint update: aBlock [
	"update all neighbors at point"
	aPoint eightNeighbors do: [ :p |
		((p x between: 1 and: 10) & (p y between: 1 and: 10))
		ifTrue: [ 
			input at: p x at: p y	 put: (aBlock value: (input at: p x at: p y))
		]
	]
]

{ #category : #solutions }
Day11 >> part1 [
	| flashes |
	flashes := 0.
	100 timesRepeat: [ flashes := flashes + self step ].
	^ flashes
]

{ #category : #solutions }
Day11 >> part2 [
	| steps flashed |
	steps := 0.
	flashed := 0.
	[ flashed < 100 ] whileTrue: [ 
		steps := steps + 1.
		flashed := self step.
	].
	^ steps
]

{ #category : #printing }
Day11 >> printArray [ 
	Transcript cr; cr.
	1 to: 10 do: [:y |
		1 to: 10 do: [ :x |
			Transcript show: (self atPoint: x@y) asString 
		].
		Transcript cr.
	]
]

{ #category : #'as yet unclassified' }
Day11 >> selectPoints: aBlock [ 
	^ OrderedCollection streamContents: [ :out |
	   1 to: 10 do:[:x |
			1 to: 10 do:[:y |
				(aBlock value: x@y) ifTrue: [ out nextPut: x@y ]
		]]].
]

{ #category : #stepping }
Day11 >> step [
	"simulate one step"
	| flashes flashed points |
	flashes := 0.
	flashed := Set new.
	
	"increase energy of all"
	1 to: 10 do: [ :x |
		1 to: 10 do: [ :y |
			self at: x@y update: [:e | e + 1 ]
		]
	].

	"while there are >9 energy points that haven't flashed"
	points := self selectPoints: [ :p | (self atPoint: p) > 9 & (flashed includes: p) not ].
	[ points isNotEmpty ] whileTrue: [ 
		points do: [ :p | 
			flashed add: p.
			flashes := flashes + 1.
			self neighborsAt: p update: [ :e | e + 1 ] 
		].
		points := self selectPoints: [ :p | (self atPoint: p) > 9 & (flashed includes: p) not ].
	].

	flashed do: [ :p | self at: p update: [ :dummy | 0 ] ].
	^ flashes
	
]
