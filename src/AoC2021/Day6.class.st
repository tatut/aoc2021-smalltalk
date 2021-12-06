Class {
	#name : #Day6,
	#superclass : #DayInput,
	#category : #AoC2021
}

{ #category : #solutions }
Day6 >> part1 [
	^ self partDays: 80
]

{ #category : #solutions }
Day6 >> part2 [ 
  ^ self partDays: 256
]

{ #category : #solutions }
Day6 >> partDays: days [
	| counts |
		
	"counts models how many of each lanternfish counters there are"
	counts := Dictionary new .
	input do: [ :c |
		counts at: c update: [ :n | n + 1 ] initial: [ 1 ]
   ].

	1 to: days do: [ :day |
		| newCounts |
		newCounts := Dictionary new. 
		counts keysAndValuesDo: [ :key :val |
			(key = 0) 
				ifTrue: [ newCounts at: 8 put: val. newCounts at: 6 put: val ]
				ifFalse: [ newCounts at: key-1 update: [:v | v + val ] initial: [val]].
		].
		counts := newCounts.
	].

	^ counts values sum 
]
