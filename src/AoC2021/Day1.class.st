Class {
	#name : #Day1,
	#superclass : #DayInput,
	#category : #AoC2021
}

{ #category : #'as yet unclassified' }
Day1 class >> part1:  input [  
	| len prev incr |
	incr := 0.
	prev := input first.
	len := input size.
	2 to: len do: [ :i | 
		(prev < (input at: i)) ifTrue: [ incr := (incr + 1) ].
		 prev := (input at: i)].
	^ incr.
   

]

{ #category : #solutions }
Day1 >> part1 [
	| len prev incr |
	incr := 0.
	prev := input first.
	len := input size.
	2 to: len do: [ :i | 
		(prev < (input at: i)) ifTrue: [ incr := (incr + 1) ].
		 prev := (input at: i)].
	^ incr	
	
]

{ #category : #solutions }
Day1 >> part2 [
	| len prev incr |
	incr := 0.
	prev := input first.
	len := input size.
	2 to: (len - 2) do: [ :i | 
		| w |
		w := self windowAt: i.
		(prev < w) ifTrue: [ incr := (incr + 1) ].
		 prev := w
	].
	^ incr	
	
]

{ #category : #solutions }
Day1 >> windowAt: i [
	^(input at: i) + (input at: (i + 1)) + (input at: (i + 2))
]
