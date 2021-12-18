"
A SnailfishNumberTest is a test class for testing the behavior of SnailfishNumber
"
Class {
	#name : #SnailfishNumberTest,
	#superclass : #TestCase,
	#category : #'AoC2021-Tests'
}

{ #category : #tests }
SnailfishNumberTest >> testExplode [
	| n |
	
	"explode leftmost node [9,8]"
	n := SnailfishNumber fromString: '[[[[[9,8],1],2],3],4]'.
	n left left left left explode.
	self assert: n asString equals: '[[[[0,9],2],3],4]'.
	
	"explode rightmost node [3,2]"
	n := SnailfishNumber fromString: '[7,[6,[5,[4,[3,2]]]]]'.
	n right right right right explode.
	self assert: n asString equals: '[7,[6,[5,[7,0]]]]'.
	
	"explode node [3,2]"
	n := SnailfishNumber fromString: '[[6,[5,[4,[3,2]]]],1]'.
	n left right right right explode.
	self assert: n asString equals: '[[6,[5,[7,0]]],3]'.
]

{ #category : #tests }
SnailfishNumberTest >> testParsing [
	self assert: (SnailfishNumber parse: (ReadStream on: '[[[[[9,8],1],2],3],4]')) asString 
		equals: '[[[[[9,8],1],2],3],4]'
]

{ #category : #tests }
SnailfishNumberTest >> testReduce [
	"first test case from description"
	self assert: (SnailfishNumber fromString: '[[[[[4,3],4],4],[7,[[8,4],9]]],[1,1]]') reduce asString
		equals: '[[[[0,7],4],[[7,8],[6,0]]],[8,1]]'
]
