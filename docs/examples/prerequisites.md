# Prerequisites to execute examples
Create conda environment:

	conda env create -f examples/environment.yml

Activate environment:

	conda activate chrysedgeexamples
	cd examples

Generate python grpc stubs:

	make examples
