package day_1

import "core:fmt"
import "core:os"
import "core:strconv"
import "core:strings"
import "core:unicode/utf8"

Cardinals :: enum {
	North,
	East,
	South,
	West,
}

Elf :: struct {
	direction: Cardinals,
	coords:    [2]int,
}

part_one :: proc(input: string) -> (blocks_away: int) {
	elf_head: Elf
	split := strings.split(input, " ")
	for instruct in split {
		runified := utf8.string_to_runes(instruct)
		switch runified[0] {
		case 'R':
			elf_head.direction =
				int(elf_head.direction) + 1 > 3 ? Cardinals(0) : Cardinals(int(elf_head.direction) + 1)
		case 'L':
			elf_head.direction =
				int(elf_head.direction) - 1 < 0 ? Cardinals(3) : Cardinals(int(elf_head.direction) - 1)
		}

		move, ok := strconv.parse_int(utf8.runes_to_string(runified[1:len(runified) - 1]))
		if !ok {
			fmt.println("move: ", move, "\nruniefied: ", runified, "\nelf: ", elf_head)
			fmt.println("***********************************************")
		}
		switch elf_head.direction {
		case .North:
			elf_head.coords.y = elf_head.coords.y + move
		case .South:
			elf_head.coords.y = elf_head.coords.y - move
		case .East:
			elf_head.coords.x = elf_head.coords.x + move
		case .West:
			elf_head.coords.x = elf_head.coords.x - move
		}
	}
	return abs(elf_head.coords.x) + abs(elf_head.coords.y)
}

part_two :: proc(input: string) -> (first_double_visit: int) {
	visited := make(map[[2]int]bool)
	elf_head: Elf
	split := strings.split(input, " ")
	for instruct in split {
		runified := utf8.string_to_runes(instruct)
		switch runified[0] {
		case 'R':
			elf_head.direction =
				int(elf_head.direction) + 1 > 3 ? Cardinals(0) : Cardinals(int(elf_head.direction) + 1)
		case 'L':
			elf_head.direction =
				int(elf_head.direction) - 1 < 0 ? Cardinals(3) : Cardinals(int(elf_head.direction) - 1)
		}

		move, ok := strconv.parse_int(utf8.runes_to_string(runified[1:len(runified) - 1]))
		if !ok {
			fmt.println("move: ", move, "\nruniefied: ", runified, "\nelf: ", elf_head)
			fmt.println("***********************************************")
		}
		switch elf_head.direction {
		case .North:
			for _ in 0 ..< move {
				elf_head.coords.y = elf_head.coords.y + 1
				if _, ok := visited[elf_head.coords]; !ok {
					visited[elf_head.coords] = true
				} else {return abs(elf_head.coords.x) + abs(elf_head.coords.y)}
			}
		case .South:
			for _ in 0 ..< move {
				elf_head.coords.y = elf_head.coords.y - 1
				if _, ok := visited[elf_head.coords]; !ok {
					visited[elf_head.coords] = true
				} else {return abs(elf_head.coords.x) + abs(elf_head.coords.y)}
			}
		case .East:
			for _ in 0 ..< move {
				elf_head.coords.x = elf_head.coords.x + 1
				if _, ok := visited[elf_head.coords]; !ok {
					visited[elf_head.coords] = true
				} else {return abs(elf_head.coords.x) + abs(elf_head.coords.y)}
			}
		case .West:
			for _ in 0 ..< move {
				elf_head.coords.x = elf_head.coords.x - 1
				if _, ok := visited[elf_head.coords]; !ok {
					visited[elf_head.coords] = true
				} else {return abs(elf_head.coords.x) + abs(elf_head.coords.y)}
			}
		}
	}
	return
}

main :: proc() {
	if len(os.args) != 2 {
		fmt.println("Insufficient arguments:\n<program_name> <input_file_path>")
		os.exit(1)
	}

	file, ok := os.read_entire_file_from_filename(os.args[1])
	if !ok {
		fmt.println("File Read Error")
		os.exit(2)
	}

	fmt.println("2016_1_1: ", part_one(string(file)))
	fmt.println("2016_1_2: ", part_two(string(file)))
}
