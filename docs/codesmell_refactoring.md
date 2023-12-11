### A discussion was had about the nessecity of code smell documentation. I will include question and response provided by the professor:
From: W. Brooks Arthur, To: Samuel Cho
Hello professor,

I was wondering if we are required to provide code smells and refactoring for the individual project in ASE456. It is my understanding that it is not required for the group assignment given that 456 and 420 are not prerequisites of one another, but the requirements for the individual project still list code smells and refactoring as required.

Any information on this would be greatly appreciated,
thank you,

From: Samuel Cho, To: W. Brooks Arthur
Brooks, 

First of all, I believe we, software engineers, must smell code whenever we make code and implement features.

The requirements for the individual project still list code smells and refactoring as required.
Having said that, I ask students to write down whatever they sense code smells or make refactoring whenever necessary.
If a student doesn’t/can’t sense code smells or refactoring, I know it’s not good, but I can understand the situation by adding, “I do want you to sense code smells and refactoring as a part of your job.” In short, we don’t do a points deduction game, but understanding software design or cross-platform development game. 

So, a student can make a note, “I couldn’t sense code smells or refactoring,” when they didn’t sense or refactor anything. That’s enough for me. 

I hope I answered your question. If not, please let me know.

## Code Smell: Large Method
* Found in the main scaffold structure in the main app. Refactored by moving textfield builder and elevated button builders to their own methods: Extract Metod

## Bloaters:
* Long Method: The build method in _TimeTrackerScreenState is quite long. Considering to breaking it down into smaller, more focused methods.

## Dispensables:
* Duplicate Code: The code for creating TextField widgets is repeated multiple times. I will consider creating a method to generate these fields to reduce duplication.

## Couplers:
* Feature Envy: The saveTimeEntry method has a dependency on the specific structure of the Firestore and uses controllers directly. I will consider refactoring to reduce coupling and improve testability.

## Other Smells:
* No other smells were detected during the refactoring process of this project.