Class {
	#name : #Day8,
	#superclass : #DayInput,
	#instVars : [
		'digitSegments'
	],
	#category : #AoC2021
}

{ #category : #parsing }
Day8 class >> parsePatternsAndOutputs: lines [
	"parse patterns and outputs from input lines"		
	^ lines collect: [ :line |
	 	  (line splitOn: $|) collect: [ :x | (x trim splitOn: Character space) asArray  ]
		]
]

{ #category : #solutions }
Day8 >> findDigits: thePatterns [ 
	"find digits for the given patterns"
	| segments patterns |

	patterns := thePatterns collect: [ :p | Set withAll: p ].
	segments := 'abcdefg'.
		
	segments permutationsDo: [ :perm |
		| mapping digits |
		"create mapping for this permutation"
		mapping := Dictionary new.
		1 to: 7 do: [ :i | mapping add: (perm at: i) -> (segments at: i) ].
		
		digits := patterns
			 collect: [ :pat |
 			  	"translate pattern using mapping and convert to digit"
				pat -> (digitSegments at: (Set withAll: (pat collect: [ :c | mapping at: c ])) ifAbsent: nil). ]
	 		 into: Dictionary new.
		
		(digits includesAll: (0 to: 9)) ifTrue: [ ^ digits ]
	].

	^ #notFound
	
]

{ #category : #initialization }
Day8 >> initialize [ 
	digitSegments := Dictionary new 
		add: (Set withAll: 'abcefg') -> 0;
		add: (Set withAll: 'cf') -> 1;
		add: (Set withAll: 'acdeg') -> 2;
		add: (Set withAll: 'acdfg') -> 3;
		add: (Set withAll: 'bcdf') -> 4;
		add: (Set withAll: 'abdfg') -> 5;
		add: (Set withAll: 'abdefg') -> 6;
		add: (Set withAll: 'acf') -> 7;
		add: (Set withAll: 'abcdefg') -> 8;
		add: (Set withAll: 'abcdfg') -> 9; yourself.
		

	

]

{ #category : #solutions }
Day8 >> part1 [
	"count all output items that have len 2,3,4 or 7"
	^ (input collect: [ :patternsAndOutput |
		 ((patternsAndOutput at: 2) select: [ :o | #(2 3 4 7) includes: o size ]) size
		]) sum
]

{ #category : #solutions }
Day8 >> part2 [ 
   "find digits for all rows and sum output numbers"			
	| patterns output d n |
	^ (input collect: [ :patAndOut |
 		patterns := (patAndOut at: 1).
	   output := (patAndOut at: 2).
	
		"reverse digit to segments map"
		d := (self findDigits: patterns).
	 
	   n := 0.
      output do: [ :s | 
			| digit | 
			digit := (d at: (Set withAll: s)).
			n := (n * 10) + digit.
		].
		n
	]) sum	
	
	
 
]
