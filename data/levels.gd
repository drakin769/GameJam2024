{
	"first":
		{
		"solutions":
			{
			"EMPTY":	
				{
				"text": "No Power detected. Retrying experiment",
				"next_level": "first"
				},
			"Confirm Power":
				{
				"text": "Power Confirmed",
				"next_level": "second"
				}
			},
		"building_blocks":["Confirm Power"],
		"number_of_slots":1
		},
	"second":
		{
		"solutions":
			{
			"on left:on right":	
				{
				"text": "We be gaming people!",
				"next_level": "first"
				},
			"on right:on left":
				{
				"text": "oooo so close!",
				"next_level": "second"
				},
			"EMPTY:EMPTY":
				{
				"text": "Are... are you there?",
				"next_level": "second"
				}
			},
		"building_blocks":["on left","on right"],
		"number_of_slots":2
		}
}