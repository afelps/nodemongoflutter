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

I started out with a lot of `setState` problems, the code was unorganized and had some refresh issues so that sometimes the Todo list wasn't updated correctly. I got rid of these problems by implementing the **bloc pattern** on the project. It was kind of a challenge but it worked out in the end.

Some problems persist tough:
- I didn't develop any tests
- Edit and Add form have duplicated code
- Edit and Add form don't have any kind of field validation

I think that's it for now. Didn't find that many problems this time but I plan on keep working on them.