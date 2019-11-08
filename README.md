# FrameIO
Frame.io sample project I created for their interview process. This uses no external libraries and is backwards compatible up to iOS 12.0, built on Xcode 11.2

This sample project consists of the following:
1) Recent list of all shows by their updated time
2) Shows in sections separated by their network

This project is meant to demonstrate modeling, networking and data binding

# Refactor wishes

1) I would've preferred to make a persistent data structure in Core Data that would explicitly define the relationships from one object to the other
2) Some of the code in my networking result block could've been a bit more modular. I would've separated them into easier to read methods. Instead I added comments.
3) I would've attempted to work with more of an MVVM architecture to have more separation between the data, data parsing, and the view itself. I had to modify the data a few times, once with the update date of the show. I had to reorder the projects by time, and also organize projects into teams. This would be better siloed off into a viewmodel.  
4) I would've liked to add some test cases to check that I wasn't breaking anything as I went along. 
