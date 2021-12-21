Class {
	#name : #Day21Game,
	#superclass : #Object,
	#instVars : [
		'pos1',
		'score1',
		'pos2',
		'score2',
		'rolledCount',
		'turn'
	],
	#category : #AoC2021
}

{ #category : #initialization }
Day21Game >> initialize [
	turn := 1.
	score1 := 0.
	score2 := 0.
	rolledCount := 0.
]

{ #category : #accessing }
Day21Game >> pos1 [

	^ pos1
]

{ #category : #accessing }
Day21Game >> pos1: anObject [

	pos1 := anObject
]

{ #category : #accessing }
Day21Game >> pos2 [

	^ pos2
]

{ #category : #accessing }
Day21Game >> pos2: anObject [

	pos2 := anObject
]

{ #category : #accessing }
Day21Game >> rolledCount [

	^ rolledCount
]

{ #category : #accessing }
Day21Game >> rolledCount: anObject [

	rolledCount := anObject
]

{ #category : #accessing }
Day21Game >> score1 [

	^ score1
]

{ #category : #accessing }
Day21Game >> score1: anObject [

	score1 := anObject
]

{ #category : #accessing }
Day21Game >> score2 [

	^ score2
]

{ #category : #accessing }
Day21Game >> score2: anObject [

	score2 := anObject
]

{ #category : #accessing }
Day21Game >> turn [

	^ turn
]

{ #category : #accessing }
Day21Game >> turn: anObject [

	turn := anObject
]
