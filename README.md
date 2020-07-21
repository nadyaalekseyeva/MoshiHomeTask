# MoshiHomeTask

Home task project for Moshi

Done using Xcode Version 12.0 beta 2

Designed using MVP architecture, where presenter is responsible for business logic.

Interactor is responsible for working with networking layer (and persistence layer if present) and also makes it easier to write unit tests (by mocking interactor).

Flow is responsible for screens navigation (ideally navigation controller would be covered with protocol which will make it possible to unit test flows as well, but it wasn't done)

UI was done completely programmatically using UIKit.

Models:
- response object (dtos) - object which represents data that comes from the server
- domain object - plain object which is used by presenters and views

Possible improvements in the future (if required):
- Add persistence layer (CoreData for example)
- Add unit test (code is done the way it would be possible to add unit tests)
- More detailed 'Details' screen
