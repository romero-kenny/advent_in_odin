package day_2

import "core:fmt"
import "core:os"
import "core:strconv"
import "core:strings"



part_one :: proc(input: string) -> (passcode: int) {
	// hardest part for me is trying to figure out how to represent the keypad
	split := strings.split_lines(input)
	curr_key := 5
	for line in split {
		if len(line) < 1 { continue }
		for char in line {
			switch char {
			case 'U':
				curr_key = curr_key - 3 >= 1 ? curr_key - 3 : curr_key
			case 'L':
				switch curr_key {
				case 1, 4, 7:
				case:
					curr_key = curr_key - 1
				}
			case 'R':
				switch curr_key {
				case 3, 6, 9:
				case:
					curr_key = curr_key + 1
				}
			case 'D':
				curr_key = curr_key + 3 <= 9 ? curr_key + 3 : curr_key
			}
			//fmt.println(char, curr_key)
		}
		//fmt.println("************************")
		passcode = (10 * passcode) + curr_key
	}
	return
}


main :: proc() {
	if len(os.args) != 2 {
		fmt.println("Wrong Number of Arguments:\n <program> <filepath>")
		os.exit(1)
	}
	file, ok := os.read_entire_file_from_filename(os.args[1])
	if !ok {
		fmt.println("File Not Found")
		os.exit(2)
	}
	fmt.println("2016_2_1: ", part_one(string(file)))
}
