package day_3

import "core:fmt"
import "core:os"
import "core:strconv"
import "core:strings"


part_one :: proc(input: string) -> (at_least_1: int) {
	tracker := make(map[[2]int]int)
	santa_pos: [2]int
	tracker[santa_pos] = 1
	at_least_1 = 1

	for chr in input {
		switch chr {
		case '^':
			santa_pos.y = santa_pos.y + 1
		case 'v':
			santa_pos.y = santa_pos.y - 1
		case '<':
			santa_pos.x = santa_pos.x - 1
		case '>':
			santa_pos.x = santa_pos.x + 1
		}
		tracker[santa_pos] = tracker[santa_pos] + 1
		if tracker[santa_pos] == 1 {
			at_least_1 = at_least_1 + 1
		}
	}
	return
}

part_two :: proc(input: string) -> (at_least_1: int) {
	tracker := make(map[[2]int]int)
	santa_pos, robo_pos: [2]int
	tracker[santa_pos] = 1
	at_least_1 = 1

	mut_pos := &santa_pos
	for chr in input {
		if mut_pos^ != santa_pos {
			mut_pos = &santa_pos
		} else {mut_pos = &robo_pos}

		switch chr {
		case '^':
			mut_pos.y = mut_pos.y + 1
		case 'v':
			mut_pos.y = mut_pos.y - 1
		case '<':
			mut_pos.x = mut_pos.x - 1
		case '>':
			mut_pos.x = mut_pos.x + 1
		}
		tracker[mut_pos^] = tracker[mut_pos^] + 1
		if tracker[mut_pos^] == 1 {
			at_least_1 = at_least_1 + 1
		}

	}

	return
}

main :: proc() {
	if len(os.args) != 2 {
		os.exit(1)
	}
	file, ok := os.read_entire_file_from_filename(os.args[1])
	if !ok {
		os.exit(2)
	}
	input := string(file)

	part_1 := part_one(input)
	fmt.println("Day 3 - Part 1:", part_1)

	part_2 := part_two(input)
	fmt.println("Day 3 - Part 2:", part_2)
}
