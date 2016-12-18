# UITextView-on-Qt
demonstrates how one can embed a native IOS View in a QWidget base Qt application.
The technique is to have a 'fake' QFrame as a place holder where the native UIView gets its coordinates from.
In the QFrame::event override Move and ResizeEvents cause the native UIView placed exactly over the fake frame.
