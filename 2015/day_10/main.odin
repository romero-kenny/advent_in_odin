package day_ten

import "core:fmt"
import "core:os"
import "core:strconv"
import "core:strings"
import "core:time"

look_and_say_generator :: proc(input: string) -> (output: string) {
	builder := strings.builder_make_none()

	for i := 0; i < len(input); {
		char_count := 1
		inner: for j in (i + 1) ..< len(input) {
			if input[i] == input[j] {char_count = char_count + 1}
			else {break inner}
		}
		if input[i] >= '0' && input[i] <= '9' {
			strings.write_rune(&builder, rune(char_count) + '0')
		}
		strings.write_rune(&builder, rune(input[i]))
		i = i + char_count
	}
	output = strings.trim_space(strings.trim_null(strings.to_string(builder)))
	return
}

part_one :: proc(input: string, iter_num: int) -> (length: int) {
	curr := input
	for n in 0 ..< iter_num {
		curr = look_and_say_generator(curr)
	}
	return len(curr)
}

main :: proc() {
	if len(os.args) != 3 {os.exit(1)}
	iters, _ := strconv.parse_int(os.args[2])
	file, ok := os.read_entire_file_from_filename(os.args[1])
	if !ok {os.exit(2)}
	fmt.println("Day 9 - Part 1:", part_one(string(file), iters))
}
