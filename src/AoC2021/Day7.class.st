Class {
	#name : #Day7,
	#superclass : #DayInput,
	#category : #AoC2021
}

{ #category : #solutions }
Day7 >> part1 [
	| min max |
	min := input first.
	max := input first.
	"determine possible positions to align"
	input do: [ :p |
		min := min min: p.
		max := max max: p.
	].

   ^ ((min to: max) collect: [ :candidate | 
		(input collect: [ :pos | (candidate - pos) abs]) sum]) sort first 

	
]

{ #category : #solutions }
Day7 >> part2 [
	| min max |
	min := input first.
	max := input first.
	"determine possible positions to align"
	input do: [ :p |
		min := min min: p.
		max := max max: p.
	].

   ^ ((min to: max) collect: [ :candidate | 
		(input collect: [ :pos | 
 			(1 to: ((candidate - pos) abs)) sum
		]) sum]) sort first 


]
