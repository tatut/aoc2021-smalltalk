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
			ifFalse: [ on := on difference: points ]
	].
   ^ on size
]

{ #category : #solutions }
Day22 >> part2 [
	| on |
	"cube splicing, version on is a set of cubes that are in on state"
   on := Set new.
	input do: [ :step |
		| points |
		points := step cuboid allPointsSmall.
		Transcript show: 'running step ', step asString;cr.
		"if step is on, remove any currently intersecting cube from it
		 and add to set of on cubes.
		
		 if step if off, remove it from any currently on cubes and add
		 those results to on cubes"
		step state = 1 
			ifTrue: [ 
				| toAdd intersected |
				toAdd := OrderedCollection  with: step cuboid.
				intersected := true.
				[ intersected ] whileTrue: [ 
					intersected := false.
 					on do: [ :onCuboid |
						"remove this ON cuboid from all to add that intersect"
						| newToAdd |
						newToAdd := OrderedCollection new.
						toAdd do: [ :c |
							(onCuboid intersects: c)
								 ifTrue: [ 
									newToAdd addAll: (c remove: onCuboid).
									intersected := true ]
								 ifFalse: [ newToAdd add: c ].
						toAdd := newToAdd. ]]
				].
			
				"finally add all spliced ones"
				on addAll: toAdd.
			]
		ifFalse: [ 
			"remove this from all ON cuboids"
			| newOn |
			newOn := Set new.
			on do: [ :onCuboid |
				(onCuboid intersects: step cuboid)
					ifTrue: [ newOn addAll: (onCuboid remove: step cuboid) ]
					ifFalse: [ newOn add: onCuboid ]
				 ]
			 ]
	].
   ^ on size
]
