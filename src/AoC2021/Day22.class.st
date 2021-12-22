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
	^ self runSteps 
]

{ #category : #solutions }
Day22 >> runSteps [
	| on |
	"cube splicing, version on is a set of cubes that are in on state"
   on := OrderedCollection new.
	input do: [ :step |
		| c | 
		c := step cuboid.
		"if step is ON, remove any currently intersecting cube from it
		 and add to set of on cubes.
		
		 if step if OFF, remove it from any currently on cubes and add
		 those results to on cubes"
		step state = 1
			ifTrue: [ on addAll: (c removeAll: on) ]
			ifFalse: [ 
				"remove this from all ON cuboids"
				| newOn |
				newOn := OrderedCollection  new.
				on do: [ :onCuboid |
					(onCuboid intersects: c)
						ifTrue: [ newOn addAll: (onCuboid remove: c) ]
						ifFalse: [ newOn add: onCuboid ]
				].
				on := newOn.			
			].
	].
   ^ (on collect: #count) sum
]
