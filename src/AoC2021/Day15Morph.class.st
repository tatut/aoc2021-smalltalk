Class {
	#name : #Day15Morph,
	#superclass : #Morph,
	#instVars : [
		'grid',
		'renderSempahore',
		'current',
		'cameFrom'
	],
	#category : #AoC2021
}

{ #category : #drawing }
Day15Morph >> drawOn: canvas [ 
	| from screenPos |
	current ifNil: [ ^ #notStarted ].
	canvas fillRectangle: self bounds color: Color white.
	
	screenPos := [ :pos | self position + (pos - (1@1) * 20). ].

	"render 15x15 grid of neighbors"	
	1 to: (grid rowCount) do: [ :y |
		1 to: (grid columnCount) do: [ :x |
			| risk |

			"get risk level here, if in bounds"
			risk := grid at: y at: x ifInvalid: nil.
			risk ifNotNil: [ 
				| c p |
				c := Color r: 1 g: 0 b:0 alpha: 0.1 + (0.1*risk).
				p := screenPos value: x@y.
				
				canvas fillRectangle: (p corner: p + (20@20)) color: c. 
				canvas drawString: risk asString at: p + (7@2). 
			]
		 ]
	].

	from := current.
	[ from isNotNil ] whileTrue: [ 
		| to |
		to := cameFrom at: from ifAbsent: nil.
		to ifNotNil: [ canvas line: (screenPos value: from) + (10@10) to: (screenPos value: to) + (10@10) width: 4 color: Color green ].
		from := to.
	].
 	renderSempahore signal.
]

{ #category : #accessing }
Day15Morph >> grid: anObject [

	grid := anObject
]

{ #category : #initialization }
Day15Morph >> initialize [ 
	super initialize.
	self bounds: (20@20 corner: 1020@1020).
	renderSempahore := Semaphore forMutualExclusion .
	self startStepping 
	
]

{ #category : #stepping }
Day15Morph >> step [
	self changed
]

{ #category : #stepping }
Day15Morph >> stepTime [ 
	^ 50 "20 fps" 
]

{ #category : #'as yet unclassified' }
Day15Morph >> updatePathFindingState: newCurrent cameFrom: newCameFrom [ 
	current := newCurrent .
	cameFrom := newCameFrom .
	renderSempahore wait "wait for next render"
]
