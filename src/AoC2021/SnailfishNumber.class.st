Class {
	#name : #SnailfishNumber,
	#superclass : #Object,
	#instVars : [
		'left',
		'right',
		'up',
		'leaf'
	],
	#category : #AoC2021
}

{ #category : #'instance creation' }
SnailfishNumber class >> fromString: str [
	^ self parse: (ReadStream on: str)
]

{ #category : #parsing }
SnailfishNumber class >> parse: stream [
	"parse snailfish number from stream"
	| left right here expect |	
		
	expect := [ :ch | | got |
		got := stream next.
		got = ch ifFalse: [ Error new signal: 'expected ', ch asString, ' but got ', got asString ]
	].

	expect value: $[.
	
	stream peek = $[ 
		ifTrue: [ left := self parse: stream. expect value: $, ]
		ifFalse: [ left := self new leaf: (stream upTo: $,) asNumber ].
	
	stream peek = $[
		ifTrue: [ right := self parse: stream. expect value: $] ]
		ifFalse: [ right := self new leaf: (stream upTo: $]) asNumber ].
	
	here := self new left: left; right: right; yourself .
	left up: here. 
	right up: here.
	^ here
	
	
		
]

{ #category : #arithmetic }
SnailfishNumber >> + aSnailfishNumber [
	"adding snailfish numbers together creates a pair"
	^ self class new left: self; right: aSnailfishNumber; yourself
]

{ #category : #converting }
SnailfishNumber >> asString [ 
	^ self isLeaf
		ifTrue: [ leaf asString ]
		ifFalse: [ '[', left asString, ',', right asString, ']' ]
]

{ #category : #testing }
SnailfishNumber >> canExplode [
	"check if this node can explode"
	leaf ifNotNil: [ ^ false ]. "a leaf can't explode"
	
	^ left isLeaf & right isLeaf & 
	  (self depth >= 4)
]

{ #category : #accessing }
SnailfishNumber >> depth [ 
	| d n |
	d := 1.
	n := self.
	[ n := n up ] whileNotNil: [ d := d +1 ].
	^ d
]

{ #category : #'as yet unclassified' }
SnailfishNumber >> explode [
	"explode this number: add left/right numbers to next number on the left/rigt"		
	| node l r |
	l := self left.
	r := self right.
	l isLeaf & r isLeaf ifFalse: [ Error new signal: 'left&right must be leaves to explode' ].
	
	"Transcript show: 'explode ', self asString; cr."
	
	node := self nextLeaf: #left.
	node
		ifNil: [ "Transcript show: 'nothing to the left of', self asString;cr." ] 
		ifNotNil: [ "Transcript show: 'left node: ', node asString;cr."
			node leaf: node leaf + l leaf ].
	
	node := self nextLeaf: #right.
	node
		ifNil: [ "Transcript show: 'nothing to the right of', self asString;cr." ] 
		ifNotNil: [ "Transcript show: 'right node: ', node asString;cr."
			node leaf: node leaf + r leaf ].
		 
	"finally replace myself with 0"
	self up replaceBranch: self with: (self class new leaf: 0)
	
]

{ #category : #'as yet unclassified' }
SnailfishNumber >> inInsertionOrder [
	^ OrderedCollection streamContents: [ :out |
		self visit: [ :n | out nextPut: n ] ]
]

{ #category : #testing }
SnailfishNumber >> isLEaf [
	^ leaf isNotNil 

]

{ #category : #testing }
SnailfishNumber >> isLeaf [
	^ leaf isNotNil 

]

{ #category : #accessing }
SnailfishNumber >> leaf [

	^ leaf
]

{ #category : #accessing }
SnailfishNumber >> leaf: anObject [

	leaf := anObject
]

{ #category : #accessing }
SnailfishNumber >> left [

	^ left
]

{ #category : #accessing }
SnailfishNumber >> left: anObject [

	left := anObject
]

{ #category : #'as yet unclassified' }
SnailfishNumber >> magnitude [
	^ leaf ifNotNil: [ leaf ]
	ifNil: [ (left magnitude * 3) + (right magnitude * 2) ]
]

{ #category : #'as yet unclassified' }
SnailfishNumber >> nextLeaf: direction [
	| from node dir opp |
	
	"blocks to get direction and its opposite from node"
	dir := [ :n | direction = #left ifTrue: [ n left ] ifFalse: [ n right ] ].
	opp := [ :n | direction = #left ifTrue: [ n right ] ifFalse: [ n left ]].
	
	from := self. 
	node := self up.
	"go up until the node in dir is not the one we came from"
	[ (dir value: node) == from ] whileTrue: [ 
		from := node. 
		node := node up.
		node ifNil:[ ^ nil ]. "left/right most node"
	].
	node := dir value: node.
	
	node isLeaf ifTrue: [ ^ node ].
	[ node isLeaf ] whileFalse: [ node := opp value: node ].
	^ node
]

{ #category : #accessing }
SnailfishNumber >> position [
	"return the position string for this node in the tree"
	up ifNil: [^ '.'] ifNotNil: [
		up left == self ifTrue:[^ up position,'l'].
		up right == self ifTrue:[^ up position,'l'].
	].
	^ '<detached ',self asString,'>'
]

{ #category : #'truncation and round off' }
SnailfishNumber >> reduce [
	"reduce this number
	each round do one of:
	- explode leftmost pair that is nested 4 levels or deeper
	- split number greater than 10"
	[true] whileTrue: [ 
		| changed handled |
		handled := Set new.
		
		Transcript show: 'round-------';cr.
		changed := false.
		self inInsertionOrder do: [ :n |
			"Transcript show: 'node: ', n asString, ' handled: ', handled asString;cr."
			(handled includes: n position) not & (n canExplode)
				ifTrue: [ 
 					Transcript show: n asString.
					n explode. 
					Transcript show: ' after explode: ', self asString;cr.
					handled add: n up position.
					changed := true. ]
		].
		
		self inInsertionOrder doWithIndex:  [ :n :i |
			n isLeaf ifTrue: [ (n leaf >= 10) ifTrue: [ 
					| split alreadyExploded |
					alreadyExploded := handled includes: n position. 
					Transcript show: n asString.
					split := n split.
					changed := true.
 					Transcript show: ' after split: ', self asString;cr.
					
					(alreadyExploded not) & (split canExplode) ifTrue: [ 
						Transcript show: split asString.
						split explode.
						Transcript show: ' after explode2: ', self asString;cr.
					]
					
					] ]
		].
		
		changed ifFalse: [ ^ self ]
		
	]
	
	

]

{ #category : #'truncation and round off' }
SnailfishNumber >> reduceInsOrd [ 
	"reduce this number
	each round do one of:
	- explode leftmost pair that is nested 4 levels or deeper
	- split number greater than 10"
	[true] whileTrue: [ 
		| changed handled |
		handled := IdentitySet new.
			
		changed := false.
		self inInsertionOrder do: [ :n |
			"Transcript show: 'node: ', n asString, ' handled: ', handled asString;cr."
			(handled includes: n) not & (n canExplode)
				ifTrue: [ 
					Transcript show: n asString.
					n explode. 
					Transcript show: ' after explode: ', self asString;cr.
					handled add: n up.
					changed := true. ]
		].
		
		self inInsertionOrder do: [ :n |
			n isLeaf ifTrue: [ (n leaf >= 10) ifTrue: [ 
					| split |
					Transcript show: n asString.
					split := n split.
					changed := true.
 					Transcript show: ' after split: ', self asString;cr.
					split canExplode ifTrue: [ 
						Transcript show: split asString.
						split explode.
						Transcript show: ' after explode2: ', self asString;cr.
					]
					
					] ]
		].
		
		changed ifFalse: [ ^ self ]
	]
	
	

]

{ #category : #'truncation and round off' }
SnailfishNumber >> reduceOld [ 
	"reduce this number
	each round do one of:
	- explode leftmost pair that is nested 4 levels or deeper
	- split number greater than 10"
	| node findNode prev flatten |
	prev := nil.
	
	flatten := self inInsertionOrder .
	
	Transcript show: ('  ' join:flatten);cr.
	"use thisContext trick to return early from visiting"	
	findNode := [ :with | 
		| ctx | 
		ctx := thisContext. 
		with value: [ :n | node := n. ctx return ] ].

	[prev ~= self asString] whileTrue: [ 
		prev := self asString.
		
		"find something to explode"
		Transcript show: '--------------';cr;show: prev;cr.
		
		self visitExplode: 1.
		"self visit: 1 with: [ :d :n | 
			
			(d >= 3) ifTrue: [ 
				n left ifNotNil: [ n left canExplode ifTrue: [ 
					Transcript show: 'after exploding left ', n left asString.
					n left explode.
					Transcript show: ' ---> ', self asString ;cr.
					changed := true.
				]].
				n right ifNotNil: [ n right canExplode ifTrue: [ 
					Transcript show: 'after eploding right ', n right asString. 
					n right explode.
					Transcript show: ' --> ' , self asString;cr.
				]].
			]]."
		node := nil.
		node 
			ifNotNil: [ node explode ]		
			ifNil: [ 
				"find something to split"
				findNode value: [ :found | self visit: 1 with: [ :d :n | n isLeaf ifTrue: [ n leaf >= 10 ifTrue: [ found value: n ] ] ] ].
				node ifNotNil: [Transcript show: 'found node to split: ', node asString;cr.].
				node ifNotNil: [ node split ] ifNil: [ ^ self ]
			]
	]
	
	

]

{ #category : #'as yet unclassified' }
SnailfishNumber >> replaceBranch: child with: newChild [
	newChild up: self.
	child == left 
		ifTrue: [ left := newChild ]
		ifFalse: [ child == right 
						ifTrue: [ right := newChild ]
						ifFalse: [ Error new signal: 'tried to replace child I don''t have.' ] ].
	^ newChild
]

{ #category : #accessing }
SnailfishNumber >> right [

	^ right
]

{ #category : #accessing }
SnailfishNumber >> right: anObject [

	right := anObject
]

{ #category : #'as yet unclassified' }
SnailfishNumber >> split [
	"split leaf into pair"
	| l r |
	l := self class new leaf: (leaf / 2) floor.
	r := self class new leaf: (leaf / 2) ceiling.
	^ self up replaceBranch: self with: (self class new left: l; right: r; yourself).
]

{ #category : #accessing }
SnailfishNumber >> up [

	^ up
]

{ #category : #accessing }
SnailfishNumber >> up: anObject [

	up := anObject
]

{ #category : #visiting }
SnailfishNumber >> visit: aBlock [
	left ifNotNil: [ left visit: aBlock ].
	aBlock value: self.
	right ifNotNil: [ right visit: aBlock ].
	
]

{ #category : #visiting }
SnailfishNumber >> visit: depth with: aBlock [
	left ifNotNil: [ 
		depth timesRepeat: [ Transcript show: '  ' ].
		Transcript show: 'visiting left ', left asString ;cr.
		left visit: depth+1 with: aBlock ].
	depth timesRepeat: [ Transcript show: '  ' ].
	Transcript show: 'visiting self ', self asString;cr.
	aBlock value: depth value: self.
	right ifNotNil: [ 
		depth timesRepeat: [ Transcript show: '  ' ].
		Transcript show: 'visiting right ', right asString; cr. 
		right visit: depth+1 with: aBlock ].
	
]

{ #category : #visiting }
SnailfishNumber >> visitExplode: depth [
	| exp |
	left ifNotNil: [ exp := left visitExplode: depth+1. exp ifTrue: [ ^ false ] ].
	self canExplode ifTrue: [ self explode. ^ false ].
	right ifNotNil: [ exp := right visitExplode: depth+1. exp ifTrue: [ ^ false ] ].
	^ false

]

{ #category : #'as yet unclassified' }
SnailfishNumber >> visualize [
	| c shapes eb |
	c := RSCanvas new.
	shapes := OrderedCollection streamContents: [ :out |
		self visit: [ :n | 
			out nextPut: (RSLabel new
				model: n;
				draggable;
				size: (n asString) size * 5;
				text: n asString; 
				yourself)
		 	]].
	Transcript show: 'shapesd: ', shapes asString;cr.
	c addAll: shapes.
	
	eb := RSLineBuilder line.
	eb canvas: c.
	eb connectFrom: #up.
	RSTreeLayout on: shapes.
	shapes do: [ :e | e translateBy: 0 @ 0 ].
	c @ RSCanvasController.
	^ c 
	
]
