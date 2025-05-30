"
I implement very simple operations described by a symbol
"
Class {
	#name : 'ASCDrop',
	#superclass : 'ASCNonStackReferencingOperations',
	#category : 'Zag-Core-Operations',
	#package : 'Zag-Core',
	#tag : 'Operations'
}

{ #category : 'callgraph' }
ASCDrop >> dotStringOn: aStream [

	^ aStream << 'drop'
]

{ #category : 'code generation' }
ASCDrop >> outputTo: aCodeEmitter [

	^ aCodeEmitter visitDrop
]

{ #category : 'stack' }
ASCDrop >> resultStack: anASStack [

	stack := anASStack.
	^ anASStack drop
]

{ #category : 'finalAnalysis' }
ASCDrop >> shrinksStack [

	^ true
]

{ #category : 'instance creation' }
ASCDrop >> with: ignored [
]
