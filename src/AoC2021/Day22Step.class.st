Class {
	#name : #Day22Step,
	#superclass : #Object,
	#instVars : [
		'cuboid',
		'state'
	],
	#category : #AoC2021
}

{ #category : #converting }
Day22Step >> asString [ 
	^ '<turn: ', (state = 1 ifTrue:'on' ifFalse:'off'), 
		' x:', cuboid xrange asString, 
		' y:', cuboid yrange asString, 
		' z:', cuboid zrange asString, '>'
]

{ #category : #accessing }
Day22Step >> cuboid [

	^ cuboid
]

{ #category : #'instance creation' }
Day22Step >> fromString: string [
	| s r |
	s := string splitOn: ' '.
	state := (s at: 1) = 'on' ifTrue:1 ifFalse:0.
	r := ((s at: 2) splitOn: ',') collect: [ :range |
		 | n | 
		 n := (range allButFirst: 2) splitOn: '..'.
		(n at: 1) asNumber to: (n at: 2) asNumber ].
	cuboid := Day22Cuboid new 
		xrange: (r at: 1);
		yrange: (r at: 2);
		zrange: (r at: 3).
		
	
	
]

{ #category : #accessing }
Day22Step >> state [

	^ state
]
