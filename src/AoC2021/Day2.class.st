Class {
	#name : #Day2,
	#superclass : #DayInput,
	#category : #AoC2021
}

{ #category : #parsing }
Day2 class >> parseCommands: lines [
	^ lines collect: [ :line |
		| split |
		split := line splitOn: Character space.
		Array with: (split at: 1) with: (split at: 2) asInteger   
   ]
]

{ #category : #solutions }
Day2 >> part1 [		
	| hor dep |
	hor := 0.
	dep := 0.
	input do: [ :cmd |
		| direction amount |
		direction := (cmd at: 1).
		amount := (cmd at: 2).
		direction = 'forward' ifTrue: [ hor := hor + amount ].
		direction = 'up' ifTrue: [ dep := dep - amount ].
		direction = 'down' ifTrue: [ dep := dep + amount ].
	] .
	^ ( hor * dep ) 
	
]

{ #category : #solutions }
Day2 >> part2 [		
	| hor dep aim |
	hor := 0.
	dep := 0.
	aim := 0.
	input do: [ :cmd |
		| direction amount |
		direction := (cmd at: 1).
		amount := (cmd at: 2).
		direction = 'forward' ifTrue: [ 
			hor := hor + amount.
			dep := dep + (aim * amount) ].
		direction = 'up' ifTrue: [ aim := aim - amount ].
		direction = 'down' ifTrue: [ aim := aim + amount ].
	] .
	^ ( hor * dep ) 
	
]
