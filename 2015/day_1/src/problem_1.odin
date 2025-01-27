package day_1

import "core:fmt"
import "core:os"
import "core:strings"


main :: proc() {
	// stuff
	if len(os.args) < 2 || len(os.args) > 2 {
		fmt.println("I exited at the os args check")
		os.exit(1)
	}
	input, ok := os.read_entire_file_from_filename(os.args[1])
	if !ok {
		fmt.println("I exited at the readfile check", os.args)
		os.exit(1)
	}
	str_input := string(input)

	// actual solution
	floor := 0
	prob_2_check: bool
	for chr, ind in str_input {
		if floor == -1 && !prob_2_check {
			fmt.println("Problem 2::", "Floor:", floor, "Position:", ind)
			prob_2_check = !prob_2_check
		}
		switch chr {
		case '(':
			floor = floor + 1
		case ')':
			floor = floor - 1
		}
	}
	fmt.println("Problem 1::", floor)

}
