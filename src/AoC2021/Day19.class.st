Class {
	#name : #Day19,
	#superclass : #DayInput,
	#category : #AoC2021
}

{ #category : #parsing }
Day19 class >> parseInput: lines [
	^ (lines splitOn: #('')) collect: [ :sl |
		| id  coords m |
		m := '--- scanner (\d+) ---' asRegex.
		(m matches: sl first) ifFalse: [ Error new signal: 'invalid scanner input' ].
 		id := (m subexpression: 2) asNumber .
		coords := sl allButFirst collect: [ :c |
			Day19Point new coords: ((c splitOn: ',') collect: [ :n | n asNumber ])
		].
		Day19Scanner new id: id; seen: (Set withAll: coords).
	]

]

{ #category : #solutions }
Day19 >> part1 [		
	| scanners beacons |
	scanners := input.
	(scanners at: 1) position: (Day19Point new coords: #(0 0 0)).
	
	"while there are scanners we don't know the position of"
	[ scanners anySatisfy: [ :s | s position isNil ] ] whileTrue: [ 
		| havePosition noPosition |
		havePosition := scanners select: [ :s | s position isNotNil ].
		noPosition := scanners select: [ :s | s position isNil ].
		"try to set positions"
		noPosition do: [ :noPos |
			havePosition do: [ :havePos | 
				| newScanner |
				newScanner := havePos matchingBeacons: noPos.
				newScanner ifNotNil: [  
					Transcript show: ' Scanner ', noPos id asString,' at ', newScanner position asString;cr.
					noPos 
						position: newScanner position;
						seen: newScanner seen.
				].
			]].
	].

	beacons := (scanners flatCollect: #seen) collect: #asString as: Set.
	beacons do: [ :b | Transcript show: '  beacon: ', b asString;cr. ].
	Transcript show: beacons size asString;cr.
	
	^ (scanners flatCollectAsSet: #seen) size
	
]
