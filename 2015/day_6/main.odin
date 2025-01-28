package day_6

import "core:fmt"
import "core:os"
import "core:strconv"
import "core:strings"

light_grid: [1000][1000]int

Instruct :: enum {
	On,
	Off,
	Toggle,
}

Instruction :: struct {
	instruct: Instruct,
	start, end: [2]int,
}

get_line_instruction :: proc(input: string) -> (instruction: Instruction) {
	if strings.contains(input, "turn on") {
		start := strings.split(input, " ")[2]
		end := strings.split(input, " ")[4]
		start_x := strconv.atoi(strings.split(start, ",")[0])
		start_y := strconv.atoi(strings.split(start, ",")[1])
		end_x := strconv.atoi(strings.split(end, ",")[0])
		end_y := strconv.atoi(strings.split(end, ",")[1])

		instruction = Instruction {
			instruct = .On, 
			start = {start_x, start_y},
			end = {end_x, end_y},
		}
	}
	else if strings.contains(input, "turn off") {
		start := strings.split(input, " ")[2]
		end := strings.split(input, " ")[4]
		start_x := strconv.atoi(strings.split(start, ",")[0])
		start_y := strconv.atoi(strings.split(start, ",")[1])
		end_x := strconv.atoi(strings.split(end, ",")[0])
		end_y := strconv.atoi(strings.split(end, ",")[1])

		instruction = Instruction {
			instruct = .Off, 
			start = {start_x, start_y},
			end = {end_x, end_y},
		}
	}
	else if strings.contains(input, "toggle") {
		start := strings.split(input, " ")[1]
		end := strings.split(input, " ")[3]
		start_x := strconv.atoi(strings.split(start, ",")[0])
		start_y := strconv.atoi(strings.split(start, ",")[1])
		end_x := strconv.atoi(strings.split(end, ",")[0])
		end_y := strconv.atoi(strings.split(end, ",")[1])

		instruction = Instruction {
			instruct = .Toggle, 
			start = {start_x, start_y},
			end = {end_x, end_y},
		}

	}
	return
}

part_one :: proc(input: string) -> (total_lights: int) {
	split := strings.split_lines(input)
	for line in split {
		if len(line) < 1 {continue}
		instruct := get_line_instruction(line)
		for x in instruct.start.x ..= instruct.end.x {
			for y in instruct.start.y ..= instruct.end.y {
				switch instruct.instruct {
				case .Toggle:
					light_grid[x][y] = light_grid[x][y] > 0 ? -1 : 1
				case .Off:
					light_grid[x][y] = -1
				case .On:
					light_grid[x][y] = 1
				}
			}
		}
	}

	for row in light_grid {
		for light in row {
			if light > 0 {
				total_lights = total_lights + 1
			}
		}
	}
	return
}

part_two :: proc(input: string) -> (total_brightness: int) {
	split := strings.split_lines(input)
	for line in split {
		if len(line) < 1 {continue}
		instruct := get_line_instruction(line)
		for x in instruct.start.x ..= instruct.end.x {
			for y in instruct.start.y ..= instruct.end.y {
				switch instruct.instruct {
				case .Toggle:
					light_grid[x][y] = light_grid[x][y] + 2
				case .Off:
					light_grid[x][y] = light_grid[x][y] > 0 ? light_grid[x][y] - 1 : 0
				case .On:
					light_grid[x][y] = light_grid[x][y] + 1
				}
			}
		}
	}

	for row in light_grid {
		for light in row {
			total_brightness = total_brightness + light
		}
	}
	return
}

setup_grid :: proc() {
	for row,x in light_grid {
		for _,y in row {
			light_grid[x][y] = 0
		}
	}
}


main :: proc() {
	if len(os.args) != 2 {os.exit(1)}
	file, ok := os.read_entire_file_from_filename(os.args[1])
	if !ok {os.exit(2)}

	setup_grid()
	part_1 := part_one(string(file))
	fmt.println("Day 6 - Part 1:", part_1)

	setup_grid()
	part_2 := part_two(string(file))
	fmt.println("Day 6 - Part 2:", part_2)
}
