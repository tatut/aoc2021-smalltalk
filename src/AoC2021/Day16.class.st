Class {
	#name : #Day16,
	#superclass : #DayInput,
	#category : #AoC2021
}

{ #category : #parsing }
Day16 class >> parseInput: lines [
	| hexBits |
	hexBits := #('0000' '0001' '0010' '0011' '0100' '0101' '0110' '0111'
				   '1000' '1001' '1010' '1011' '1100' '1101' '1110' '1111').
	^ String streamContents: [ :out |
		lines first do: [ :ch |
			out nextPutAll: (hexBits at: (ch hexDigitValue + 1))	
		]].
	
]

{ #category : #solutions }
Day16 >> part1 [
	| stream p versionSum |
	stream := ReadStream on: input.
	p := Day16Packet new fromStream: stream.
	versionSum := 0.
	p visit: [ :packet | versionSum := versionSum + packet version ].
	^ versionSum
	
]

{ #category : #solutions }
Day16 >> part2 [
	| stream p |
	stream := ReadStream on: input.
	p := Day16Packet new fromStream: stream.
	^ p eval
]
