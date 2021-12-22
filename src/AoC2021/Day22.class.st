Class {
	#name : #Day22,
	#superclass : #DayInput,
	#category : #AoC2021
}

{ #category : #parsing }
Day22 class >> parseInput: lines [
	^ lines collect: [ :line | Day22Step new fromString: line ]
]

{ #category : #solutions }
Day22 >> part1 [
	| on |
	"naive approach, just count all points"
   on := Set new.
	input do: [ :step |
		| points |
		points := step cuboid allPointsSmall.
		Transcript show: 'running step ', step asString;cr.
		step state = 1 
			ifTrue: [ on := on union: points ]
			ifFalse: [ on := on difference: points ].
		Transcript show: on size asString; cr.
	].
   ^ on size
]

{ #category : #solutions }
Day22 >> part2 [
	| on |
	"cube splicing, version on is a set of cubes that are in on state"
   on := OrderedCollection new.
	input do: [ :step |
		| c | 
		c := step cuboid.
		Transcript show: 'Running step: ', step asString, '  C: ', step cuboid count asString;cr.
		"if step is on, remove any currently intersecting cube from it
		 and add to set of on cubes.
		
		 if step if off, remove it from any currently on cubes and add
		 those results to on cubes"
		step state = 1
			ifTrue: [ 
				| toAdd |
				toAdd := c removeAll: on.
				on addAll: toAdd .
			]
		ifFalse: [ 
			"remove this from all ON cuboids"
			| newOn |
			newOn := OrderedCollection  new.
			on do: [ :onCuboid |
				(onCuboid intersects: c)
					ifTrue: [ 
						Transcript show: 'REMOVE from: ', onCuboid asString, ' remove: ', c asString;cr.
						newOn addAll: (onCuboid remove: c) ]
					ifFalse: [ newOn add: onCuboid ]
			].
			on := newOn.
			
			 ].
		on isNotEmpty ifTrue: [ Transcript show: (on collect: #count) sum asString;cr ].
	].
   ^ (on collect: #count) sum
]
