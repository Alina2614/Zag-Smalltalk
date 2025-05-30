"
I output to an image
"
Class {
	#name : 'ASImageOutput',
	#superclass : 'ASOutput',
	#instVars : [
		'pendingComponents',
		'components',
		'objects'
	],
	#category : 'Zag-Output-Image-Output',
	#package : 'Zag-Output',
	#tag : 'Image-Output'
}

{ #category : 'adding' }
ASImageOutput >> addComponent: aGenerator [

	pendingComponents add: aGenerator.
	components add: aGenerator
]

{ #category : 'API' }
ASImageOutput >> codeGenerator [

	^ ASCodeGenerator new
]

{ #category : 'as yet unclassified' }
ASImageOutput >> contentsForMethod: aMethod [ 

	^ self
		generateCode: (ASPharoCompiler new astFor: aMethod);
		contents
]

{ #category : 'register' }
ASImageOutput >> for: anASNode generatorIs: anASGenerator [

	objects at: anASNode put: anASGenerator
]

{ #category : 'API' }
ASImageOutput >> generateCode: anASNode for: aClass [

	codeGenerator := self codeGenerator
		                 targetClass: aClass;
		                 generateFrom: anASNode.
	codeGenerator inline: true.
	codeGenerator finalAnalysis.
	self outputToStream
]

{ #category : 'initialization' }
ASImageOutput >> initialize [

	super initialize.
	pendingComponents := OrderedCollection new.
	components := IdentitySet new.
	objects := IdentityDictionary new.
	self context: self
]

{ #category : 'API' }
ASImageOutput >> literal: anObject [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
ASImageOutput >> name [

	^ componentName ifNil: [ componentName := ourObject selector ]
]

{ #category : 'components' }
ASImageOutput >> processComponents [

	| temp |
	[ pendingComponents isEmpty ] whileFalse: [
		temp := pendingComponents.
		pendingComponents := OrderedCollection new.
		temp do: [ :each | each generateCode ] ]
]

{ #category : 'visiting' }
ASImageOutput >> visitBranch: aBasicBlock [

	self
		branch;
		reference: aBasicBlock label
]

{ #category : 'visiting' }
ASImageOutput >> visitDrop [

	^ self drop
]

{ #category : 'API' }
ASImageOutput >> visitPopLocal: offset [

	^ self
		  popLocal;
		  literal: offset
]

{ #category : 'API' }
ASImageOutput >> visitPushLiteral: aLiteral [

	self
		pushLiteral;
		literal: aLiteral
]

{ #category : 'API' }
ASImageOutput >> visitPushLocal: offset [

	^ self
		  pushLocal;
		  literal: offset
]

{ #category : 'API' }
ASImageOutput >> visitReturnSelf: anOperator [

	^ self returnSelf
]

{ #category : 'API' }
ASImageOutput >> visitReturnTop: anObject [

	self returnTop
]

{ #category : 'API' }
ASImageOutput >> visitSend: aSelector returnIndex: index receiver: aClass [

	^ self
		  send;
		  literal: aSelector
]

{ #category : 'API' }
ASImageOutput >> visitStoreLocal: offset [

	^ self
		  storeLocal;
		  literal: offset
]

{ #category : 'API' }
ASImageOutput >> visitTailSend: aSelector receiver: aClass [

	^ self
		  tailSend;
		  literal: aSelector
]
