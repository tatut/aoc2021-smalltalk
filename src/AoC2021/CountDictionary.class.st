"
I am a Dictionary specialized for holding count numbers.

"
Class {
	#name : #CountDictionary,
	#superclass : #Dictionary,
	#category : #AoC2021
}

{ #category : #'instance creation' }
CountDictionary class >> from: aCountDictionary with: aBlock [
	"create new count dictionary from aCountDictionary by calling aBlock with the new dictionary, key and value
	of each element in aCountDictionary."
	| d |
	d := self new.
	aCountDictionary keysAndValuesDo: [ :k :v |
		aBlock value: d value: k value: v
	].
	^ d
]

{ #category : #'as yet unclassified' }
CountDictionary class >> withCount: elements [
	"answer with new instance of me with counts of all occurences of elements"
	| d |
	d := self new.
	elements do: [ :e | d at: e incrementBy: 1 ].
	^ d
]

{ #category : #accessing }
CountDictionary >> at: aKey incrementBy: aNumber [
	"increment count at aKey by aNumber. If aKey has no count, it is initialized to aNumber."
	self at: aKey update: [ :current | current + aNumber ] initial: aNumber
]

{ #category : #'as yet unclassified' }
CountDictionary >> counts [
	"answer with sorted collection of all the counts in ascending order"
	^ SortedCollection withAll: self values
]
