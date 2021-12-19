Class {
	#name : #Day19Scanner,
	#superclass : #Object,
	#instVars : [
		'id',
		'seen',
		'position'
	],
	#category : #AoC2021
}

{ #category : #accessing }
Day19Scanner >> id [

	^ id
]

{ #category : #accessing }
Day19Scanner >> id: anObject [

	id := anObject
]

{ #category : #'as yet unclassified' }
Day19Scanner >> makeAbsolute: pos [
	position := pos.
	seen := seen collect: [ :p | p + pos ].
]

{ #category : #'as yet unclassified' }
Day19Scanner >> matchingBeacons: scanner [ 
	"try to find 12 matching beacons with this and other scanner.
	try each beacon in other scanner as a translation and see
	if that produces common beacons. 
	"
	Day19Point allOrientations do: [ :orientation | 
		seen do: [ :b1 |
			| rebasedSelf scan |
			rebasedSelf := self rebase: b1.
			scan := scanner orient: orientation .
			scan seen do: [ :b2 |
				"consider if b1 and b2 were the same, would we find other beacons at same points relative to it"
				| common seenCand |	
				seenCand := scan rebase: b2.
 				common := (rebasedSelf seen intersection: (seenCand seen)).
				common size >= 12 ifTrue: [  
					|pos|
				  "return scanner with orientation and position set, rebased to position"
					pos := b1 - b2.
					scan makeAbsolute: pos.
	 				^ scan
				]
			]
		].
	].
	^ nil
		
]

{ #category : #'as yet unclassified' }
Day19Scanner >> orient: orientation [
	^ self copy seen: (seen collect: [:p | p inOrientation: orientation] as: Set)
]

{ #category : #accessing }
Day19Scanner >> position [

	^ position
]

{ #category : #accessing }
Day19Scanner >> position: anObject [

	position := anObject
]

{ #category : #'as yet unclassified' }
Day19Scanner >> rebase: origin [
	"convert all points to have new origin"		
	^ self copy seen: (seen collect: [:p | p - origin] as: Set)
]

{ #category : #accessing }
Day19Scanner >> seen [

	^ seen
]

{ #category : #accessing }
Day19Scanner >> seen: anObject [

	seen := anObject
]
