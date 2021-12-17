Class {
	#name : #Day17,
	#superclass : #DayInput,
	#category : #AoC2021
}

{ #category : #parsing }
Day17 class >> parseInput: lines [
	"parse target area returns rectangle"
	| r xmin ymin xmax ymax |
	r := '(.)=(-?\d+)..(-?\d+)' asRegex.
	r matchesIn: lines first do: [ :dummy | 
		|xOrY min max |
		xOrY := r subexpression: 2.
		min := (r subexpression: 3) asNumber.
		max := (r subexpression: 4) asNumber.
		xOrY = 'x' 
			ifTrue: [ xmin := min. xmax := max. ]
			ifFalse: [ ymin := min. ymax := max. ].
		].
	^ (xmin@ymin) corner: (xmax@ymax)
]

{ #category : #calculating }
Day17 >> highestY: initialVelocity [
	| at v |
	v := initialVelocity.
	at := 0@0.
	[ (at + v) y > at y ] whileTrue: [ 
		at := at + v.
		v := v + (v x sign negated @ -1).
 	].
	^ at y
	
		
]

{ #category : #solutions }
Day17 >> part1 [
	"determine highest Y position that still reaches target"
	| highY |
	Transcript show: input asString;cr.
	highY := 0.
	
	"simple brute force search"
	1 to: 100 do: [ :vy |
		1 to: 100 do: [ :vx |
			(self reachesTarget: vx @ vy) ifTrue: [ highY := highY max: (self highestY: vx @ vy) ]
		]
	].
	^ highY
]

{ #category : #solutions }
Day17 >> part2 [ 
	"find distinct number of inial velocities that reach target"
	| vs |
	vs := Set new.
	-1000 to: 1000 do: [ :vy |
		1 to: 1000 do: [ :vx |
			(self reachesTarget: vx@vy) ifTrue: [ vs add: vx@vy ]
 		]
	].
	^ vs size
]

{ #category : #calculating }
Day17 >> reachesTarget: initialVelocity [ 
	"check if probe fired with initialVelocity (x@y point) will reach target area"
	| at v  prev |
	at := (0@0).
	v := initialVelocity .
	
	[ (at x between: input left and: input right) & (at y between: input top and: input bottom) ] whileFalse: [ 
		prev := at.
		at := at + v. "go to next position"
		v := v + (v x sign negated @ -1). "change x velocity toward 0 and decrease y velocity"
		
		"if x velocity is 0, and x if not between left/right of area, can't reach target"
		((v x = 0) & (at x between: input left and: input right) not) ifTrue: [ ^ false ].
		
		"if went past the area, can't reach target"
		(at x > input right) | (at y < input top)
			ifTrue: [ ^ false ].
	].
	^ true

	
]
