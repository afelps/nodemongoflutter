# AppClient

A Flutter Todo App Project.
Simple, ugly, but (perhaps) functional.

## Getting Started

You should have a flutter environment setup, if not, head to [this Flutter page](https://flutter.dev/docs/get-started/install) 
to get help with that.

I should let you know right away that I built this using a Genymotion emulator since I have and AMD processor and Android Studio doesn't like it.
And since I kind of hardcoded the virtualbox interface's IP there might be some problems for running it on another emulator.
Anyway, if you feel like it you can get Genymotion in their [web page](https://www.genymotion.com/) and get a Personal License (like I did!).

With all of that out of the way you should be able to just run it on you emulator using Android Studio or Visual Studio.

## Functionality

The app has the simple functionality to manage a todo list, the catch is: *the database is not on your phone*.

Whats the point, you say? Well, you don't lose your stuff on changing phones, I suppose. 
I got caught up trying to learning some new stuff and kind of lost track of time to add users and authentication sadly.

Ok, so, the functionalities, sure. They are the standard *create delete edit* with and added *complete* and *uncompleted* that are just and disguised *edit* really.

## Problems

Well, I'm going to start with the main one: Even tough the app is functional there is this problem I couldn't figure out on time, and that is the new/old todo refresh. If you add a `TODO` and then hit `Refresh` for a moment the `TODO` list will grow (since it got the new stuff from the API), but won't actually set the values of the new `TODO` it will just repeat the first one. I did some debugging and found out that the widget that gets the list from the API *does* update the list up until it passes down to the widget that actually builds the `TODOs` itselves. Well, I read that the `setState()` function triggers the `build()` function for the Widget it's called in and its childs but clearly I must be doing something wrong here.

I didn't build a service layer so that might be part of the problem.

Well that's that. Other than that I can only say that I didn't follow any naming or structure conventions and some Widgets might have ended up with the Flutter equivalent of `callback hell`. It's really a shame, I couldn't finish it on time and ended up with an unfinished product that just happends to have some functionality to it.

There is a test class. I didn't touch it besides commenting it all out. I'd like to test it all but I barely (arguably) got the app running.