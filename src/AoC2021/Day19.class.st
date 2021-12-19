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

{ #category : #'as yet unclassified' }
Day19 >> allBeaconCoords: scanners [
  | set |
  set := Set new.
  scanners do: [ :scan | scan seen do: [ :b | set add: b coords ]].
  ^ set
]

{ #category : #'as yet unclassified' }
Day19 >> allBeacons: scanners [
  | set |
  set := Set new.
  scanners do: [ :scan | scan seen do: [ :b | set add: b ]].
  ^ set
]

{ #category : #'as yet unclassified' }
Day19 >> findScanners [ 
	| scanners found toFind |
	scanners := input copy.
	(scanners at: 1) position: (Day19Point new coords: #(0 0 0)).
	found := Set with: (scanners at: 1).
	toFind := OrderedCollection withAll: scanners allButFirst.
	
	"while there are scanners we don't know the position of"
	[ toFind isNotEmpty ] whileTrue: [ 
		| noPos newScanner |
		noPos := toFind removeFirst .
	 	newScanner := self firstWithMatching: found scanner: noPos.
		newScanner 
			ifNotNil: [ 
 				Transcript show: ' Scanner ', newScanner id asString,' at ', newScanner position asString;cr.
				found add: newScanner. ]
			ifNil: [ toFind add: noPos ].
	].
	^ found
	
]

{ #category : #accessing }
Day19 >> firstWithMatching: scanners scanner: scanner [
	scanners do: [ :s |
		| newScanner |
		newScanner := s matchingBeacons: scanner.
		newScanner ifNotNil: [ ^ newScanner ]
	].
	^ nil
]

{ #category : #solutions }
Day19 >> part1 [		
	| scanners beacons |
	scanners := self findScanners .
	beacons := self allBeaconCoords: scanners.	
	^ beacons size 
]

{ #category : #solutions }
Day19 >> part2 [ 
	| scanners  maxDist |
	scanners := self findScanners .
	
	maxDist := 0.
	scanners do: [ :a |
		scanners do: [ :b | 
			maxDist := maxDist max: (a position distanceTo: b position)
		]].
	Transcript show: 'max dist: ',maxDist asString;cr.
	^ maxDist
]
