Implemented:
- All basic requirements
- Allows user to change size and color of each line when drawing
- User can share drawings
	- With this I was given the ability to save the image for free
	- I started the project without using Core Data so I decided not to do the save
	  given the time. It would be a pretty easy implementation in Core Data, but it would
	  take more time than I have right now.

Important classes I created:
- YADACanvas
	- This is the view that the lines are drawn onto.
- YADALine
	- This is the line itself. It contains an array of the points and a color associated
	  with the line.
	- In this class, I created a protocol that would alert the canvas any time a point was
	  added to the line. That way, the canvas could then update itself appropriately to
	  add the point to the line.
	  
Technologies I used:
- Universal app (both iPhone and iPad are supported)
- Autolayout (landscape and portrait are both supported)

Known Bugs:
- The lines/drawings don't resize well on rotation
- Along the same lines, if you draw lines in one rotation, rotate the device, and press
  the undo button, lines move around.
- It is also drawing related, but the brush preview takes a moment to appear
	- I refresh the drawing on viewDidAppear instead of viewWillAppear because the preview
	  was distorted if it rendered in viewWillAppear.
	  
