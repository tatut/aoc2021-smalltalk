"
A Day16PacketTest is a test class for testing the behavior of Day16Packet
"
Class {
	#name : #Day16PacketTest,
	#superclass : #TestCase,
	#category : #'AoC2021-Tests'
}

{ #category : #tests }
Day16PacketTest >> testReadLengthType0 [
	"test reading of length type 0 packets"
	| p |
	p := Day16Packet new fromStream: (ReadStream on: '00111000000000000110111101000101001010010001001000000000').
	self assert: p subPackets size equals: 2.
	self assert: (p subPackets at: 1) literal equals: 10.
	self assert: (p subPackets at: 2) literal equals: 20.
	
]

{ #category : #tests }
Day16PacketTest >> testReadLengthType1 [
	"test reading of length type 0 packets"
	| p |
	p := Day16Packet new fromStream: (ReadStream on: '11101110000000001101010000001100100000100011000001100000').
	self assert: p subPackets size equals: 3.
	self assert: (p subPackets at: 1) literal equals: 1.
	self assert: (p subPackets at: 2) literal equals: 2.
	self assert: (p subPackets at: 3) literal equals: 3.
	
	
]
