package day_2

import "core:fmt"
import "core:os"
import "core:strconv"
import "core:strings"


// l = x, w = y, h = z
// imma assume my input is always going to be something I can work with
get_dimensions :: proc(str_line: string) -> (dimensions: [3]int) {
	if len(str_line) > 0 {
		temp := strings.split_after(str_line, "x")
		defer delete(temp)
		dimensions.x = strconv.atoi(temp[0])
		dimensions.y = strconv.atoi(temp[1])
		dimensions.z = strconv.atoi(temp[2])
	}
	return
}


problem_one_solver :: proc(split_file: []string) -> (total: int) {
	for line, ind in split_file {
		xyz := get_dimensions(line)
		xy, yz, zx := (2 * xyz.x * xyz.y) , (2 * xyz.y * xyz.z) , (2 * xyz.z * xyz.x) 
		slack: int
		if xy <= yz && xy <= zx { slack = xy }
		if yz <= xy && yz <= zx { slack = yz }
		if zx <= xy && zx <= yz { slack = zx }
		line_total := xy + yz + zx + (slack / 2)
		total = line_total + total
		// fmt.println(ind, "Line Total:", line_total, "Total:", total, "xy:", xy, "yz:", yz, "zx:", zx, "dimensions:", xyz, "slack:", slack)
	}
	return 
}

problem_two_solver :: proc(split_file: []string) -> (total: int) {
	for line, ind in split_file {
		// fmt.println("RUnning...")
		xyz := get_dimensions(line)
		// sorts the dimensions by smallest to largest
		for i in 1..<len(xyz) {
			if xyz[i - 1] > xyz[i] {
				x := xyz[i]
				xyz[i] = xyz[i - 1]
				xyz[i - 1] = x
			}
		}

		line_ribbon := (2 * xyz[0]) + ( 2 * xyz[1]) + (xyz.x * xyz.y * xyz.z)
		total = line_ribbon + total
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
	split := strings.split_lines(string(file))

	problem_one := problem_one_solver(split)
	fmt.println("Problem 1:", problem_one)

	problem_two := problem_two_solver(split)
	fmt.println("Problem 2:", problem_two)
}
