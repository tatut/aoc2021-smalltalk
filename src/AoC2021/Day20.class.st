Class {
	#name : #Day20,
	#superclass : #DayInput,
	#category : #AoC2021
}

{ #category : #parsing }
Day20 class >> parseInput: lines [
	| image |
	image := Set new.
	(lines allButFirst: 2) doWithIndex: [ :line :y |
		line doWithIndex: [ :pixel :x | 
			pixel = $# ifTrue: [ image add: x@y ]
		]
	].
	^ { lines first . image }

]

{ #category : #accessing }
Day20 >> enhance: img with: enhanceAlg outside: outside [
	| p r newImage |
	r := self imageRectangle: img.
	p := [ :pos | 
		((pos y between: r top and: r bottom) & (pos x between: r left and: r right))
			ifTrue: [ (img includes: pos) ifTrue: $1 ifFalse: $0 ]
			ifFalse: [ outside ] ].
		
	newImage := Set new.
	r top - 6 to: r bottom + 6 do: [ :y |
		r left - 6  to: r right + 6 do: [ :x | 
			| enhanceIdx pos |
			pos := x@y.
 			enhanceIdx := (String streamContents: [:out |
			out nextPutAll: '2r'.
			{ -1 @ -1 . 0 @ -1 . 1 @ -1 .
			  -1 @ 0  . 0 @ 0  . 1 @ 0 .
 			  -1 @ 1  . 0 @ 1  . 1 @ 1 } 
				do: [ :d | out nextPut: (p value: pos + d) ]]) asNumber .
			(enhanceAlg at: (enhanceIdx + 1)) = $# ifTrue: [ newImage add: pos ]
	]].
	^ newImage
]

{ #category : #'as yet unclassified' }
Day20 >> imageRectangle: img [
  | minx maxx miny maxy |
 
	img do: [ :pos |
		minx ifNil: [minx := pos x] ifNotNil: [ minx := minx min: pos x ].
		maxx ifNil: [maxx := pos x] ifNotNil: [ maxx := maxx max: pos x ].
		miny ifNil: [miny := pos y] ifNotNil: [ miny := miny min: pos y ].
		maxy ifNil: [maxy := pos y] ifNotNil: [ maxy := maxy max: pos y ].
	].
	
	^ minx @ miny corner: maxx @ maxy
]

{ #category : #solutions }
Day20 >> part1 [
	| enhance image |
	enhance := input first.
	image := input second copy.
	
	image := self enhance: image with: enhance outside: $0.
	"we know there's an infinite lit border around the area that flips back"
	image := self enhance: image with: enhance outside: $1.

	^ image size
]

{ #category : #solutions }
Day20 >> part2 [
	| enhance image out |
	enhance := input first.
	image := input second copy.
	out := $0.
	50 timesRepeat: [ 
		image := self enhance: image with: enhance outside: out.
		out := (out = $1) ifTrue:$0 ifFalse:$1
	].

	^ image size
]

{ #category : #printing }
Day20 >> printImage: img [
	|r|
	r := self imageRectangle: img .
	
	r top  to: r bottom  do: [ :y |
		r left  to: r right  do: [ :x |
			|p|
			p := (img includes: x@y) ifTrue: $# ifFalse: $..
			Transcript show: p.
		].
		Transcript cr.
 ].

	
]
