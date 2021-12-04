Class {
	#name : #Day3,
	#superclass : #DayInput,
	#category : #AoC2021
}

{ #category : #accessing }
Day3 >> mostCommonBitAt: i [
	"determine most common bit in input at index"			
	| one zero res |
	one := 0.
	zero := 0.
	(input collect: [ :line | line at: i]) do: [ :b |
		(b = $0) ifTrue: [ zero := zero + 1 ] ifFalse: [ one := one + 1 ]	
	].  
	res := (zero = one) 
		ifTrue: [ nil ] 
		ifFalse: [ (zero > one) ifTrue: [ $0 ] ifFalse: [ $1 ] ].
	^ res
]

{ #category : #accessing }
Day3 >> mostCommonBitAt: i default: d [
	"determine most common bit in input at index"			
	| one zero res |
	one := 0.
	zero := 0.
	(input collect: [ :line | line at: i]) do: [ :b |
		(b = $0) ifTrue: [ zero := zero + 1 ] ifFalse: [ one := one + 1 ]	
	].  
Transcript show: 'zero: ', zero asString ,'  one: ', one asString ; cr.
	res := (zero = one) 
		ifTrue: [ Transcript show: 'returning default' , d asString; cr. d ] 
		ifFalse: [ (zero > one) ifTrue: [ $0 ] ifFalse: [ $1 ] ].
	^ res
]

{ #category : #accessing }
Day3 >> mostCommonBitAt: i input: inp default: d [
	"determine most common bit in input at index"			
	| one zero res |
	one := 0.
	zero := 0.
	(inp collect: [ :line | line at: i]) do: [ :b |
		(b = $0) ifTrue: [ zero := zero + 1 ] ifFalse: [ one := one + 1 ]	
	].  
	res := (zero = one) 
		ifTrue: [ d ] 
		ifFalse: [ (zero > one) ifTrue: [ $0 ] ifFalse: [ $1 ] ].
	^ res
]

{ #category : #solutions }
Day3 >> part1 [		
	| len gamma epsilon |
	len := (input at: 1) size.
	gamma := '2r'.
	epsilon := '2r'.
	1 to: len do: [ :i |
		| one zero |
		one := 0.
		zero := 0.
		(input collect: [ :line | line at: i ]) do: [ :b |
			(b = $0) 
			  ifTrue: [ zero := zero + 1 ] 
			  ifFalse: [ one := one + 1 ] ].
		(one > zero) 
			ifTrue: [ gamma := gamma , '1'. epsilon := epsilon , '0' ]	
			ifFalse: [ gamma := gamma , '0'. epsilon := epsilon , '1' ].
	].
   ^ gamma asNumber * epsilon asNumber 
	
]

{ #category : #solutions }
Day3 >> part2 [			
	| gen scr candidates i | 
	
	" search for generator number"
	candidates := input.
	i := 1.
	[ candidates size > 1 ] whileTrue: [ 
		| mcb |
		mcb := self mostCommonBitAt: i input: candidates default: $1.
		candidates := candidates select: [ :c | (c at: i) = mcb ].
		i := i + 1.
	].
	gen := ('2r' , candidates first) asNumber .
	
	"search for scrubber number"
	candidates := input.
	i := 1.
	[ candidates size > 1 ] whileTrue: [ 
		| mcb |
		mcb := self mostCommonBitAt: i input: candidates default: $1.
		candidates := candidates select: [ :c | (c at: i) ~= mcb ].
		i := i + 1. 
	].
	scr := ('2r' , candidates first) asNumber.
	
	^ gen * scr 
]
