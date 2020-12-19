# Executing basic usage script

List all stream processes:

	python basic_usage.py --list

Successful output example:

	name: "test"
	status: "running"
	pid: 18109
	running: true

Output single streaming frame information from `test` camera:

	python basic_usage.py --device test

Successful output example:

	is keyframe:  False
	frame type:  P
	frame shape:  dim {
	  size: 480
	  name: "0"
	}
	dim {
	  size: 640
	  name: "1"
	}
	dim {
	  size: 3
	  name: "2"
	}
	
- is_keyframe: True/False
- frame type: I,P,B
- frame shape: Image dimensions, disaplyed always in BGR24 format
	- In this example: `480x640x3 bgr24`

