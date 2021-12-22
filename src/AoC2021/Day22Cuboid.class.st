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
