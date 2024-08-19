Levels are now generated from this file in the following structure.

{
	"LEVEL NAME":
		{
		"solutions":
			{
			"SOLUTION ONE CODE": ### made up of the blocks used to get to this solution, with : between them such as the below example	
				{
				"text": "THIS IS THE TEXT SENT TO THE CONSOLE",
				"next_level": "THIS IS THE LEVEL NAME OF THE NEXT LEVEL TO BE LOADED IN"
				},
			"LEFT BLOCK:RIGHT BLOCK":
				{
				"text": "You put the Left block left and the right block right",
				"next_level": "second"
				}
			},
		"building_blocks":["LEFT BLOCK","RIGHT BLOCK","ANY OTHER INSTRUCTION BLOCKS, max of 10"], # despite these examples, please use lower case
		"number_of_slots":1 #number of slots loaded for the level, max of 10
		}
	...
}

Levels do not need to follow an order, we CAN now easily do a pick a path idea, we each can make our own whole paths for the game! multiple endings!

Make a copy of the levels file and play around with it :)

We also need to have a string which is a file path added to the levels in this, so to add images.
