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
	| parent |
	parent := self class new left: self; right: aSnailfishNumber; yourself.
	self up: parent.
	aSnailfishNumber up: parent.
	^ parent
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
	  (self depth = 4)
]

{ #category : #testing }
SnailfishNumber >> canSplit [ 
	^ leaf ifNil: false ifNotNil: [ leaf >= 10 ]
]

{ #category : #accessing }
SnailfishNumber >> depth [ 
	| d n |
	d := 0.
	n := self.
	[ n := n up ] whileNotNil: [ d := d + 1 ].
	^ d
]

{ #category : #'as yet unclassified' }
SnailfishNumber >> doExplode [
	"Do one explosion, returns true if some node exploded"
	| node |
	node := self findNode: #canExplode.
	node ifNil: [ ^ false ] ifNotNil: [ node explode. ^ true ]
]

{ #category : #'as yet unclassified' }
SnailfishNumber >> doSplit [
	"Do one split, returns true if some node exploded"
	| node |
	node := self findNode: #canSplit.
	node ifNil: [ ^ false ] ifNotNil: [ node split. ^ true ]
]

{ #category : #'as yet unclassified' }
SnailfishNumber >> explode [
	"explode this number: add left/right numbers to next number on the left/rigt"		
	| node l r |
	l := self left.
	r := self right.
	l isLeaf & r isLeaf ifFalse: [ Error new signal: 'left&right must be leaves to explode' ].
	
	node := self nextLeaf: #left.
	node ifNotNil: [ node leaf: node leaf + l leaf ].
	
	node := self nextLeaf: #right.
	node ifNotNil: [ node leaf: node leaf + r leaf ].
		 
	"finally replace myself with 0"
	self up replaceBranch: self with: (self class new leaf: 0)
	
]

{ #category : #accessing }
SnailfishNumber >> findNode: checkBlock [
	self visit: [ :n | (checkBlock value: n) ifTrue: [ ^ n ] ].
	^ nil
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

{ #category : #'truncation and round off' }
SnailfishNumber >> reduce [
	"reduce this number
	each round do one of:
	- explode leftmost pair that is nested 4 levels or deeper
	- split number greater than 10"	
	
	[ | e |
		e := self doExplode.
		e ifFalse: [ e := self doSplit  ].
		e ] whileTrue.
	^ self
	
	

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
	| l r s |
	l := self class new leaf: (leaf / 2) floor.
	r := self class new leaf: (leaf / 2) ceiling.
	s := self class new left: l; right: r; yourself.
	l up: s.
	r up: s.
	^ self up replaceBranch: self with: s.
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
	left ifNotNil: [ left visit: depth+1 with: aBlock ].
	aBlock value: depth value: self.
	right ifNotNil: [ right visit: depth+1 with: aBlock ].
	
]

{ #category : #'as yet unclassified' }
SnailfishNumber >> visualize [
	"helper to visualize a binary tree in playground"
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

	c addAll: shapes.
	
	eb := RSLineBuilder line.
	eb canvas: c.
	eb connectFrom: #up.
	RSTreeLayout on: shapes.
	shapes do: [ :e | e translateBy: 0 @ 0 ].
	c @ RSCanvasController.
	^ c 
	
]
