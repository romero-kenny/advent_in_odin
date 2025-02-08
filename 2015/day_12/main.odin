package day_twelve

import "core:fmt"
import "core:os"
import "core:strconv"
import "core:strings"
import "core:unicode/utf8"


part_one :: proc(input: string) -> (total_num: int) {
	buffer: [64]byte
	num_builder := strings.builder_from_bytes(buffer[:])

	// in_quotes: bool
	for char in input {
		// "You will not encounter any strings containing numbers"
		// if char == '"' {in_quotes = !in_quotes}
		// if in_quotes {continue}
		switch char {
		case '-', '0' ..= '9':
			strings.write_rune(&num_builder, char)
		case:
			to_int, ok := strconv.parse_int(strings.to_string(num_builder))
			if ok {
				total_num = total_num + to_int
			}
			strings.builder_reset(&num_builder)
		}
	}
	return
}


// probably need to do some whacky bullshit to do this one
// or just check if we're still in an object
part_two :: proc(input: string) -> (total_num: int) {
	// do later, unable to figure it out
	return
}

main :: proc() {
	if len(os.args) != 2 {os.exit(1)}
	file, ok := os.read_entire_file_from_filename(os.args[1])
	if !ok {os.exit(2)}
	fmt.println(part_one(string(file)))
	fmt.println(part_two(string(file)))
}
