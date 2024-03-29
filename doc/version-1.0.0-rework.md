# Version 1.0.0 rework of Pin Lock

## Introduction
The current implementation of Pin Lock package is in essence too complicated. We like what the Pin Lock package accomplishes, but it should be easier to implement as a developer. We want to trim down the workigns of the Pin Lock package to its essentials while giving developers more freedom in how to achieve actions with pin locking.

## Current functionality

- lock state management (locked/unlocked/blocked etc.)
- support multiple authentication forms (biometric, numeric pin, password?)
- support multiple platforms (android, ios)
- support easy way to setup screens (not to oppionated)
- Offer lifecycle hooks (app background, lock after x minutes) (locking strategy??)
- multi user per app
- reset/forget pin option
- feature locking (block features until unlocked)

### State machine of functionality
  
![Plant UML of statemachine: https://www.plantuml.com/plantuml/png/SoWkIImgAStDuIfEJin9LJ0pC50epqmfoU3YYjQALT3LjLC8pSlCoop9JCp9B4vDWOlwv2Td0xaeab3bEM0f1Ik5uDIIqW8ka4eCEIWJMT899WTXSS4Kepi2h2GeDJU_B1LLZGzKFvZ1vOHNTt5g2OeA7uIxaY0E8wJR8JKl1HXk0000](https://www.plantuml.com/plantuml/svg/SoWkIImgAStDuIfEJin9LJ0pC50epqmfoU3YYjQALT3LjLC8pSlCoop9JCp9B4vDWOlwv2Td0xaeab3bEM0f1Ik5uDIIqW8ka4eCEIWJMT899WTXSS4Kepi2h2GeDJU_B1LLZGzKFvZ1vOHNTt5g2OeA7uIxaY0E8wJR8JKl1HXk0000https://www.plantuml.com/plantuml/svg/SoWkIImgAStDuIfEJin9LJ0pC50epqmfoU3YYjQALT3LjLC8pSlCoop9JCp9B4vDWOlwv2Td0xaeab3bEM0f1Ik5uDIIqW8ka4eCEIWJMT899WTXSS4Kepi2h2GeDJU_B1LLZGzKFvZ1vOHNTt5g2OeA7uIxaY0E8wJR8JKl1HXk0000)

## What should the pin_lock package be able to do?
- Seperate UI builder / logic
- “native” dart logic controller (locking/unlocking)
- Leaner on dependencies (no bloc/sharedprefs)
- proven by tests

## When is the 1.0.0 rework a success?
pin_lock 1.0.0 is a success when there is a solid foundation that is easily expandable and maintainable. An example of this is adding a new way of authentication without consequences for existing users.
For all functionality that is included in pin_lock package should be a clear use case. This helps guide us expand and improve pin_lock in the future.



# Proposed new solution
- Provide a top level controller that you can provide over your complete app. This should be available through context to check if your app is locked and help you unlock it.
- Widget helpers should be available but be optional in using pin_lock. These widgets enable the developer to show building blocks for the pinlock flow. However, these functions should be able to be called by the developer in a way however they want. These widgets could be:
  
  -- LockedContainer which has 2 children; a locked child and an unlocked child to easily show locked / unlocked content. We should also keep navigation in mind. Sometimes you don't want to show a widget but call a navigation function.

  -- Setup widget that helps you with setting a pincode.

  -- Enter pincode widget that helps you with unlocking the pin mechanism and showing block state.

- Provide a helper that enables the developer to choose from multiple types of unlocking (password, pincode, biometric, endless possibilities) and help store and match them for locking and unlocking the top level lock controller. This should provide a abstraction layer for saving data, but the developer should implement a way of storage for themselves. We could provide a good example with flutter_secure_storage, but we won't include it in the pacakge, as storing itself is not in scope of pin_lock. This improves maintainability a lot.