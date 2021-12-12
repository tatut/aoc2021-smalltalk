Class {
	#name : #Day12,
	#superclass : #DayInput,
	#category : #AoC2021
}

{ #category : #parsing }
Day12 class >> parseInput: lines [
	| d add |
	d := Dictionary new.
	add := [ :from :to |
		d at: from update: [ :c | c add: to; yourself  ] initial: [(Set with: to)]
	].
	lines do: [ :line |
 		| caves |
		caves := line splitOn: $-.
		add value: (caves at: 1) value: (caves at: 2).
		add value: (caves at: 2) value: (caves at: 1).
	].
	^ d
		
]

{ #category : #testing }
Day12 >> isBig: cave [
	^ cave allSatisfy: #isUppercase
]

{ #category : #solutions }
Day12 >> part1 [
 	"find all paths from start-end"
	| paths |
	paths := OrderedCollection new.
	self pathFrom: (OrderedCollection with: 'start') found: paths.
	^ paths size

]

{ #category : #solutions }
Day12 >> part2 [
 	"find all paths from start-end, visiting a single small cave twice"
	| paths smallCaves |
	paths := Set new.
	
	smallCaves := Set withAll: (input keys reject: [:c | self isBig: c]).
	smallCaves removeAll: #('start' 'end').
	
	smallCaves do: [ :c |
		self pathFrom: (OrderedCollection with: 'start') 
			smallCaveTwice: c
			found: paths.			
	].
	^ paths size

]

{ #category : #solutions }
Day12 >> pathFrom: path  found: result [
	^ self pathFrom: path 
		smallCaveTwice: nil
		found: result 
]

{ #category : #solutions }
Day12 >> pathFrom: path smallCaveTwice: twiceCave found: result [
	"returns set of paths from path (array of visited) to end."		
	| at visited |
	at := path last.
	visited := Set withAll: path.
	
	^ (input at: at)
		select: [ :c | 
 			(self isBig: c) 
				ifTrue: [  
					| cp |
					"go to big cave only if it has paths we havent visited yet"
					cp := Set withAll: (input at: c).
					path overlappingPairsDo: [ :bigCave :to | 
						(c = bigCave) ifTrue: [ cp remove: to ifAbsent: nil ]	
					].
					cp isNotEmpty 
				]
				ifFalse: [ 
					(twiceCave = c & ((path occurrencesOf: c) < 2)) | (visited includes: c) not]]
		thenDo: [ :c | 
			| p |
 			p := OrderedCollection withAll: path.
			p add: c.

			(c = 'end') 
				ifTrue: [ result add: p ]
				ifFalse: [ self pathFrom: p smallCaveTwice: twiceCave found: result ]
			]
]
