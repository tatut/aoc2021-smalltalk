Class {
	#name : #Day22Cuboid,
	#superclass : #Object,
	#instVars : [
		'xrange',
		'yrange',
		'zrange'
	],
	#category : #AoC2021
}

{ #category : #'as yet unclassified' }
Day22Cuboid >> allPoints [
	"return naive collection of all points"
	^ OrderedCollection streamContents: [ :out |
		xrange do: [ :x |
			yrange do: [ :y |
				zrange do: [ :z |
					out nextPut: { x . y . z } ]]]]
]

{ #category : #'as yet unclassified' }
Day22Cuboid >> allPointsSmall [
	"return naive collection of all points" 
	^ OrderedCollection streamContents: [ :out |
		-50 to: 50 do: [ :x |
			-50 to: 50 do: [ :y |
				-50 to: 50 do: [ :z |
					(xrange rangeIncludes: x) &
					(yrange rangeIncludes: y) &
					(zrange rangeIncludes: z)
						ifTrue: [ out nextPut: { x . y . z } ] ] ] ] ]
		
]

{ #category : #accessing }
Day22Cuboid >> count [ 
	"how many cubes in this cuboid"
	^ xrange size * yrange size * zrange size
]

{ #category : #accessing }
Day22Cuboid >> diff: cuboid [ 
	"calculate difference (how many added and removed from this to cuboid)"
	| add del overlap |
	overlap := [ :r1 :r2 |
		((r2 first <= r1 first) & (r2 last >= r1 last))
		   "the whole r1 range covered by r2"
			ifTrue: [ r1 size ]
			ifFalse: [ 
 			   (r2 first between: r1 first and: r1 last) |
				(r2 last between: r1 first and: r1 last)
					ifTrue: [ 
						| s e |
						s := r1 first max: r2 first.
						e := r1 last min: r2 last.
						(s to: e) size ]
					"not part of range"
					ifFalse: [ 0 ]
		]].
	
	"all in cuboid that are not in current"
	add := cuboid count - 
			 ((overlap value: xrange value: cuboid xrange) * 
			  (overlap value: yrange value: cuboid yrange) * 
	        (overlap value: zrange value: cuboid zrange)).
	
   "all in current that not in cuboid"
   del := self count - 
			 ((overlap value: cuboid xrange value: xrange) * 
			  (overlap value: cuboid yrange value: yrange) * 
	        (overlap value: cuboid zrange value: zrange)).
	^ { add . del }      


]

{ #category : #accessing }
Day22Cuboid >> firstIntersecting: cuboids [
	^ cuboids detect: [ :c | (self intersects: c) ifTrue: [ ^ c ] ] ifNone: nil.
]

{ #category : #testing }
Day22Cuboid >> intersects: aCuboid [
	"does this intersect with given cuboid"
	| rangeIntersects |
	rangeIntersects := [ :r1 :r2 |
		"r1 completely in r2"
		((r2 first <= r1 first) & r2 last >= r1 last) |
		"or either of r2 ends within r1 range"
		(r1 rangeIncludes: r2 first) |
		(r1 rangeIncludes: r2 last)
	].
	^ (rangeIntersects value: xrange value: aCuboid xrange) &
	  (rangeIntersects value: yrange value: aCuboid yrange) &
	  (rangeIntersects value: zrange value: aCuboid zrange)
]

{ #category : #removing }
Day22Cuboid >> remove: c [
	"answer with the new set of cuboids that result from removing
	the given cuboid from this one"
	^ OrderedCollection streamContents: [ :out |
		| x1 x2 y1 y2 z1 z2|
		x1 := xrange first. x2 := xrange last.
		y1 := yrange first. y2 := yrange last.
		z1 := zrange first. z2 := zrange last.
		(x1 < c xrange first) ifTrue: [ 
			"other is inside in X dim, cut out cube from before it"
			out nextPut: (self copy xrange: (x1 to: c xrange first - 1)).
			x1 := c xrange first. ].
		(x2 > c xrange last) ifTrue: [ 
			"other X ends before this, cut out cube form after it"
			out nextPut: (self copy xrange: (c xrange last + 1 to: x2)).
			x2 := c xrange last ].
		(y1 < c yrange first) ifTrue: [ 
			"other Y is larger, cut out cube from before it"
			out nextPut: (self copy xrange: (x1 to: x2); yrange: (y1 to: c yrange first - 1)).
			y1 := c yrange first ].
		(y2 > c yrange last) ifTrue: [ 
			"other Y ends before this, cut out cube from after it"
			out nextPut: (self copy xrange: (x1 to: x2); yrange: (c yrange last + 1 to: y2)).
			y2 := c yrange last ].
		(z1 < c zrange first) ifTrue: [ 
			out nextPut: (self class new 
				xrange: (x1 to: x2); 
				yrange: (y1 to: y2); 
				zrange: (z1 to: c zrange first - 1)) ].
		(z2 > c zrange last) ifTrue: [ 
			out nextPut: (self class new
				xrange: (x1 to: x2);
				yrange: (y1 to: y2);
				zrange: (c zrange last + 1 to: z2)) ].
	]
]

{ #category : #accessing }
Day22Cuboid >> xrange [

	^ xrange
]

{ #category : #accessing }
Day22Cuboid >> xrange: anObject [

	xrange := anObject
]

{ #category : #accessing }
Day22Cuboid >> yrange [

	^ yrange
]

{ #category : #accessing }
Day22Cuboid >> yrange: anObject [

	yrange := anObject
]

{ #category : #accessing }
Day22Cuboid >> zrange [

	^ zrange
]

{ #category : #accessing }
Day22Cuboid >> zrange: anObject [

	zrange := anObject
]
